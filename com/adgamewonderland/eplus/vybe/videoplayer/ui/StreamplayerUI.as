import mx.controls.streamingmedia.StreamingMediaConstants;
import mx.utils.Collection;
import mx.utils.Delegate;

import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.StreamPlayer;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoController;
import com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoControllerListener;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.DurationUI;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.VideocontrollerUI;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.ui.StreamplayerUI extends MovieClip implements IVideoControllerListener {

	private var _playerx:Number;
	private var _playery:Number;
	private var _playerwidth:Number;
	private var _playerheight:Number;

	private var nc:NetConnection;

	private var ns:NetStream;

	private var videocontroller:VideocontrollerUI;

	private var player:StreamPlayer;

	private var currentitem:AssetImpl;

	private var duration:Number;

	private var snd:Sound;

	private var title_txt:TextField;

	private var duration_mc:DurationUI;

	public var _video:Video;

	function StreamplayerUI() {
		// player
		this.player = new StreamPlayer("", StreamingMediaConstants.FLV_MEDIA_TYPE, this, 0);
		// als listener registrieren
		this.player.addListener(this);
	}

	public function onLoad():Void
	{
		// beim videocontroller als listener registrieren
		VideoController.getInstance().addListener(this);
		// beim videocontroller als playback registrieren
		VideoController.getInstance().setVideoplayer(this);
		// net connection
		this.nc = new NetConnection();
		// status handler
		nc.onStatus = Delegate.create(this, onNcStatus);
		// globales sound object fuer lautstaerke
		this.snd = new Sound();
	}

	public function onItemSelected(item:AssetImpl ):Void
	{
		// title des video anzeigen
		title_txt.html = true;
		title_txt.embedFonts = true;
		title_txt.htmlText = "<B>" + item.getArtistName() + ": " + item.getTitle() + "</B>";

		// application (streaming-server)
		var application:String = item.getClipfileAplication();
		// file (pfad zum video auf streaming-server)
		var file:String = item.getClipfileFile();
		// abspielen
		playStream(application, file);

//		// flv-datei (inklusive Pfad)
//		var flv:String = item.getClipfileUrl();
//		// stoppen
//		this.player.stop();
//		// an player uebergeben
//		this.player.setMediaUrl(flv);
//
//		// abspielen
//		this.player.play();
	}

//	public function handlePlayer(player:StreamPlayer, status:String ):Void
//	{
//		// einblenden
//		_visible = true;
//	}

	public function onItemsPlayed(items : Collection) : Void {
	}

	public function onNcStatus(info:Object ):Void
	{
//		trace("onNcStatus");
//		for (var i in info) trace("NetConnection: " + i + ": " + info[i]);
	}

	public function onNsStatus(info:Object ):Void
	{
		// je nach code
		switch (info.code) {
			// abspielen
			case "NetStream.Play.Reset" :
				// buttons de- / aktivieren
				this.videocontroller.showButton(videocontroller.play_mc, false);
				this.videocontroller.showButton(videocontroller.pause_mc, true);
				this.videocontroller.showButton(videocontroller.back_mc, true);

				break;
			// pause starten
			case "NetStream.Pause.Notify" :
				// buttons de- / aktivieren
				this.videocontroller.showButton(videocontroller.play_mc, true);
				this.videocontroller.showButton(videocontroller.pause_mc, false);

				break;
			// pause beenden
			case "NetStream.Unpause.Notify" :
				// buttons de- / aktivieren
				this.videocontroller.showButton(videocontroller.play_mc, false);
				this.videocontroller.showButton(videocontroller.pause_mc, true);

				break;
			// seek
			case "NetStream.Seek.Notify" :

				break;
			// TODO: complete
			case "NetStream.Play.Stop" :
				VideoController.getInstance().nextItem();

				break;

			// debug
			default :
//				for (var i in info) trace("NetStream: " + i + ": " + info[i]);
		}
	}

	public function onNsMetaData(metadata:Object ):Void
	{
//		trace("onNsMetaData");
//		for (var i in metadata) trace("NetStream: " + i + ": " + metadata[i]);

		// dauer anzeigen
		duration_mc.showDuration(metadata["duration"]);
	}

	private function playStream(application:String, file:String ):Void
	{
		// muss eine neue connection aufgebaut werden
		var reconnect:Boolean = false;
		// pruefen, ob nc connected
		if (this.nc.isConnected) {
			// pruefen, mit wem
			if (this.nc.uri != application) {
				// neue connection
				reconnect = true;
			}
		} else {
			// neue connection
			reconnect = true;
		}
		// connecten
		if (reconnect == true) {
			this.nc.connect(application);
		}
		// stream loeschen
		delete(this.ns);
		// neuer stream
		this.ns = new NetStream(this.nc);
		// status handler
		ns.onStatus = Delegate.create(this, onNsStatus);
		// meta data handler (http://livedocs.macromedia.com/fms/2/docs/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00000584.html)
		ns.onMetaData = Delegate.create(this, onNsMetaData);
		// stream an video uebergeben
		_video.attachVideo(ns);
		// positionieren
		_video._x = _playerx;
		_video._y = _playery;
		// buffer time niedrig halten, damit buffer nicht zu voll wird
		this.ns.setBufferTime(0.1);
		// abspielen
		this.ns.play(file);
	}

	/**
	 * registriert eine videocontroller-komponente mit den entsprechenden control-komponenten
	 * @param videocontroller instanz eines videocontrollerui
	 */
	public function registerVideocontroller(videocontroller:VideocontrollerUI ):Void
	{
		// controller
		this.videocontroller = videocontroller;
		// controller-komponenten bei playback anmelden
		videocontroller.back_mc.onRelease = Delegate.create(this, doBack);
		videocontroller.pause_mc.onRelease = Delegate.create(this, doPause);
		videocontroller.play_mc.onRelease = Delegate.create(this, doPlay);
//		forwardButton 	= videocontroller.forward_mc;
//		seekBar			= videocontroller.seek_mc;
		videocontroller.volume_mc.onEnterFrame = Delegate.create(this, doUpdateVolume);
//		// back
//		backButton.onRelease = Delegate.create(this, doBack);
//		// forward
//		forwardButton.onRelease = Delegate.create(this, doForward);

		// buttons de- / aktivieren
		this.videocontroller.showButton(videocontroller.play_mc, false);
		this.videocontroller.showButton(videocontroller.pause_mc, false);
		this.videocontroller.showButton(videocontroller.back_mc, false);
	}

	public function isVideoLoaded() : Boolean {
		return this.nc.isConnected;
	}

	public function stopVideo() : Void {
		doPause();
	}

	public function seekPercent(percent : Number) : Void {
		if (percent == 0) doBack();
	}

	private function doBack() : Void {
//		this.player.setPlayheadTime(0);
		// stream auf anfang
		this.ns.seek(0);
	}

	private function doPause() : Void {
//		this.player.pause();
		// stream pausieren
		this.ns.pause(true);
	}

	private function doPlay() : Void {
//		if (!this.player.isPlaying()) this.player.play();
		// stream abspielen
		this.ns.pause(false);
	}

	private function doUpdateVolume() : Void {
		// lautstaerke updaten
		this.snd.setVolume(this.videocontroller.volume_mc.getVolume());
	}

}