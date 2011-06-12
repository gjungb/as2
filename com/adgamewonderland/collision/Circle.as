/* Circle
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Circle
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	28.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

class com.adgamewonderland.collision.Circle{

	// Attributes
	
	public var myPosition:Point;
	
	public var myRadius:Number;
	
	// Operations
	
	public function Circle(xpos:Number , ypos:Number , radius:Number )
	{
		// position
		myPosition = new Point(xpos, ypos);
		// radius
		myRadius = radius;
	}

	public  function setPosition(xpos:Number , ypos:Number )
	{
		// neue position speichern
		myPosition.x = xpos;
		myPosition.y = ypos;
	}

	public  function getPosition():Point
	{
		return (myPosition);
	}
	
	public function getRadius():Number
	{
		return (myRadius);
	}
  
} /* end class Circle */
