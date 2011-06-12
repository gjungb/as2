/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.NavigationUI extends MovieClip {
	
	private var myCalendarUI:CalendarUI;
	
	private var myButtons:Array;
	
	private var instructions_btn:Button;
	
	private var requirements_btn:Button;
	
	private var tellafriend_btn:Button;
	
	public function NavigationUI() {
		myCalendarUI = CalendarUI(_parent);
		// buttons
		myButtons = [instructions_btn, requirements_btn, tellafriend_btn];
		// anleitung
		instructions_btn.onRelease = function(){
			this._parent.showInstructions();
		};
		// teilnahmebedingungen
		requirements_btn.onRelease = function(){
			this._parent.showRequirements();
		};
		// tellafriend
		tellafriend_btn.onRelease = function(){
			this._parent.showTellafriend();
		};
	}
	
	public function showNavigation(bool:Boolean ):Void
	{
		// buttons de- / aktivieren
		for (var i:String in myButtons) {
			myButtons[i].enabled = bool;
			if (bool) myButtons[i].gotoAndStop("_up");
		}
	}
	
	public function showInstructions():Void
	{
		// buttons deaktivieren
		showNavigation(false);
		// instructions anzeigen lassen
		myCalendarUI.showInstructions();
	}
	
	public function showRequirements():Void
	{
		// buttons deaktivieren
		showNavigation(false);
		// requirements anzeigen lassen
		myCalendarUI.showRequirements();
	}
	
	public function showTellafriend():Void
	{
		// buttons deaktivieren
		showNavigation(false);
		// tellafriend anzeigen lassen
		myCalendarUI.showTellafriend();
	}
}