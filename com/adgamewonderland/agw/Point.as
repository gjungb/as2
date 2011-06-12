/* Point
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Point
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	23.05.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.Point {
	
	// Attributes
	
	private var myX:Number;
	
	private var myY:Number;
	
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
	
	public function set x(xpos:Number):Void {
		myX = xpos;
	}
	
	public function set y(ypos:Number):Void {
		myY = ypos;
	}
	
} /* end class Point */
