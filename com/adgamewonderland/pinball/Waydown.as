/* Waydown
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Waydown
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		25.04.2004
zuletzt bearbeitet:	25.04.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Waydown extends Obstacle{

	// Attributes
	
	public var myHitareas:Array;
	
	public var hitarea1_mc:MovieClip;
	
	public var hitarea2_mc:MovieClip;
	
	// Operations
	
	public  function Waydown()
	{
		// hitarea mcs auf buehne
		myHitareas = [hitarea1_mc, hitarea2_mc];
	}
	
	public  function onCollision(circle:Mover )
	{
		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();
		// schleife ueber alle hitareas
		for (var i in myHitareas) {
			// aktuelle hitarea
			var hitarea:MovieClip = myHitareas[i];
			// testen, ob der kreis ueber hitarea rollt
			var hit:Boolean = mc.hitTest(hitarea);
			// hitarea getroffen
			if (hit) {
				// flipper nach unten
				Pinball.stopFlippers();
				// abbrechen
				break;
			}
		}
	}

} /* end class Waydown */
