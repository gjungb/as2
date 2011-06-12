/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.ecard.ui.BackgroundUI;

class com.adgamewonderland.aldi.ecard.ui.ToolbarComposeBackgroundUI extends MovieClip {
	
	private var _myNum:Number;
	
	public function ToolbarComposeBackgroundUI() {
		// symbol entsprechend komponentenparameter anzeigen
		gotoAndStop(_myNum);
	}
	
	public function onRelease():Void
	{
		// background
		var background:BackgroundUI = _global.EcardUI.getBackground();
		// aendern
		background.setBackground(_myNum);
	}
	
	public function onRollOver():Void
	{
		// skalieren
		_xscale = _yscale = 115;	
	}
	
	public function onRollOut():Void
	{
		// skalieren
		_xscale = _yscale = 100;
	}
	
	public function onReleaseOutside():Void
	{
		onRollOut();	
	}
	
}