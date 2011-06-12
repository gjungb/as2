/* Inputfield
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputfield
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	05.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.input.Inputfield extends MovieClip {

	// Attributes
	
	private var _myParam:String;
	
	private var _myUnit:String; // currency, number
	
	private var _myCaller:String;
	
	private var _myCallback:String;
	
	private var myValue:Number;
	
	private var myState:String;
	
	private var input_txt:TextField;
	
	private var back_mc:MovieClip;
	
	// Operations
	
	public  function Inputfield()
	{
		// wert des eingabefelds
// 		value = null;
		// registrieren
		_parent.registerInputfield(this, _myParam);
		// status des eingabefelds
		state = (value != null ? "display" : "editing"); // "readonly"
		// nummer aus instanzname
		var num:Number = Number(_name.substring(_name.indexOf("d") + 1, _name.indexOf("_")));
		// tab index
		input_txt.tabIndex = num;
		// eingabe auf ziffern beschraenken
		input_txt.restrict = "0123456789";
		// maximale zeichenzahl
		input_txt.maxChars = 8;
		// callback beim betreten des textfelds
		input_txt.onSetFocus = function () {
			// editiermodus anzeigen
			_parent.state = "editing";
			// unformatierten wert anzeigen
			this.text = (_parent.value == null ? "" : _parent.value);
			// auf enter reagieren
			this.keyListener = {};
			this.keyListener.onKeyDown = function () {
				// textfeld verlassen
				if (Key.isDown(Key.ENTER)) Selection.setFocus(_parent);
			}
			// taste beobachten
			Key.addListener(this.keyListener);
		};
		// callback beim verlassen des textfelds
		input_txt.onKillFocus = function () {
			// formatierten wert anzeigen
			_parent.value = (this.text == "" ? "" : Number(this.text));
			// nicht mehr auf enter reagieren
			Key.removeListener(this.keyListener);
		};
	}
	
	public function get value():Number
	{
		// wert des eingabefelds
		return(myValue);
	}
	
	public function set value(num:Number ):Void
	{
		// wert des eingabefelds
		myValue = num;
		// formatiert anzeigen
		showValue(num);
		// speichern
		with (this) {
			// aufzurufendes object
			var caller:Object = eval(_myCaller);
			// daten uebergeben
			caller[_myCallback](_myParam, num);
		}
	}
	
	public function get state():String
	{
		// status des eingabefelds
		return(myState);
	}
	
	public function set state(str:String ):Void
	{
		// status des eingabefelds
		myState = str;
		// aussehen aendern
		switch (str) {
			// anzeige
			case "display" :
				// anzeigen
				back_mc.gotoAndStop("frDisplay");
				
				break;
			// editieren oder leer
			case "editing" :
				// anzeigen
				back_mc.gotoAndStop("frEditing");
				
				break;
			// nur lesen
			case "readonly" :
				// anzeigen
				back_mc.gotoAndStop("frReadonly");
				// eingabe sperren
				input_txt.type = "dynamic";
				input_txt.selectable = false;
				
				break;
		}
	}
	
	private  function showValue(num:Number ):Void
	{
		// in string umwandeln
		var newval:String = (num == "null" || num == null ? "" : String(num));
		// formatieren
		var formval:String = "";
		// rueckwaertsschleife ueber wert, um tausenderpunkte einuzfügen
		var dotcount:Number = 0;
		for (var i:Number = newval.length - 1; i >= 0; i --) {
			// aktuelle ziffer anhaengen
			formval =  newval.substr(i, 1) + formval;
			// alle 3 ziffern ein punkt (ausser ganz links)
			if (++dotcount % 3 == 0 && i > 0) formval = "." + formval;
		}
		// ,- hinten dran
		if (newval != "" && _myUnit == "currency") formval = formval + ",-";
		// anzeigen
		input_txt.text = formval;
		// status aendern
		state = (newval != "" ? "display" : "editing");
	}

} /* end class Inputfield */
