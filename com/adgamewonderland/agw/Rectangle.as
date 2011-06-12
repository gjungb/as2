import com.adgamewonderland.agw.Bounds;
/* Rectangle
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Rectangle
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		01.12.2003
zuletzt bearbeitet:	01.12.2003
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.Rectangle extends MovieClip{

  // Attributes

  public var bounds:Bounds;

  public var linestyle:Object;

  public var fillstyle:Object;

  // Operations

  public  function Rectangle(bounds:Bounds , linestyle:Object , fillstyle:Object ) {
	// linienstil
	// TODO linienstil festlegen
	// an startpunkt
	this.moveTo(bounds.xMin, bounds.yMin);
	// fuellung
	this.beginFill(fillstyle.col, fillstyle.alpha);
	// nach rechts
	this.lineTo(bounds.xMax, bounds.yMin);
	// nach unten
	this.lineTo(bounds.xMax, bounds.yMax);
	// nach links
	this.lineTo(bounds.xMin, bounds.yMax);
	// nach oben
	this.lineTo(bounds.xMin, bounds.yMin);
  }

} /* end class Rectangle */
