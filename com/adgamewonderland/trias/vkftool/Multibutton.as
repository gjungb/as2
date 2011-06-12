/* Multibutton
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Multibutton
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		01.07.2004
zuletzt bearbeitet:	15.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.Multibutton extends MovieClip {

	// Attributes
	
	private var _myText:String;
	
	private var _myCallbacks:Object;
	
	private var _myStartState:String;
	
	private var myState:String;
	
	private var text_txt:TextField;
	
	private var back_mc:MovieClip;
	
	// Operations
	
	public  function Multibutton()
	{
		// text anzeigen
		text_txt.autoSize = "center";
		text_txt.text = _myText;
		// zustand
		state = _myStartState;
	}
	
	public function set text(str:String ):Void
	{
		// text anzeigen
		text_txt.text = str;
	}
	
	public function get state():String
	{
		// wert des eingabefelds
		return(myState);
	}
	
	public function set state(str:String ):Void
	{
		// zustand
		myState = str;
		// je nach zustand
		switch (str) {
			// up (normal)
			case "up" :
				// hinspringen
				gotoAndStop("_up");
				
				break;
			// over
			case "over" :
				// hinspringen
				gotoAndPlay("_over");
				
				break;
			// down
			case "down" :
				// hinspringen
				gotoAndStop("_down");
				
				break;
			// disabled
			case "disabled" :
				// faden
				_alpha = 50;
				// hinspringen (broken!!!)
// 				gotoAndStop("_up");
				// disablen
				enabled = false;
				
				break;
			// enabled
			case "enabled" :
				// faden
				_alpha = 100;
				// hinspringen (broken!!!)
// 				gotoAndStop("_up");
				// ensablen
				enabled = true;
				
				break;
		}
	}

	public function onRelease():Void
	{
		// callback ausfuehren
		_parent[_myCallbacks["onRelease"]](this);
	}
	
	public function onRollOut():Void
	{
		// bei status "over" nicht zu "_up" springen
		if (state == "over") gotoAndPlay("_over");
	}

} /* end class Multibutton */
