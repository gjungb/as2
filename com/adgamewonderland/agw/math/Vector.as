/* Vector
** Generated from ArgoUML Model
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Vector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	05.06.2005
durch			gj
status:			final
*/

class com.adgamewonderland.agw.math.Vector{

	// Attributes

	public var myXdiff:Number;

	public var myYdiff:Number;

	public var myLength:Number;

	public var myAngle:Number;

	public var mySlope:Number;

	// Operations

	public function Vector(dx:Number, dy:Number )
	{
	
		setDiff(dx, dy);

		myLength = 0;

		myAngle = 0;

		mySlope = 0;

		updateLengthAngleSlope();
	}

	public function get xdiff():Number {
		return (myXdiff);
	}

	public function get ydiff():Number {
		return (myYdiff);
	}

	public function setDiff(xdiff:Number , ydiff:Number ):Void
	{
		if(xdiff == 0) xdiff = 1 / Number.MAX_VALUE; // 1e-8;
	
		myXdiff = xdiff;

		myYdiff = ydiff;

		updateLengthAngleSlope();
	}

	public function getLength():Number
	{
		// laenge zurueck geben
		return (myLength);
	}

	public function getAngle():Number
	{
		// winkel zurueck geben
		return (myAngle);
	}

	public function getSlope():Number
	{
		// steigung zurueck geben
		return (mySlope);
	}

	public function getDirection():Number
	{
		// richtung als produkt der richtungen
		var direction:Number = (xdiff / Math.abs(xdiff)) * (ydiff / Math.abs(ydiff));

		// zurueck geben
		return (direction);
	}

	private function updateLengthAngleSlope():Void
	{
		// laenge ueber satz des pythagoras berechnen
		myLength = Math.sqrt((xdiff * xdiff) + (ydiff * ydiff));
		// winkel ueber tangenssatz berechnen
		myAngle = Math.atan2(ydiff, xdiff);
		// steigung als quotient
		mySlope = ydiff / xdiff;
	}

	public function setAngle(angle:Number ):Void
	{
		// x-schenkel ueber sinussatz berechnen
		var xnew:Number = Math.cos(angle) * myLength;
		// y-schenkel ueber cosinussatz berechnen
		var ynew:Number = Math.sin(angle) * myLength;

		// neue werte uebernehmen
		setDiff(xnew, ynew);
	}
	
	public function setLength(length:Number ):Void
	{
		// aktuelle laenge multiplizieren
		multiplyBy(length / getLength());
	}
	
	public function multiplyBy(factor:Number ):Void
	{
		// beide schenkel multiplizieren neue werte uebernehmen
		setDiff(xdiff * factor, ydiff * factor);
	}
	
	public function rotateBy(angle:Number ):Void
	{
		// neuen winkel setzen
		setAngle(getAngle() + angle);
	}

	public function addVector(vector:Vector ):Void
	{
		// x-schenkel addieren
		var xnew:Number = xdiff + vector.xdiff;
		// y-schenkel addieren
		var ynew:Number = ydiff + vector.ydiff;

		// neue werte uebernehmen
		setDiff(xnew, ynew);
	}

} /* end class Vector */
