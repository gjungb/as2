import mx.utils.Delegate;
import mx.video.FLVPlayback;
import mx.video.VideoPlayer;

import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.interfaces.IVideoControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.ui.player.VideocontrollerUI;
import flash.geom.Point;
import flash.geom.Rectangle;

class com.adgamewonderland.ea.nextlevel.ui.player.VideoplayerUI extends FLVPlayback implements IVideoControllerListener
{
	private var _playerx:Number;
	private var _playery:Number;
	private var _playerwidth:Number;
	private var _playerheight:Number;

	private var currentitem:PlaylistVideoItem;
	private var loopcount:Number;
	private var player:VideoPlayer;

	/**
	 * abstrakter konstruktor
	 */
	private function VideoplayerUI() {
		// aktuell abgespieltes item
		this.currentitem = null;
		// anzahl verbleibender loops
		this.loopcount = 0;
		// konfigurieren
		autoPlay 	= false;
		autoRewind 	= false;
		autoSize 	= false;
	}

	public function onLoad():Void
	{
		super.onLoad();
		// beim videocontroller als playback registrieren
		VideoController.getInstance().setVideoplayer(this);
		// beim videocontroller als listener registrieren
		VideoController.getInstance().addListener(this);
		// player
		this.player = getVideoPlayer(activeVideoPlayerIndex);
		// positionieren
		this.player._x = _playerx;
		this.player._y = _playery;
		// skalieren
		setSize(_playerwidth, _playerheight);
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
		playPauseButton = videocontroller.play_mc;
		forwardButton 	= videocontroller.forward_mc;
		// back
		backButton.onRelease = Delegate.create(this, doBack);
		// forward
		forwardButton.onRelease = Delegate.create(this, doForward);
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
	public function onItemSelected(item:PlaylistVideoItem ):Void
	{
		// aktuell abgespieltes item
		setCurrentitem(item);
		// anzahl loops
		setLoopcount(getCurrentitem().getLoops());
		// dauer der pause vor dem abspielen des videos
		var pause:Number = getCurrentitem().getPause();
		// video
		var video:Video = getCurrentitem().getVideo();
		// flv-datei (inklusive Pfad)
		var flv:String = video.getPfadFilme() + video.getFilename();
		// uebergeben
		this.contentPath = flv;
		// ggf. pausieren
		if (item.getPause() == -1) {
			// stopmark nach dem start
			addASCuePoint(0, "stopmark", {type : FLVPlayback.ACTIONSCRIPT});
		}
		// abspielen
		this.play();
	}

	/**
	 * callback nach laden der metadaten
	 * @param event
	 */
	public function onMetadataReceived(event:Object ):Void
	{
		// einblenden
		this.visible = true;

//		for (var i : String in metadata) {
//			ssDebug.trace(i + ": " + metadata[i]);
//		}

		// abbrechen, wenn keine stopmarks gesetzt
		if (getCurrentitem().getStopmarks() == "") return;
		// tatsaechliche dauer des videos
		var duration:Number = metadata.duration;
		// stopmark unmittelbar vor ende
		addASCuePoint(duration - 5 / 25, "stopmark", {type : FLVPlayback.ACTIONSCRIPT});
	}

	/**
	 * callback nach abspielen eines videos
	 * @param event
	 */
	public function onComplete(event:Object ):Void
	{
		// anzahl verbleibender loops
		var loops:Number = getLoopcount();
		// testen, ob noch weitere loops abgespielt werden sollen
		if (loops > 0) {
			// anzahl loops reduzieren
			setLoopcount(loops - 1);
			// erneut abspielen
			this.play();

		} else if (loops == PlaylistItem.LOOPS_INFINITE) {
			// erneut abspielen
			this.play();

		} else {
			// naechstes item abspielen
			VideoController.getInstance().nextItem();
		}
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

	public function setCurrentitem(currentitem:PlaylistVideoItem):Void
	{
		this.currentitem = currentitem;
	}

	public function getCurrentitem():PlaylistVideoItem
	{
		return this.currentitem;
	}

	public function setLoopcount(loopcount:Number):Void
	{
		this.loopcount = loopcount;
	}

	public function getLoopcount():Number
	{
		return this.loopcount;
	}

	public function onItemsPlayed(items : Array) : Void {
	}

}