/* Chart
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Chart
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		11.07.2004
zuletzt bearbeitet:	15.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Chart extends MovieClip {

	// Attributes
	
	private var myColumns:Array;
	
	private var myXdiff:Number;
	
	private var myTypes:Array;
	
	private var mySizes:Array;
	
	private var hasLabels:Array;
	
	private var dummy1_mc:Column, dummy2_mc:Column, dummy3_mc:Column;
	
	private var headcolumn_txt:TextField;
	
	// Operations
	
	public  function Chart()
	{
		// saeulen
		myColumns = [];
		// x-abstand der saeulen
		myXdiff = 26;
		// typen der werte, die angezeigt werden sollen
		myTypes = [];
		// breiten und maximale hoehen der columns
		mySizes = [{width : 0, height : 0}, {width : 0, height : 0}, {width : 0, height : 0}];
		// haben die einzelnen columns beschriftungen
		hasLabels = [];
	}
	
	public function showValues(values:Array ):Void
	{
		// abbrechen, falls leere saeule unsichtbar (sprich daten werden schon angezeigt)
		if (dummy1_mc._visible == false) return;
		// maximalwert
		var maxvalue:Number = getMaxValue(values);
		
		// tiefe fuer duplicate
		var depth:Number = 1;
		// schleife ueber alle typen von werten
		for (var i:Number = 0; i < myTypes.length; i ++) {
			// aktueller typ
			var type:String = myTypes[i];
			// schleife ueber die werte fuer die saeulen
			for (var j:Number = 0; j < values.length; j++) {
				// aktueller wert
				var value:Object = values[j];
				
				// constructor
				var constructor:Object = {};
				// x-position
				constructor._x = this["dummy" + (i + 1) + "_mc"]._x + (j * myXdiff);
				// name
				constructor._myLabel = (hasLabels[i] == true ? value.name : "");
				// wert (in prozent)
				constructor._myValue = value[type];
				// maximale hoehe
				constructor._myMaxHeight = mySizes[i].height;
				// maximaler wert 				// (entspricht per definition dem wert der linken saeule)
				constructor._myMaxValue = maxvalue; // values[0][type];
				// formatierter wert
				constructor._myFormattedValue = value[type] + " %";
				// style
				constructor._myStyle = i;
				// width
				constructor._myWidth = mySizes[i].width;
				
				// leere saeule duplizieren
				this["dummy" + (i + 1) + "_mc"].duplicateMovieClip("column" + i + "" + j + "_mc", ++depth, constructor);
				// in array aufnehmen
				myColumns.push(this["column" + i + "" + j + "_mc"]);
			}
			// leere saeule ausblenden
			this["dummy" + (i + 1) + "_mc"]._visible = false;
		}
	}
	
	private function getMaxValue(values:Array ):Number
	{
		// mit duplikat arbeiten
		var valarr:Array = [];
		for (var i:String in values) valarr[i] = values[i];
		// gesuchter maximalwert
		var max:Number = 0;
		// schleife ueber alle typen von werten
		for (var i:Number = 0; i < myTypes.length; i ++) {
			// aktueller typ
			var type:String = myTypes[i];
			// werte fuer diesen typ sortieren
			valarr.sort(function (val1:Object, val2:Object) { return(val2[type] - val1[type]); });
			// maximalewert
			if (valarr[0][type] > max) max = valarr[0][type];
		}
		// zurueck geben
		return max;
	}
	
	public function showPrintversion(bool:Boolean ):Void
	{
		// druckversion / bildschirmversion
		switch (bool) {
			// druckversion
			case true :
				// grauer hintergrund
				gotoAndStop(2);
				// schleife ueber alle saeulen
				for (var i:String in myColumns) {
					// farbe label aendern
					myColumns[i].changeLabelColor(0x000000);
				}
			
				break;
			// bildschirmversion
			case false :
				// normaler hintergrund
				gotoAndStop(1);
				// schleife ueber alle saeulen
				for (var i:String in myColumns) {
					// farbe label aendern
					myColumns[i].changeLabelColor(0xFFFFFF);
				}
			
				break;
		}
	}

} /* end class Chart */
