/* Chart3D
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Chart3D
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		12.07.2004
zuletzt bearbeitet:	01.07.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Chart3D extends MovieClip {

	// Attributes
	
	private var myCircles:Array;
	
	private var myTypes:Array;
	
	private var myMaxima:Object;
	
	private var myAxes:Object;
	
	private var myMinRadius:Number;
	
	private var hasLabels:Boolean;
	
	private var dummy_mc:Circle;
	
	private var xmin_txt:TextField, xmax_txt:TextField, ymin_txt:TextField, ymax_txt:TextField;
	
	// Operations
	
	public  function Chart3D()
	{
		// kreise
		myCircles = [];
		// typen der werte, die angezeigt werden sollen
		myTypes = ["pricevalue", "revenuevalue", "intakevalue"];
		// maxima / minima der werte, die angezeigt werden sollen
		myMaxima = {revenuevalue : {min : 0, max : 0}, pricevalue : {min : 0, max : 0}, intakevalue : {min : 0, max : 0}};
		// wertedefinition der beiden achsen (min auf buehne, max auf buehne, min wert, max wert)
		myAxes = {x : {min : 150, max : 900, diff : 0, vmin : 0, vmax : 0, factor : 0}, y : {min : 200, max : 550, diff : 0, vmin : 0, vmax : 0, factor : 0}};
		// minimaler radius der kreise
		myMinRadius = 8;
		// werden labels der kreise angezeigt
		hasLabels = true;
	}
	
	public function showValues(values:Array ):Void
	{
		// abbrechen, falls leerer kreis unsichtbar (sprich daten werden schon angezeigt)
		if (dummy_mc._visible == false) return;
		
		// maxima / minima der werte
		for (var i:Number = 0; i < myTypes.length; i ++) {
			// aktueller typ
			var type:String = myTypes[i];
			// minimalwert fuer diesen typ speichern
			myMaxima[type].min = getMinMaxValue(values, type, "min");
			// maximalwert fuer diesen typ speichern
			myMaxima[type].max = getMinMaxValue(values, type, "max");
			
			// anzahl der stellen des minimalwerts
			var mindigits:Number = Math.floor(Math.log(myMaxima[type].min) / Math.LN10);
			// wert, der etwas kleiner ist als der minimalwert
			var vmin:Number = Math.floor(myMaxima[type].min / Math.pow(10, mindigits)) * Math.pow(10, mindigits);
			
			// anzahl der stellen des maximalwerts
			var maxdigits:Number = Math.floor(Math.log(myMaxima[type].max) / Math.LN10);
			// wert, der etwas groesser ist als der maximalwert
			var vmax:Number = Math.ceil(myMaxima[type].max / Math.pow(10, maxdigits)) * Math.pow(10, maxdigits);
			
			// groessenordnungen zwischen minimal- und maximalwert
			var dimensions:Number = Math.log(vmax / vmin) / Math.LN10;
			
			// x-achse
			if (i == 0) {
				// minimalwert
				myAxes.x.vmin = vmin;
				// maximalwert
				myAxes.x.vmax = vmax;
				// differenz der buehnenkoordinaten
				myAxes.x.diff = myAxes.x.max - myAxes.x.min;
				// faktor, mit dem echte werte verrechnet werden muessen
				myAxes.x.factor = myAxes.x.diff / dimensions;
				
				// beschriften
				xmin_txt.autoSize = "center";
				xmin_txt.text = getDottedValue(vmin);
				xmin_txt._x = myAxes.x.min - xmin_txt._width / 2;
				xmax_txt.autoSize = "center";
				xmax_txt.text = getDottedValue(vmax);
				xmax_txt._x = myAxes.x.max - xmax_txt._width / 2;
				
			// y-achse
			} else if (i == 1) {
				// minimalwert
				myAxes.y.vmin = vmin;
				// maximalwert
				myAxes.y.vmax = vmax;
				// differenz der buehnenkoordinaten
				myAxes.y.diff = myAxes.y.max - myAxes.y.min;
				// faktor, mit dem echte werte verrechnet werden muessen
				myAxes.y.factor = myAxes.y.diff / dimensions;
				
				// beschriften
				ymin_txt.autoSize = "center";
				ymin_txt.text = getDottedValue(vmin);
				ymin_txt._y = myAxes.y.max + ymin_txt._width / 2;
				ymax_txt.autoSize = "center";
				ymax_txt.text = getDottedValue(vmax);
				ymax_txt._y = myAxes.y.min + ymax_txt._height;
			}
		}
		
		// tiefe fuer duplicate
		var depth:Number = 1;
		// schleife ueber die werte fuer die kreise
		for (var j:Number = 0; j < values.length; j++) {
			// aktueller wert
			var value:Object = values[j];
			
			// constructor
			var constructor:Object = {};
			// id
			constructor._myId = value.id;
			// x-wert
			var xvalue:Number = value[myTypes[0]];
			// x-position
			constructor._x = myAxes.x.min + ((Math.log(xvalue) - Math.log(myAxes.x.vmin)) / Math.LN10) * myAxes.x.factor;
			// y-wert
			var yvalue:Number = value[myTypes[1]];
			// y-position
			constructor._y = myAxes.y.max - ((Math.log(yvalue) - Math.log(myAxes.y.vmin)) / Math.LN10) * myAxes.y.factor;
			// name
			constructor._myLabel = value.name;
			// wert
			constructor._myValue = value[myTypes[2]];
			// formatierter wert
			constructor._myFormattedValue = getDottedValue(value[myTypes[2]]);

			// radius (regel: kreis fuer kleinsten wert aus values hat myMinRadius als radius, alle anderen beziehen sich darauf)
			var radius:Number = Math.sqrt(value[myTypes[2]] / myMaxima[myTypes[2]].min) * myMinRadius;
			// breite und hoehe als doppeltes des radius
			constructor._myDiameter = radius * 2;
			
			// leeren kreis duplizieren
			var circle:MovieClip = dummy_mc.duplicateMovieClip("circle" + j + "_mc", ++depth, constructor);
			// in array schreiben
			myCircles.push(circle);
		}
		// leeren kreis ausblenden
		dummy_mc._visible = false;
	}
	
	private function getMinMaxValue(values:Array, type:String, minmax:String ):Number
	{
		// mit duplikat arbeiten
		var valarr:Array = [];
		for (var i:String in values) valarr[i] = values[i];
		// gesuchter wert
		var val:Number = 0;
		// werte fuer diesen typ sortieren
		if (minmax == "max") {
			// absteigend sortieren
			valarr.sort(function (val1:Object, val2:Object) { return(val2[type] - val1[type]); });
		} else if (minmax == "min") {
			// aufsteigend sortieren
			valarr.sort(function (val1:Object, val2:Object) { return(val1[type] - val2[type]); });
		}
		// maximalwert / minimalwert
		val = valarr[0][type];
		// zurueck geben
		return val;
	}
	
	private function getDottedValue(num:Number ):String
	{
		// in string umwandeln
		var newval:String = String(num);
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
		// zurueck geben
		return formval;
	}
	
	public function swapLabels(mc:Multibutton ):Void
	{
		// anzeige der labels umschalten
		hasLabels = !hasLabels;
		// schleife ueber alle kreise
		for (var i:String in myCircles) {
			// label umschalten
			myCircles[i].showLabel(hasLabels);
		}
		// text auf button umschalten
		mc.text = "Labels " + (hasLabels ? "aus" : "an");
	}

} /* end class Chart3D */
