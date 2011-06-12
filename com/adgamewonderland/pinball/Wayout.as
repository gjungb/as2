/* Wayout
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Wayout
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		23.03.2004
zuletzt bearbeitet:	28.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Wayout extends Obstacle{

	// Attributes
	
	public var hitarea_mc:MovieClip;
	
	public var ani_mc:MovieClip;
	
	// Operations
	
	public  function Wayout()
	{
	
	}
	
	public  function onCollision(circle:Mover )
	{
		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();
		// testen, ob der kreis ueber hitarea rollt
		var hit:Boolean = mc.hitTest(hitarea_mc);
		// hitarea getroffen
		if (hit) {
			// ball stoppen
			Pinball.stopLevel();
			// animation
			ani_mc.play();
			// ball bewegen
			play();
			// punkte
			Pinball.countScore(200);
		}
	}

} /* end class Wayout */
