/* Circle
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Circle
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		12.07.2004
zuletzt bearbeitet:	ß1.07.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Circle extends MovieClip {

	// Attributes
	
	private var _myId:Number;
	
	private var _myLabel:String, _myMaxArea:Number, _myValue:Number, _myDiameter:Number, _myFormattedValue:String; // im constructor uebergeben
	
	private var isActive:Boolean;
	
	private var bulb_mc:Bulb;
	
	private var label_txt:TextField, value_txt:TextField;
	
	// Operations
	
	public function Circle()
	{
		// kreis skalieren auf uebergebenen durchmesser
		bulb_mc._height = bulb_mc._width = _myDiameter;
		
		// label
		label_txt.autoSize = "left";
		label_txt.text = _myLabel;
		// positionieren unter unterkante
		label_txt._y = label_txt._height + bulb_mc._height / 2;
		
// 		// value
// 		value_txt.autoSize = "center";
// 		value_txt.text = _myFormattedValue;
// 		// positionieren ueber oberkante
// 		value_txt._y = - value_txt._height - bulb_mc._height / 2;
		
		// label einblenden
		showLabel(true);
		// button auf bulb, damit man immer den supplier auswaehlen kann
		bulb_mc.onRelease = function () {
			
		};
	}
	
	public function showLabel(bool:Boolean ):Void
	{
		// ein- / ausblenden
		showText(bool);
		// auf maus reagieren oder nicht
		isActive = !bool;
	}
	
	private function showText(bool:Boolean ):Void
	{
		// label und value ein- / ausblenden
		label_txt._visible = value_txt._visible = bool;
		// nach vorne holen
		this.swapDepths(100);
	}
	
	private function onRollOver():Void
	{
		// text einblenden
		if (isActive) showText(true);
	}
	
	private function onRollOut():Void
	{
		// text ausblenden
		if (isActive) showText(false);
	}
	
	private function onRelease():Void
	{
		// id des ausgewaehlten suppliers
		_global.Reports.selectedsupplierid = _myId;
		// zu report 4
		_global.Reports.showReport(4);
	}

} /* end class Circle */
