/*
klasse:			Point
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	02.02.2004
durch			gj
status:			final
*/

import com.adgamewonderland.agw.math.*;

class com.adgamewonderland.agw.math.Point{

	// Attributes

	public var myX:Number;

	public var myY:Number;

	// Operations

	public function Point(x:Number , y:Number )
	{
		myX = x;
		myY = y;
	}

	public function get x():Number {
		return (myX);
	}

	public function get y():Number {
		return (myY);
	}

	public function set x(xpos:Number ):Void
	{
		myX = xpos;
	}

	public function set y(ypos:Number ):Void
	{
		myY = ypos;
	}

	public function movePoint(v:Vector ):Void
	{
		// verschieben
		x = Number(x) + Number(v.xdiff);
		y = Number(y) + Number(v.ydiff);
	}

	public function toString() : String {
		return "com.adgamewonderland.agw.math.Point: " + x + ", " + y;
	}

} /* end class Point */
