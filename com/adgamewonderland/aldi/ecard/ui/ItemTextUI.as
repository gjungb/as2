/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.ecard.beans.*;

import com.adgamewonderland.aldi.ecard.ui.*;

class com.adgamewonderland.aldi.ecard.ui.ItemTextUI extends ItemUI {
	
	private static var DEFAULT_SIZE:Number = 48;
	
	private var color:Number;
	
	private var font:String;
	
	private var text:String;
	
	private var text_txt:TextField;
	
	public function ItemTextUI() {
		this.color = 0;
		this.font = "";
		this.text = "";
		
		watch("color", onSetColor, null);
		watch("font", onSetFont, null);
		watch("text", onSetText, null);
		
		initField();
	}
	
	public function getText():String {
		return text;
	}

	public function setText(text:String):Void {
		this.text = text;
	}

	public function getFont():String {
		return font;
	}

	public function setFont(font:String):Void {
		this.font = font;
	}

	public function getColor():Number {
		return color;
	}

	public function setColor(color:Number):Void {
		this.color = color;
	}
	
	public function setSelectable(bool:Boolean ):Void
	{
		text_txt.selectable = bool;
	}
	
	public function getAsBean():ItemText
	{
		// neues item
		var item:ItemText = new ItemText();
		// x
		item.setX(_x);
		// y
		item.setY(_y);
		// scale
		item.setScale(_xscale);
		// color
		item.setColor(getColor());
		// font
		item.setFont(getFont());
		// text
		item.setText(escape(text_txt.text));
		
		// zurueck geben
		return item;
	}
	
	private function initField():Void
	{
		// neues textfeld
		createTextField("text_txt", 1, 0, 0, 100, 20);
		// eingabe
		text_txt.type = "input";
		// dynamische breite
		text_txt.autoSize = "left";
		// multiline
		text_txt.multiline = true;
		// font embedden
		text_txt.embedFonts = true;
		// font, groesse, farbe
		text_txt.setNewTextFormat(new TextFormat(ItemText.DEFAULT_FONT, DEFAULT_SIZE, ItemText.DEFAULT_COLOR));
		// cursor
//		Selection.setFocus(text_txt);

		// callback bei auswahl des textfelds
		text_txt.onSetFocus = function() {
			// leeren, wenn default text
			if (this.text == ItemText.DEFAULT_TEXT) this.text = "";
		}
	}
	
	private function onSetEditable(prop:String, oldval:Boolean, newval:Boolean):Boolean
	{
		// palette umschalten
		showPalette(newval);
		// auswaehlbar
//		text_txt.selectable = newval;
		// neuen wert setzen
		return newval;
	}
	
	private function onSetColor(prop:String, oldval:Number, newval:Number):Number
	{
		// aktuelles textformat
		var tf:TextFormat = text_txt.getNewTextFormat();
		// neue color
		tf.color = newval;
		// anwenden
		text_txt.setNewTextFormat(tf);
		text_txt.setTextFormat(tf);
		// neuen wert setzen
		return newval;
	}
	
	private function onSetFont(prop:String, oldval:String, newval:String):String
	{
		// aktuelles textformat
		var tf:TextFormat = text_txt.getNewTextFormat();
		// neuer font
		tf.font = newval;
		// anwenden
		text_txt.setNewTextFormat(tf);
		text_txt.setTextFormat(tf);
		// neuen wert setzen
		return newval;
	}
	
	private function onSetText(prop:String, oldval:String, newval:String):String
	{
		// anzeigen
		text_txt.text = newval;
		// neuen wert setzen
		return newval;
	}
	
	private function attachPalette():PaletteTextUI
	{
		// attachen
		var mc:PaletteTextUI = PaletteTextUI(attachMovie("PaletteTextUI", "palette_mc", 2));
		// zurueck geben
		return mc;
	}

}