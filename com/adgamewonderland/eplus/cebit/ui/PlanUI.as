/* 
 * Generated by ASDT 
*/ 

/*
klasse:			PlanUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		03.03.2005
zuletzt bearbeitet:	03.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.cebit.ui.PlanUI extends MovieClip {
	
	private static var PAUSE:Number = 5000;
	
	private var myHeadline:Number;
	
	private var isVisible:Boolean;
	
	private var myInterval:Number;
	
	private var headlines_mc:MovieClip;
	
	public function PlanUI()
	{
		// nummer der aktuellen headline
		myHeadline = null;
		// ist die headline eingeblendet
		isVisible = false;
		// interval
		myInterval = null;
	}
	
	public function set headline(num:Number ):Void
	{
		// nummer der aktuellen headline
		myHeadline = num;
	}
	
	public function get headline():Number
	{
		// nummer der aktuellen headline
		return myHeadline;
	}
	
	public function showHeadline(num:Number ):Void
	{
		// nummer der headline
		headline = num;
		// interval loeschen
		clearInterval(myInterval);
		// nach pause wieder ausblenden
		myInterval = setInterval(this, "moveHeadline", PAUSE, false);
		// entsprechende headline anzeigen
		headlines_mc.gotoAndStop("fr" + num);
		// reinfahren, wenn nicht sichtbar
		if (isVisible == false) moveHeadline(true);
	}
	
	private function moveHeadline(bool:Boolean ):Void
	{
		// sichtbarkeit umschalten
		isVisible = bool;
		// frame
		var frame:String = (bool ? "frIn" : "frOut");
		// nach ausblenden interval loeschen
		if (bool == false) clearInterval(myInterval);
		// hinspringen
		gotoAndPlay(frame);
	}
}