import mx.utils.Delegate;
import mx.video.FLVPlayback;
import mx.video.VideoPlayer;

import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoController;
import com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoControllerListener;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.VideocontrollerUI;

import flash.geom.Point;
import flash.geom.Rectangle;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.DurationUI;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoassetsController;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
import mx.utils.Collection;
import com.adgamewonderland.agw.util.Mask;
import mx.video.NCManager;
import mx.video.INCManager;

class com.adgamewonderland.eplus.vybe.videoplayer.ui.VideoplayerUI extends FLVPlayback implements IVideoControllerListener
{
	private var _playerx:Number;
	private var _playery:Number;
	private var _playerwidth:Number;
	private var _playerheight:Number;

	private var currentitem:AssetImpl;

	private var player:VideoPlayer;

	private var title_txt:TextField;

	private var duration_mc:DurationUI;

	public function VideoplayerUI() {
		// aktuell abgespieltes item
		this.currentitem = null;
		// konfigurieren
		autoPlay 	= true;
		autoRewind 	= false;
		autoSize 	= true;
		isLive		= true;
		bufferTime	= 2;
	}

	public function onLoad():Void
	{
		super.onLoad();
		// beim videocontroller als listener registrieren
		VideoController.getInstance().addListener(this);
		// beim videocontroller als playback registrieren
//		VideoController.getInstance().setVideoplayer(this);
		// player
		this.player = getVideoPlayer(activeVideoPlayerIndex);
		// positionieren
		this.player._x = _playerx;
		this.player._y = _playery;
		// skalieren
		setSize(_playerwidth, _playerheight);
		// maske fuer video
		var mask:Mask = new Mask(this, this.player, new com.adgamewonderland.agw.math.Rectangle(_playerx, _playery, _playerwidth, _playerheight));
		// maskieren
		mask.drawMask();
		// als listener bei sich selbst registrieren
		addEventListener("metadataReceived", onMetadataReceived);
		addEventListener("complete", onComplete);
		addEventListener("cuePoint", onCuepoint);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		VideoController.getInstance().removeListener(this);
	}

	/**
	 * registriert eine videocontroller-komponente mit den entsprechenden control-komponenten
	 * @param videocontroller instanz eines videocontrollerui
	 */
	public function registerVideocontroller(videocontroller:VideocontrollerUI ):Void
	{
		// controller-komponenten bei playback anmelden
		backButton 		= videocontroller.back_mc;
		pauseButton		= videocontroller.pause_mc;
		playButton		= videocontroller.play_mc;
		forwardButton 	= videocontroller.forward_mc;
		seekBar			= videocontroller.seek_mc;
		volumeBar		= videocontroller.volume_mc;
//		// back
//		backButton.onRelease = Delegate.create(this, doBack);
//		// forward
//		forwardButton.onRelease = Delegate.create(this, doForward);
	}

	/**
	 * callback bei klick auf button "back"
	 */
	public function doBack():Void
	{
		// testen, ob aktuelles video fortgeschritten ist
		if (playheadPercentage > 0) {
			// stoppen
			stop();
			// zum anfang des aktuellen videos springen
			seekPercent(0);

		} else {
			// vorhergehendes item in playlist abspielen
			VideoController.getInstance().prevItem();
		}
	}

	/**
	 * callback bei klick auf button "forward"
	 */
	public function doForward():Void
	{
		// naechstes item in playlist abspielen
		VideoController.getInstance().nextItem();
	}

