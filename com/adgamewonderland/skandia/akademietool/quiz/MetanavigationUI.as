/*
klasse:			MetanavigationUI
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		31.01.2005
zuletzt bearbeitet:	09.02.2005
durch			gj
status:			final
*/

import com.adgamewonderland.skandia.akademietool.quiz.*;

class com.adgamewonderland.skandia.akademietool.quiz.MetanavigationUI extends MovieClip {

	// Attributes
	
	private var myQuizUI:QuizUI;
	
	private var instructions_btn:MovieClip;
	
	private var instructions_mc:MovieClip;
	
	private var finish_btn:MovieClip;
	
	private var finish_mc:FinishUI;
	
	private var impressum_btn:MovieClip;
	
	private var impressum_mc:MovieClip;
	
	private var myButtons:Object;
	
	private var blind_mc:MovieClip;
	
	// Operations

	function MetanavigationUI()
	{
		// quiz
		myQuizUI = QuizUI(_parent);
		// button anleitung
		instructions_btn.onRelease = function() {
			// anleitung
			this._parent.onReleaseButton("instructions");
		};
		// button beenden
		finish_btn.onRelease = function() {
			// beenden
			this._parent.onReleaseButton("finish");
		};
		// button impressum
		impressum_btn.onRelease = function() {
			// impressum
			this._parent.onReleaseButton("impressum");
		};
		// vorhandene buttons
		myButtons = {instructions:instructions_btn, finish:finish_btn, impressum:impressum_btn};
		// alle ausblenden
		// for (var mode:String in myButtons) showButton(mode, false);
		// button beenden ausblenden
		showButton("finish", false);
		// blind button ohne cursor
		blind_mc.useHandCursor = false;
		// blind button ausblenden
		showBlind(false);
	}
	
	public function showButton(mode:String, bool:Boolean ):Void
	{
		// button de- / aktivieren
		myButtons[mode].enabled = bool;
		// faden
		myButtons[mode]._alpha = (bool ? 100 : 10);
	}
	
	public function showBlind(bool:Boolean ):Void
	{
		// blind button ein- / ausblenden
		blind_mc._visible = bool;
	}
	
	public function onReleaseButton(mode:String ):Void
	{
		// blind button einblenden
		showBlind(true);
		// je nach modus
		switch (mode) {
			// anleitung
			case "instructions" :
				// anleitung einblenden
				instructions_mc.gotoAndPlay("frIn");

				break;
			// beenden
			case "finish" :
				// abfrage einblenden
				finish_mc.gotoAndPlay("frIn");

				break;
			// impressum
			case "impressum" :
				// impressum einblenden
				impressum_mc.gotoAndPlay("frIn");

				break;
		}
	}
	
	public function finishAcknowledged(bool:Boolean ):Void
	{
		// blind button ausblenden
		showBlind(false);
		// wenn ja geklickt, an quiz weiter reichen
		if (bool) myQuizUI.finishQuiz(true);
	}
}