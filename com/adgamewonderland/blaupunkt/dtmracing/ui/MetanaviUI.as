/* 
 * Generated by ASDT 
*/ 

/*
klasse:			MetanaviUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			blaupunkt
erstellung: 		15.06.2005
zuletzt bearbeitet:	10.08.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

import com.adgamewonderland.blaupunkt.dtmracing.ui.*;

class com.adgamewonderland.blaupunkt.dtmracing.ui.MetanaviUI extends NavigationUI {
	
	private var myDtmRacingUI:DtmRacingUI;
	
	private var blind_mc:MovieClip;
	
	private var instructions_btn:MovieClip;
	
	private var settings_btn:MovieClip;
	
	private var contest_btn:MovieClip;
	
	private var imprint_btn:MovieClip;
	
	private var logout_btn:MovieClip;
	
	private var sound_btn:Button;
	
	private var stoprace_btn:Button;
	
	private var stoptraining_btn:Button;
	
	private var back_btn:Button;
	
	public function MetanaviUI()
	{
		// vererbung
		super.constructor.apply(super, arguments);
		// hauptzeitleiste
		myDtmRacingUI = DtmRacingUI(_parent);
		// navigations buttons
		myButtons = new Array(instructions_btn, settings_btn, contest_btn, imprint_btn, sound_btn, logout_btn);
		// buttons initialisieren
		initButtons();
		// buttons ausblenden
		setButtonsVisible(false);
		// blende ausblenden
		showBlind(false);
		// stop buttons ausblenden
		showStop(null);
		// hintergrund blind button ausblenden
		showBack(false);
	}
	
	public function showBlind(bool:Boolean ):Void
	{
		// blende ein- /ausblenden
		blind_mc._visible = bool;
		// sound button aus- / einblenden
		sound_btn._visible = !bool;
		// als button ohne cursor
		blind_mc.onRollOver = function() {};
		blind_mc.useHandCursor = false;
	}
	
	public function showLogout(bool:Boolean ):Void
	{
		// ein- / ausschalten
		logout_btn.enabled = bool;
		// abfaden
		logout_btn._alpha = (bool ? 100 : 50);
	}
	
	public function showStop(status:Number ):Void
	{
		// rennen stoppen
		stoprace_btn._visible = (status == Challenge.STATUS_NEW || status == Challenge.STATUS_CHALLENGER_DONE);
		// training stoppen
		stoptraining_btn._visible = (status == Challenge.STATUS_TRAINING);
	}
	
	public function showContent(content:String, blind:Boolean ):Void
	{
		// hintergrund blind button ein- / ausblenden
		showBack(blind);
		// frame
		var frame:String = "fr" + content;
		// movieclip
		var mc:String = content + "_mc";
		// aufrufen
		navigate(frame, TIME_NAVIGATE, mc, "", []);
	}
	
	private function initButtons():Void
	{
		// instructions
		instructions_btn.onRelease = function() {
			this._parent.showContent("instructions", true);
		};
		// settings
		settings_btn.onRelease = function() {
			this._parent.showContent("settings", true);
		};
		// contest
		contest_btn.onRelease = function() {
			this._parent.showContent("contest", true);
		};
		// imprint
		imprint_btn.onRelease = function() {
			getURL("http://www.blaupunkt.de/impressum.asp", "_blank");
		};
		// sound
		sound_btn.onRelease = function() {
			// globaler sound
			var snd:Sound = new Sound();
			// volume
			snd.setVolume(snd.getVolume() == 100 ? 0 : 100);
			// sound stoppen
//			stopAllSounds();
			// sound umschalten
			_global.SoundCollection.togglePlaying();
		};
		// logout
		logout_btn.onRelease = function() {
			// metanavi ausblenden
			this._parent.showContent("init", false);
			// ausloggen
			this._parent.myDtmRacingUI.logoutUser();
		};
		// rennen neu starten
		stoprace_btn.onRelease = function() {
			// metanavi ausblenden
			this._parent.showContent("init", false);
			// rennen beenden
			this._parent.myDtmRacingUI.stopRace();
		};
		// training beenden
		stoptraining_btn.onRelease = function() {
			// metanavi ausblenden
			this._parent.showContent("init", false);
			// rennen beenden
			this._parent.myDtmRacingUI.stopRace();
		};
	}
	
	private function showBack(bool:Boolean ):Void
	{
		// hintergrund blind button ein- /ausblenden
		back_btn._visible = bool;
		// ohne cursor
		back_btn.useHandCursor = false;
	}
}