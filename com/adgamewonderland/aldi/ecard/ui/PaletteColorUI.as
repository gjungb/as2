/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.ecard.ui.PaletteTextUI;

class com.adgamewonderland.aldi.ecard.ui.PaletteColorUI extends MovieClip {
	
	private var _myColor:Number;
	
	private var myPaletteUI:PaletteTextUI;
	
	public function PaletteColorUI()
	{
		myPaletteUI = PaletteTextUI(_parent);
	}
	
	public function onRelease():Void
	{
		myPaletteUI.onChangeColor(_myColor);
	}
}