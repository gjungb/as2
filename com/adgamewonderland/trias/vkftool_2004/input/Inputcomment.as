/* Inputcomment
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputcomment
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	01.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.input.Inputcomment extends MovieClip {

	// Attributes
	
	private var myValue:String;
	
	private var myStartText:String;
	
	private var scrollbar_mc:MovieClip;
	
	private var input_txt:TextField;
	
	// Operations
	
	public  function Inputcomment()
	{
		// text, der am anfang und bei leerem textfeld im textfeld steht
		myStartText = input_txt.text;
		// inhalt des eingabefelds
		value = "";
		
		// maximale anzahl zeichen
		input_txt.maxChars = 200;
		// callback beim betreten des textfelds
		input_txt.onSetFocus = function () {
			// unformatierten wert anzeigen
			this.text = _parent.value;
// 			// ganz nach oben
// 			_parent.scrollbar_mc.setTargetPosition(0);
// 			// scrollthumb nach oben
// 			_parent.scrollbar_mc.setThumbPosition(0);
		};
		// callback beim verlassen des textfelds
		input_txt.onKillFocus = function () {
			// formatierten wert anzeigen
			_parent.value = this.text;
		};
		// callback beim schreiben
		input_txt.onChanged = function (field:TextField ) {
			// hoehe
			field._height = field.textHeight * 1.1;
			// 
// 			trace(field._height + " # " + field.textHeight);
		
		}
	}
	
	public function get value():String
	{
		// wert des eingabefelds
		return(myValue);
	}
	
	public function set value(str:String ):Void
	{
		// wert des eingabefelds
		myValue = str;
		// anzeigen (bei leerem eingabefeld starttext reinschreiben)
		input_txt.text = (str == "" ? myStartText : str);
		// speichern
		_parent.onChangeComment(str);
	}

} /* end class Inputcomment */
