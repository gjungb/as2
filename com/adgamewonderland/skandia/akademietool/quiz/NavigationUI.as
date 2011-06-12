/*
klasse:			NavigationUI
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		13.01.2005
zuletzt bearbeitet:	20.01.2005
durch			gj
status:			final
*/

import com.adgamewonderland.skandia.akademietool.quiz.*;

class com.adgamewonderland.skandia.akademietool.quiz.NavigationUI extends MovieClip {

	// Attributes
	
	private var myQuizUI:QuizUI;
	
	private var prevtask_mc:MovieClip;
	
	private var nexttask_mc:MovieClip;
	
	private var myButtons:Object;
	
	// Operations

	function NavigationUI()
	{
		// quiz
		myQuizUI = QuizUI(_parent);
		// button nach links
		prevtask_mc.onRelease = function() {
			// vorherige
			this._parent.onReleaseButton("prev");
		};
		// button nach rechts
		nexttask_mc.onRelease = function() {
			// naechste
			this._parent.onReleaseButton("next");
		};
		// vorhandene buttons
		myButtons = {prev:prevtask_mc, next:nexttask_mc};
		// alle ausblenden
		for (var mode:String in myButtons) showButton(mode, false);
	}
	
	public function showButton(mode:String, bool:Boolean ):Void
	{
		// button ein- / ausblenden
		myButtons[mode]._visible = bool;
		// abspielen
		if (bool) myButtons[mode].gotoAndPlay(1);
	}
	
	public function onReleaseButton(mode:String ):Void
	{
		// je nach modus
		switch (mode) {
			// vorherige
			case "prev" :
				myQuizUI.changeTaskByDir(-1);
				break;
			// naechste
			case "next" :
				myQuizUI.finishTask();
				break;
		}
	}
}