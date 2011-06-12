/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.rechtstexte.HochzahlUI extends MovieClip {
	
	private static var TRENNER1:String = ",";
	
	private static var TRENNER2:String = "|";
	
	private var _rtid:String;
	
	private var _color:Color;
	
	private var _font:String;
	
	private var _size:Number;
	
	private var hochzahl_txt : TextField;
	
	public function HochzahlUI() {
		// von aussen uebergebener string aus rtids und dazu gehoerigen hochzahlen
		var rtids:String = _root.rtids;
		// trace("HochzahlUI: " + rtids);
		// aufsplitten in array
		var arr:Array = rtids.split(TRENNER1);
		// map mit zuordnung rtid zu hochzahl
		var map:Object = {};
		// array durchschleifen
		for (var i : String in arr) {
			// aktueller wert
			var paar:String = arr[i];
			// trennposition
			var pos:Number = paar.indexOf(TRENNER2, 0);
			// aufsplitten in rtid und hochzahl
			var rtid:String = paar.substr(0, pos);
			// hochzahl
			var hochzahl:String = paar.substr(pos + 1, paar.length);
			// in map schreiben
			map[rtid] = hochzahl;
		}
		// textfeld befuellen
		if (map[_rtid] != undefined)
			hochzahl_txt.text = map[_rtid];
			
		// font einbetten
		hochzahl_txt.embedFonts = true;
		// automatische groesse
		hochzahl_txt.autoSize = "left";
		// format
		var tf:TextFormat = new TextFormat();
		// linksbuendig
		tf.align = "left";
		// farbe
		tf.color = new Number(_color);
		// font
		tf.font = _font;
		// groesse
		tf.size = _size;
		// anwenden
		hochzahl_txt.setTextFormat(tf);
	}
}