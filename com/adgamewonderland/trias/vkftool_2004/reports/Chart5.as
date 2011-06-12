/* Chart5
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Chart5
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		12.07.2004
zuletzt bearbeitet:	12.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Chart5 extends Chart {

	// Attributes
	
	// Operations
	
	public  function Chart5()
	{
		// saeulen
		myColumns = [];
		// x-abstand der saeulen
		myXdiff = 26;
		// typen der werte, die angezeigt werden sollen
		myTypes = ["marketshare", "outletshare"];
		// breiten und maximale hoehen der columns
		mySizes = [{width : 14, height : 370}, {width : 14, height : 370}];
		// haben die einzelnen columns beschriftungen
		hasLabels = [true, true];
	}
	
	public function showValues(values:Array ):Void
	{
		// abbrechen, falls leere saeule unsichtbar (sprich daten werden schon angezeigt)
		if (dummy1_mc._visible == false) return;
		
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
				// maximaler wert 		// (entspricht per definition dem wert der linken saeule)
				constructor._myMaxValue = values[0][type];
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

} /* end class Chart5 */
