/* Honeycombs
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Honeycombs
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		16.02.2004
zuletzt bearbeitet:	28.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.Pinball

class com.adgamewonderland.pinball.Honeycombs extends Obstacle{

	// Attributes

	public var myHoneycombs:Array;

	public var back_mc:MovieClip;

	// Operations

	public  function Honeycombs()
	{
		// wabe ani mcs auf buehne (registrieren sich)
		myHoneycombs = [];

	}

	public  function registerHoneycomb(mc:MovieClip )
	{
		// registrieren
		myHoneycombs.push(mc);
	}

	public  function onCollision(circle:Mover )
	{
		// abbrechen, wenn schon alle waben weg sind
		if (myHoneycombs.length == 0) return;
		
		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();
		// schleife ueber alle waben
		for (var i in myHoneycombs) {
			// aktuelle wabe
			var honeycomb:MovieClip = myHoneycombs[i];
// 			// mittelpunkt der wabe
// 			var center:Object = {x : honeycomb._x, y : honeycomb._y};
// 			// in globale koordinaten
// 			this.localToGlobal(center);
// 			// testen, ob der kreis ueber den mittelpunkt der wabe rollt
// 			var hit:Boolean = mc.hitTest(center.x, center.y, true);
			// testen, ob der kreis ueber die wabe rollt
			var hit:Boolean = mc.hitTest(honeycomb.wabe_mc);
			// wabe getroffen
			if (hit) {
				// sound abspielen
				_root.sound_mc.setSound("shoneycomb", 1);
				// punkte
				Pinball.countScore(5);
				// aus array werfen
				myHoneycombs.splice(i, 1);
				// loeschen
				honeycomb.unloadMovie();
				// hintergrund verkleinern
				back_mc.nextFrame();

				// ball frontal reflektieren
				// bewegungsrichtung des balls
				var trajectory:Line = circle.getTrajectory();
				// senkrechte dazu
				var perpendicular:Line = trajectory.getPerpendicular();
				// bewegungswinkel des balls aendern
				circle.changeAngleOnCollision(perpendicular);
				// abbremsen
				circle.changeSpeedOnCollision(0.70);
				
				// abbrechen
				break;
			}
		}
		// testen, ob alle waben weg
		if (getNumHoneycombs() == 0) {
			// welche anderen honeycombs gibt es noch
			if (this._name == "honeycombs1_mc") {
				var brother:MovieClip = _parent.honeycombs2_mc;
			} else {
				var brother:MovieClip = _parent.honeycombs1_mc;
			}
			// testen, ob die auch alle weg sind
			if (brother.getNumHoneycombs() == 0) {
				// bienenkorb oeffnen
				_parent.beehive_mc.setState(true);
			}
		}
	}

	public  function getNumHoneycombs():Number
	{
		// laenge des arrays entspricht anzahl der uebrigen mcs
		return (myHoneycombs.length);

	}

} /* end class Honeycombs */
