/* Inputscale
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputscale
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		07.07.2004
zuletzt bearbeitet:	07.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.input.Inputscale extends MovieClip {

	// Attributes
	
	private var _myParam:String;
	
	private var _myName:String;
	
	private var _myTooltip:String;
	
	private var myValue:Number;
	
	private var name_txt:TextField;
	
	private var colors_mc:MovieClip;
	
	private var b0_btn:Button, b1_btn:Button, b2_btn:Button, b3_btn:Button, b4_btn:Button, b5_btn:Button, b6_btn:Button, b7_btn:Button, b8_btn:Button, b9_btn:Button;
	
	// Operations
	
	public  function Inputscale()
	{
		// registrieren
		_parent.registerInputscale(this, _myParam);
		// name anzeigen
		name_txt.autoSize = "left";
		name_txt.text = _myName;
		
		// wert der skala
		value = null;
		
		// buttons initialisieren
		var i:Number = -1;
		// schleife ueber alle buttons
		while (this["b" + (++i) + "_btn"] instanceof Button) {
			// nummer im button speichern
			this["b" + i + "_btn"].myNumber = i;
			// callback bei klick
			this["b" + i + "_btn"].onRelease = function () {
				// wert uebergeben
				this._parent.changeValue(this.myNumber);
			}
		}
	}
	
	public function get value():Number
	{
		// wert der skala
		return(myValue);
	}
	
	public function set value(num:Number ):Void
	{
		// wert der skala in prozent
		myValue = num;
		// auf skala anzeigen
		showValue(num != -1 ? Math.round(num / 100 * 9) : -1);
	}
	
	private  function changeValue(num:Number ):Void
	{
		// wert der skala in prozent
		value = num * 100 / 9;
		// speichern
		_parent._parent._parent.onChangeRating(_myParam, value);
	}
	
	private  function showValue(num:Number ):Void
	{
		// in farbskala anzeigen
		colors_mc.gotoAndStop(num + 2);
	}

} /* end class Inputscale */
