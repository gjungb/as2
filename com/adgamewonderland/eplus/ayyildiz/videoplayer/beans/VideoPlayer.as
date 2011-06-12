/**
 * @author gerd
 */

import mx.utils.Delegate;

import com.adgamewonderland.agw.util.XMLConnector;
 
import com.adgamewonderland.agw.net.RemotingBeanCaster;

import de.kruesch.event.*;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.VideoPlayer {
	
	private static var _instance:VideoPlayer;
	
	private static var ITEMS:String = "xml/ayyildiz_videoplayer_items.xml";
	
	private var videoitems:Array;
	
	private var item:VideoItem;
	
	private var _event:EventBroadcaster;
	
	private var nc:NetConnection;
	
	private var ns:NetStream;
	
	private var interval:Number;
	
	private var language:Number;
	
	public static function getInstance():VideoPlayer {
		if (_instance == null)
			_instance = new VideoPlayer();
		return _instance;
	}
	
	private function VideoPlayer() {
		// items
		this.videoitems = new Array();
		// event handling
		_event = new EventBroadcaster();
		// net connection
		nc = new NetConnection();
		// verbinden
		nc.connect(null);
		// net stream
		ns = new NetStream(nc);
		// status handler
		ns.onStatus = Delegate.create(this, onNsStatus);
		// meta data handler (http://livedocs.macromedia.com/fms/2/docs/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00000584.html)
		ns.onMetaData = Delegate.create(this, onNsMetaData);
		// language
		this.language = 1;
	}
	
	public function addListener(l ):Void
	{
		_event.addListener(l);
	}
	
	public function removeListener(l ):Void
	{
		_event.removeListener(l);
	}
	
	public function loadItems():Void
	{
		// connector
		var conn:XMLConnector = new XMLConnector(this, ITEMS);
		// laden
		conn.loadXML("onItemsLoaded");
	}
	
	public function onItemsLoaded(xmlobj:XML ):Void
	{
		// connector
		var conn:XMLConnector = new XMLConnector(null, null);
		// items
		var itemsXML:XMLNode = xmlobj.firstChild;
		// aktuelles xml
		var itemXML:XMLNode;
		// item
		var item:VideoItem;
		// schleife ueber einzelne items
		for (var i:Number = 0; i < itemsXML.childNodes.length; i++) {
			// aktuelles xml
			itemXML = itemsXML.childNodes[i];
			// item casten
			item = VideoItem(RemotingBeanCaster.getCastedInstance(new VideoItem(), conn.parseXMLNode(itemXML)));
			// id setzen
			item.setId(i);
			// descriptions parsen
			item.parseDescriptions(itemXML.childNodes);
			// speichern
			this.videoitems[i] = item;
		}
		// event
		_event.send("onItemsParsed", this.videoitems);
	}
	
	public function changeItem(item:VideoItem ):Void
	{
		// speichern
		setItem(item);
		// stoppen
		stopVideo();
		// event
		_event.send("onChangeItem", getItem());
		// abspielen
		startVideo();
	}
	
	public function startVideo():Void
	{
		// abspielen
		getNs().play(getItem().getFile());
		// abspielen verfolgen
		this.interval = setInterval(this, "followVideo", 100);
		// event
		_event.send("onStartVideo");
	}
	
	public function stopVideo():Void
	{
		// stoppen und zurueck spulen
		getNs().pause(true);
		getNs().seek(0);
		// abspielen verfolgen beenden
		clearInterval(this.interval);
		// event
		_event.send("onStopVideo");
	}
	
	public function pauseVideo(bool:Boolean ):Void
	{
		// testen, ob gestoppt
		if (!bool && getNs().time == 0) {
			// starten
			startVideo();	
		} else {
			// pausieren / abspielen
			getNs().pause(bool);
		}
	}
	
	public function nextVideo():Void
	{
		// stoppen
		stopVideo();
		// aktuelles item
		var item:VideoItem = getItem();
		// naechstes item
		if (item.getId() + 1 == this.videoitems.length) {
			changeItem(this.videoitems[0]);
		} else {
			changeItem(this.videoitems[item.getId() + 1]);
		}
	}
	
	public function followVideo():Void
	{
		// prozent abgespielt
		var percent:Number = getNs().time / getItem().getDuration() * 100;
		// NaN abfangen
		if (isNaN(percent)) percent = 0;
		// testen, ob am ende
		if (Math.round(percent) >= 100) {
			// stoppen
			stopVideo();
		} else {
			// event
			_event.send("onVideoPlaying", percent);
		}
	}
	
	public function downloadVideo():Void
	{
		// event
		_event.send("onDownloadVideo", true);	
	}
	
	public function onCloseDownload():Void
	{
		// event
		_event.send("onDownloadVideo", false);
	}
	
	public function slideVideoStart():Void
	{
		// abspielen verfolgen beenden
		clearInterval(this.interval);
	}
	
	public function slideVideoSlide(percent:Number ):Void
	{
		// positionieren
		getNs().seek(Math.floor(percent / 100 * getItem().getDuration()));
	}
	
	public function slideVideoStop():Void
	{
		// abspielen verfolgen
		this.interval = setInterval(this, "followVideo", 100);
	}
	
	public function onNsStatus(info:Object ):Void
	{
//		for (var i : String in info) {
//			trace(i + ": " + info[i]);
//		}
	}
	
	public function onNsMetaData(info:Object ):Void
	{
		// dauer des videos speichern
		getItem().setDuration(Number(info["duration"]));
	}
	
	public function getNs():NetStream {
		return ns;
	}

	public function setNs(ns:NetStream):Void {
		this.ns = ns;
	}

	public function getItem():VideoItem {
		return item;
	}

	public function setItem(item:VideoItem):Void {
		this.item = item;
	}

	public function getLanguage():Number {
		return language;
	}

	public function setLanguage(language:String ):Void {
		if (language != undefined && language != "") this.language = Number(language);
	}

}