	/**
	 * callback bei auswahl eines items zum abspielen
	 */
	public function onItemSelected(item:AssetImpl ):Void
	{

		// aktuell abgespieltes item
		setCurrentitem(item);
		// title des video anzeigen
		title_txt.html = true;
		title_txt.embedFonts = true;
		title_txt.htmlText = "<B>" + item.getArtistName() + ": " + item.getTitle() + "</B>";
		// flv-datei (inklusive Pfad)
		var flv:String = item.getClipfileUrl();

		trace(this.player);

//		this.player.ncMgrClassName = "com.adgamewonderland.eplus.vybe.videoplayer.managers.NCManagerImpl";
		// uebergeben
//		this.contentPath = flv;
//		this.contentPath = "rtmpt://flash.media.universal-music.de:80/umusicstream//autofill/s/1/2/6/9/content/formats/111772/UMD_David_Bisbal_Vybe_Top_Ten.mov.flv";
		this.contentPath = "rtmpt://flash.media.universal-music.de:80/umusicstream/manual/digital/UMD_TopTen_Panda.flv";

//		this.player.ncMgrClassName = "com.adgamewonderland.eplus.vybe.videoplayer.managers.NCManagerImpl";
		trace("onItemSelected: " + contentPath);

//		this.player.play("rtmpt://flash.media.universal-music.de:80/umusicstream/manual/digital/UMD_TopTen_Panda", true);


//		for (var i in ncMgr) trace(i + ": " + ncMgr[i]);

		trace("rtmp: " + ncMgr.isRTMP());

		trace("streamName: " + ncMgr.getStreamName());

		var my_video:Video;


		var doTrace:Function = function(mc:VideoplayerUI ):Void
		{
			var mgr:NCManager = NCManager(mc.ncMgr);
			var connection_nc:NetConnection = mgr.getNetConnection();
//			connection_nc.close();
//			connection_nc.connect("rtmpt://flash.media.universal-music.de:80/umusicstream/");

//			connection_nc.onStatus = function(info)
//			{
//				for (var i in info) trace("NetConnection: " + i + ": " + info[i]);
//			};
//
//			var stream_ns:NetStream = new NetStream(connection_nc);
//
//			my_video.attachVideo(stream_ns);
//
//			stream_ns.onStatus = function(info)
//			{
//				trace("onStatus");
//				for (var i in info) trace("NetStream: " + i + ": " + info[i]);
//			};
//			stream_ns.onMetaData = function(metadata)
//			{
//				trace("onMetaData");
//				for (var i in metadata) trace("NetStream: " + i + ": " + metadata[i]);
//			};
//			stream_ns.play("manual/digital/UMD_TopTen_Panda.flv");
			trace(mgr.getNetConnection().isConnected);
			trace(mgr.getNetConnection().uri);
			trace(mgr.getStreamName());
//			clearInterval(interval);
		};

		var interval:Number = setInterval(doTrace, 5000, this);



		// abspielen
//		this.play();
	}

	public function onItemsPlayed(items:Collection ):Void
	{
	}

	/**
	 * callback nach laden der metadaten
	 * @param event
	 */
	public function onMetadataReceived(event:Object ):Void
	{
		// einblenden
		this.visible = true;
		// duration des video anzeigen
		duration_mc.showDuration(this.metadata.duration);
		// video positionieren
		if (!isNaN(Number(metadata.height)) && metadata.height < _playerheight) {
			// nach unten verschieben
			this.player.y += (_playerheight - metadata.height) / 2;
		}

//		for (var i : String in metadata) {
//			trace(i + ": " + metadata[i]);
//		}
	}

	/**
	 * callback nach abspielen eines videos
	 * @param event
	 */
	public function onComplete(event:Object ):Void
	{
		// naechstes item abspielen
		VideoController.getInstance().nextItem();
	}

	/**
	 * callback bei erreichen eines cuepoints
	 * @param event
	 */
	public function onCuepoint(event:Object ):Void
	{
		// testen, ob stopmark erreicht
		if (event.info.type = FLVPlayback.ACTIONSCRIPT && event.info.name == "stopmark") {
			// pause
			this.pause();
		}
	}

	/**
	 * gibt zurueck, ob der player ein video geladen hat
	 * @return Boolean gibt true zurueck, wenn ein video geladen ist, ansonsten false
	 */
	public function isVideoLoaded():Boolean
	{
		// contentPath pruefen
		return (contentPath != "");
	}

	/**
	 * gibt die aktuelle position des players zurueck
	 * @return Point aktuelle position des players auf der buehne
	 */
	public function getPlayerPosition():Point
	{
		// position
		var position:Point = new Point(this.player.x, this.player.y);
		// zurueck geben
		return position;
	}

	/**
	 * gibt die aktuelle position und groesse des players zurueck
	 * @return Rectangle der umriss des players
	 */
	public function getPlayerBounds():Rectangle
	{
		// umriss
		var bounds:Rectangle = new Rectangle(this.player.x, this.player.y, this.player.width, this.player.height);
		// zurueck geben
		return bounds;
	}

	public function setCurrentitem(currentitem:AssetImpl):Void
	{
		this.currentitem = currentitem;
	}

	public function getCurrentitem():AssetImpl
	{
		return this.currentitem;
	}

}