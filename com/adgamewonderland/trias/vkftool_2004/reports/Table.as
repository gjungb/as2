/* Table
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Table
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		10.07.2004
zuletzt bearbeitet:	15.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Table extends MovieClip {

	// Attributes
	
	private var myYdiff:Number;
	
	private var myColors:Array;
	
	private var line_mc:MovieClip;
	
	// Operations
	
	public  function Table()
	{
		// y-abstand der zeilen
		myYdiff = 25;
		// farben der zeilen (gerade / ungerade)
		myColors = [0xFFFFFF, 0x98D7EC];
	}
	
	public function showValues(values:Array ):Void
	{
		// abbrechen, falls leere zeile unsichtbar (sprich daten werden schon angezeigt)
		if (line_mc._visible == false) return;
		// schleife ueber die werte fuer die zeilen
		for (var i:Number = 0; i < values.length; i++) {
			// aktueller wert
			var value:Object = values[i];
			// leere zeile duplizieren
			line_mc.duplicateMovieClip("line" + i + "_mc", i + 1);
			// neue zeile positionieren
			this["line" + i + "_mc"]._y = line_mc._y + (i * myYdiff);
			// faerben
			var col:Color = new Color(this["line" + i + "_mc"]);
			col.setRGB(myColors[i % 2]);
			// schleife ueber die eigenschaften des aktuellen werts
			for (var j:String in value) {
				// entsprechendes textfeld
				var field:TextField = this["line" + i + "_mc"][j + "_txt"];
				// aktuelles format des textfelds, um ausrichtung raus zu bekommen
				var format:TextFormat = field.getTextFormat();
				// ausrichtung
				var align:String = format.align;
				// entspreched auto ausrichten
				field.autoSize = align;
				// wert reinschreiben
				field.text = value[j];
				// einfaerben
				field.textColor = myColors[i % 2];
			}
		}
		// leere zeile ausblenden
		line_mc._visible = false;
	}
	
	public function clearValues():Void
	{
		// zeilenzaehler
		var i:Number = -1;
		// schleife ueber alle zeilen
		while (this["line" + (++i) + "_mc"] instanceof MovieClip) {
			// loeschen
			this["line" + i + "_mc"].removeMovieClip();
		}
		// leere zeile einblenden
		line_mc._visible = true;
	}
	
	public function showPrintversion(bool:Boolean ):Void
	{
		// druckversion / bildschirmversion
		switch (bool) {
			// druckversion
			case true :
				// zeilen ausblenden
				gotoAndStop(2);
			
				break;
			// bildschirmversion
			case false :
				// zeilen einblenden
				gotoAndStop(1);
			
			
				break;
		}
	}

} /* end class Table */
