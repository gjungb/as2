/* Field
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Field
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		24.05.2004
zuletzt bearbeitet:	24.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.Point;

class com.adgamewonderland.eplus.soccer.game.Field extends MovieClip {

	// Attributes
	
	private var myFigures:Array;
	
	private var mySpots:Object;
	
	private var field_mc:MovieClip, exchange_mc:MovieClip;
	
	// Operations
	
	public  function Field()
	{
		// koordinaten von spielfeld und einwechselbereich
		mySpots = {field : field_mc.getBounds(_root), exchange : exchange_mc.getBounds(_root)};
	}
	
	public function getSpot(point:Point ):String
	{
		// schleife ueber alle spots
		for (var i in mySpots) {
			// aktueller spot
			var spot = mySpots[i];
			// testen, ob innerhalb
			if (point.x > spot.xMin && point.x < spot.xMax && point.y > spot.yMin && point.y < spot.yMax) return(i);
		}
		// ausserhalb
		return ("");
	}

} /* end class Field */
