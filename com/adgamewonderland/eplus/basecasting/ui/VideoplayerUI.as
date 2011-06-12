import mx.utils.Delegate;
import mx.video.FLVPlayback;

import com.adgamewonderland.eplus.basecasting.ui.VideocontrollerUI;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.beans.impl.ClipImpl;
import com.adgamewonderland.agw.util.TimeFormater;
import com.adgamewonderland.eplus.basecasting.ui.CountdownUI;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.eplus.basecasting.interfaces.IVideoControllerListener;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.controllers.VideoController;
import com.adgamewonderland.eplus.basecasting.beans.Casting;
import com.adgamewonderland.eplus.basecasting.interfaces.IClipConnectorListener;
import com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl;
import mx.utils.Collection;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.VideoplayerUI extends MovieClip implements IApplicationControllerListener, IVideoControllerListener, IClipConnectorListener {

	private var clip:Clip;

	private var player:FLVPlayback;

	private var city:CityImpl;

	private var countdown_mc:CountdownUI;

	private var vote_btn:Button;

	private var tellafriend_btn:Button;

	private var headline_txt:TextField;

	public function VideoplayerUI() {
		// stadt, fuer die der player clips anzeigt
		this.city = null;
		// aktueller clip
		this.clip = null;
		// konfigurieren
		this.player.autoPlay 	= false;
		this.player.autoRewind 	= true;
		this.player.autoSize 	= false;
	}

	public function onLoad():Void
	{
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);
		// als listener registrieren
		this.player.addEventListener("metadataReceived", Delegate.create(this, onMetadataReceived));
		this.player.addEventListener("stateChange", Delegate.create(this, onPlayerStateChanged));
		// vote button ausblenden
		vote_btn._visible = false;
		// voten
		vote_btn.onRelease = Delegate.create(this, doVote);
		// tellafriend button ausblenden
		tellafriend_btn._visible = false;
		// tellafriend
		tellafriend_btn.onRelease = Delegate.create(this, doTellafriend);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);
	}

	/**
	 * callback nach laden der metadaten
	 * @param event
	 */
	public function onMetadataReceived(event:Object ):Void
	{
	}

	/**
	 * callback nach zustandsaenderung
	 */
	 public function onPlayerStateChanged(event:Object ):Void
	 {
		// je nach state
		switch (event.state) {
			case FLVPlayback.LOADING :
				// voting button einblenden
				vote_btn._visible = getClip() instanceof VotableClip;
				// empfehlen button einblenden
				tellafriend_btn._visible = getClip() instanceof Clip;

				break;
		}
	 }

	/**
	 * registriert eine videocontroller-komponente mit den entsprechenden control-komponenten
	 * @param videocontroller instanz eines videocontrollerui
	 */
	public function registerVideocontroller(videocontroller:VideocontrollerUI ):Void
	{
		// controller-komponenten bei playback anmelden
		this.player.backButton = videocontroller.back_mc;
		this.player.playButton = videocontroller.play_mc;
		this.player.pauseButton = videocontroller.pause_mc;
		this.player.seekBar = videocontroller.seek_mc;
	}

	public function onClipSelected(aClip:Clip ):Void
	{
		// clip speichern
		this.clip = aClip;
		// video laden
		loadVideo();
	}

	public function onVotingStarted(aClip:Clip):Void
	{
	}

	public function onTellafriendStarted(aClip:Clip):Void
	{
	}

	public function onStateChangeInited(aState:String, aNewstate:String):Void
	{
	}

	public function onStateChanged(aState:String, aNewstate:String):Void
	{
	}

	public function onTopclipLoaded(aClip:VotableClipImpl ):Void
	{
		// abbrechen, wenn topclip fuer andere stadt geladen
		if (getCity().equals(aClip.getCasting().getCity()) == false)
			return;
		// topclip fuer stadt speichern
		getCity().setTopclip(aClip);
		// callback
		onClipSelected(aClip);
	}

	public function onClipsByRankLoaded(aClips:Collection ):Void
	{
	}

	public function onClipsByDateLoaded(aClips:Collection ):Void
	{
	}

	public function onClipsByCastingLoaded(aClips:Collection ):Void
	{
	}

	public function onClipLoaded(aClip:ClipImpl ):Void
	{
		// abbrechen, wenn clip fuer andere stadt geladen
		if (getCity().equals(aClip.getCasting().getCity()) == false)
			return;
		// callback
		onClipSelected(aClip);
	}

	public function getCity():CityImpl
	{
		return this.city;
	}

	public function getClip():Clip
	{
		return this.clip;
	}

	public function toString():String {
		return "VideoplayerUI: " + _name;
	}

	private function loadVideo():Void
	{
		// casting des clips
		var casting:CastingImpl = CastingImpl(getClip().getCasting());
		// headline
		var headline:String = "";
//		// datum
//		headline += TimeFormater.getDayMonth(casting.getDate(), ".") + " ";
//		// location
//		headline += casting.getLocationName() + ", ";
		// stadt
		headline += casting.getCity().getName();
		// headline anzeigen
		showHeadline(headline.toUpperCase());
		// pfad zum video
		var path:String = ClipImpl.getClipurl(getClip());
		// laden
		if (path.indexOf(".flv") > -1)
			this.player.contentPath = path;
		// player einblenden
		this.player._visible = true;

		MovieClip(this.player.getVideoPlayer(this.player.activeVideoPlayerIndex))._video.smoothing = true;
	}

	private function resetVideo():Void
	{
		// video stoppen
		if (this.player.playing)
			this.player.stop();
		// zurueck spulen
		if (this.player.contentPath.indexOf(".flv") > -1)
			this.player.seek(0);
		// "entladen"
//		this.player.contentPath = "";
		// player ausblenden
		this.player._visible = false;
	}

	private function showHeadline(aHeadline:String ):Void
	{
		// headline anzeigen
		headline_txt.text = aHeadline;
	}

	private function showCountdown():Void
	{
		// countdown anzeigen
		countdown_mc.showCountdown(getCity().getName(), getCity().getCountdown());
		// player ausblenden
		this.player._visible = false;
		// keine headline
		showHeadline("");
	}

	private function hideCountdown():Void
	{
		// countdown ausblden
		countdown_mc.hideCountdown();
		// player einblenden
		this.player._visible = true;
	}

	private function doVote():Void
	{
		// voting starten
		VideoController.getInstance().startVoting(getClip());
	}

	private function doTellafriend():Void
	{
		// tellafriend starten
		VideoController.getInstance().startTellafriend(getClip());
	}

}