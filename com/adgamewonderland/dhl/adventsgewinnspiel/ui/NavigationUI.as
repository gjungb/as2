/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventsgewinnspiel.ui.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.NavigationUI extends MovieClip {

	private var myCalendarUI:CalendarUI;

	private var buttons:Array;

	private var game_btn:MovieClip;

	private var instructions_btn:MovieClip;

	private var winnings_btn:MovieClip;

	private var requirements_btn:MovieClip;

	private var tellafriend_btn:MovieClip;

	public function NavigationUI() {
		myCalendarUI = CalendarUI(_parent);
		// buttons
		this.buttons = [instructions_btn, winnings_btn, requirements_btn, tellafriend_btn];
		// spiel
		game_btn.onRelease = function(){
			this._parent.showGame();
		};
		// anleitung
		instructions_btn.onRelease = function(){
			this._parent.showInstructions();
		};
		// anleitung
		winnings_btn.onRelease = function(){
			this._parent.showWinnings();
		};
		// teilnahmebedingungen
		requirements_btn.onRelease = function(){
			this._parent.showRequirements();
		};
		// tellafriend
		tellafriend_btn.onRelease = function(){
			this._parent.showTellafriend();
		};
		// aktivieren
		showNavigation(true, null);
	}

	public function showNavigation(bool:Boolean, btn:MovieClip ):Void
	{
		// buttons de- / aktivieren
		for (var i:String in buttons) {
			buttons[i].enabled = bool;
			btn.enabled = !bool;
			if (bool && buttons[i] != btn) buttons[i].gotoAndStop("_up");
		}
		// sonderbehandlung button spiel
		if (btn == null) {
			game_btn.gotoAndStop("_over");
			game_btn.enabled = false;
		} else {
			game_btn.gotoAndStop("_up");
			game_btn.enabled = true;
		}
	}

	public function showGame():Void
	{
		// buttons aktivieren
		showNavigation(true, game_btn);
		// aktuell angezeigtes movieclip schliessen
		myCalendarUI.closeCurrentmc();
		// kalender anzeigen lassen
		myCalendarUI.showCalendar();
	}

	public function showInstructions():Void
	{
		// buttons aktivieren
		showNavigation(true, instructions_btn);
		// instructions anzeigen lassen
		myCalendarUI.showInstructions();
	}

	public function showWinnings():Void
	{
		// buttons aktivieren
		showNavigation(true, winnings_btn);
		// instructions anzeigen lassen
		myCalendarUI.showWinnings();
	}

	public function showRequirements():Void
	{
		// buttons aktivieren
		showNavigation(true, requirements_btn);
		// requirements anzeigen lassen
		myCalendarUI.showRequirements();
	}

	public function showTellafriend():Void
	{
		// buttons aktivieren
		showNavigation(true, tellafriend_btn);
		// tellafriend anzeigen lassen
		myCalendarUI.showTellafriend();
	}

}