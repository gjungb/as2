/* Column
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Column
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		11.07.2004
zuletzt bearbeitet:	16.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Column extends MovieClip {

	// Attributes
	
	private var _myLabel:String, _myMaxHeight:Number, _myValue:Number, _myMaxValue:Number, _myFormattedValue:String, _myStyle:Number, _myWidth:Number; // im constructor uebergeben
	
	private var myMaxLabel:Number;
	
	private var bar_mc:Bar;
	
	private var label_txt:TextField, value_txt:TextField;
	
	// Operations
	
	public  function Column()
	{
		// maximaler y-wert fuer label
		myMaxLabel = 120;
	
		// label
		label_txt.autoSize = "left";
		label_txt.text = _myLabel;
		// balken skalieren (normiert auf uebergebenen maximalwert)
		bar_mc._height = Math.abs(_myMaxHeight * _myValue / _myMaxValue);
		// bei negativen werten drehen
		if (_myValue < 0) bar_mc._rotation = 180;
		
		// value
		value_txt.autoSize = "right";
		value_txt.text = _myFormattedValue;
		// je nach style positionieren
		switch (_myStyle) {
			// differenzbalken immer unten beschriften
			case 2 :
				// bei positivem wert direkt unter x-achse
				if (_myValue >= 0) {
					value_txt._y = value_txt._height;
				// bei negativem wert unter unterkante
				} else {
					value_txt._y = value_txt._height + bar_mc._height;
					// wenn zu weit unten, hochschieben
					if (value_txt._y > myMaxLabel) value_txt._y = bar_mc._height;
				}
				
				break;
				
			// normale balken
			default :
				// bei positivem wert oben
				if (_myValue >= 0) {
					// unter oberkante
					value_txt._y = value_txt._height - bar_mc._height;
					// nicht unter die x-achse
					if (value_txt._y > 0) value_txt._y = 0;
				// bei negativem wert unter unterkante
				} else {
					// unter unterkante
					value_txt._y = value_txt._height + bar_mc._height;
				}
		}
		
		// style
		bar_mc.gotoAndStop("fr" + (_myStyle + 1));
		// width
		bar_mc._width = _myWidth;
	}
	
	public  function changeLabelColor(col:Number ):Void
	{
		// farbe des labels aendern
		label_txt.textColor = col;
	}

} /* end class Column */
