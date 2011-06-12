/*
klasse:			Line
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	18.05.2005
durch			gj
status:			final
*/

import com.adgamewonderland.agw.math.*;

class com.adgamewonderland.agw.math.Line {

	// Attributes

	public var myIntercept:Number; // y-achsenabschnitt

	public var mySlope:Number; // steigung

	public var myXmin:Number = Number.NEGATIVE_INFINITY; // minimaler x-wert

	public var myXmax:Number = Number.POSITIVE_INFINITY; // maximaler x-wert

	public var myEnds:Object; // endpunkte

	public var myType:String = ""; // typ (line, circle, flipper)

	public var myParent = null; // eltern der linie (z.b. ein circle, dessen tangente die linie ist)

	// Operations

	// gerade mit y-achsenabschnitt und steigung gemaess y = m*x + b
	public function Line(intercept:Number , slope:Number )
	{
		// y-achsenabschnitt
		setIntercept(intercept);
		// steigung
		setSlope(slope);
		// endpunkte fuer gerade nicht definiert
		myEnds = {start : null, end : null};
	}

	// gerade in strecke zwischen xmin und xmax aufteilen
	public function segmentLine(xmin:Number , xmax:Number ):Void
	{
		// minimaler x-wert
		myXmin = xmin;
		// maximaler x-wert
		myXmax = xmax;
		// startpunkt
		myEnds["start"] = new Point(xmin, getY(xmin));
		// endpunkt
		myEnds["end"] = new Point(xmax, getY(xmax));
	}

	// linie zeichnen
	public function drawLine(mc:MovieClip , thickness:Number , color:Number , alpha:Number ):Void
	{
		// stil
		mc.lineStyle(thickness, color, alpha);
		// zum anfang
		mc.moveTo(myEnds["start"].x, myEnds["start"].y);
		// linie bis zum ende zeichnen
		mc.lineTo(myEnds["end"].x, myEnds["end"].y);
	}

	// y-funktionswert zurueck geben
	public function getY(x:Number):Number
	{
		return (mySlope * x + myIntercept);
	}

	// x-funktionswert zurueck geben
	public function getX(y:Number):Number
	{
		return ((y - myIntercept) / mySlope);
	}

	// y-achsenabschnitt zurueck geben
	public function getIntercept():Number
	{
		return (myIntercept);
	}

	// steigung zurueck geben
	public function getSlope():Number
	{
		return (mySlope);
	}

	// senkrechte zurueck geben (achsenabschnitt identisch, steigung negativ invers)
	public function getPerpendicular():Line
	{
		return (new Line(myIntercept, -1 / mySlope));
	}

	// endpunkte zurueck geben
	public function getEnds():Object
	{
		return(myEnds);
	}

	// y-achsenabschnitt setzen
	public function setIntercept(intercept:Number ):Void
	{
		if (intercept == Number.POSITIVE_INFINITY) intercept = 1e8;
		if (intercept == Number.NEGATIVE_INFINITY) intercept = -1e8;
		myIntercept = intercept;
	}

	// steigung setzen
	public function setSlope(slope:Number ):Void
	{
		if (slope == Number.POSITIVE_INFINITY) slope = 1e8;
		if (slope == Number.NEGATIVE_INFINITY) slope = -1e8;
		mySlope = slope;
	}

	// parallel verschieben, damit die linie durch den uebergebenen punkt geht
	public function moveToPoint(point:Point ):Void
	{
		// aktueller y-wert bei x-wert des punktes
		var ynow:Number = getY(point.x);
		// differenz zum y-wert des punktes
		var ydiff:Number = point.y - ynow;
		// y-achsenabschnitt entsprechend verschieben
		setIntercept(getIntercept() + ydiff);
	}

	// um uebergebenen winkel drehen
	public function rotateLine(angle:Number ):Void
	{
		// aktueller winkel
		var lineangle:Number = Math.atan(getSlope());
		// addieren
		var newangle:Number = lineangle + angle;
		// neue steigung
		var newslope = Math.tan(newangle);
		// speichern
		setSlope(newslope);
	}

	// type setzen
	public function setType(type:String ):Void
	{
		// speichern
		myType = type;
	}

	// typ zurueck geben
	public function getType():String
	{
		// zurueck geben
		return (myType);
	}

	// parent setzen
	public function setParent(parent:Object ):Void
	{
		// speichern
		myParent = parent;
	}

	// typ zurueck geben
	public function getParent():Object
	{
		// zurueck geben
		return (myParent);
	}

} /* end class Line */
