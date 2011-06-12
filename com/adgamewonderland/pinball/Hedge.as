/* Hedge
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Hedge
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

class com.adgamewonderland.pinball.Hedge extends Obstacle {

	// Attributes
	
	// Operations
	
	public  function Hedge()
	{

	}
	
	public  function onCollision(circle:Mover )
	{
		// vorderer punkt des balls in bewegungsrichtung
		var frontpos:Point = circle.getFrontPosition(); // getNextPosition(1); // getFrontPosition();
		// testen, ob ball in hecke
		if (this.hitTest(frontpos.x, frontpos.y, true)) {
			// ball frontal reflektieren
			// bewegungsrichtung des balls
			var trajectory:Line = circle.getTrajectory();
			// senkrechte dazu
			var perpendicular:Line = trajectory.getPerpendicular();
			// bewegungswinkel des balls aendern
			circle.changeAngleOnCollision(perpendicular);
		}
	}

} /* end class Hedge */
