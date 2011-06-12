/* Stones
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Stones
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.02.2004
zuletzt bearbeitet:	29.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.Pinball

class com.adgamewonderland.pinball.Stones extends Obstacle{

	// Attributes
	
	public var myStones:Array;
	
	public var stone1_mc:MovieClip;
	
	public var stone2_mc:MovieClip;
	
	public var stone3_mc:MovieClip;

	public var rock_mc:MovieClip;
	
	// Operations
	
	public  function Stones()
	{
		// stein mcs auf buehne
		myStones = [stone1_mc , stone2_mc, stone3_mc];
		// kreise fuer kollision aktivieren
		active = true;
	}
	
	// wird bei positivem hittest des balls mit den steine aufgerufen
	public  function onCollision(circle:Mover )
	{
		// abbrechen, wenn schon alle steine weg sind
		if (myStones.length == 0) return;
		
		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();

		// schleife ueber alle steine
		for (var i in myStones) {
			// aktueller stein
			var stone:MovieClip = myStones[i];
// 			// ungefaehrer mittelpunkt des steins
// 			var center:Object = {x : stone._x + stone._width / 6, y : stone._y + stone._height / 6}; 
// 			// in globale koordinaten
// 			this.localToGlobal(center);
// 			// testen, ob der kreis ueber den mittelpunkt des steins rollt
// 			var hit:Boolean = mc.hitTest(center.x, center.y, true);
			var hit:Boolean = mc.hitTest(stone);
			// stein getroffen
			if (hit) {
				// aus array werfen
				myStones.splice(i, 1);
				// animieren
				stone.play();
				// ende ueberwachen
				stone.onEnterFrame = function () {
					// am ende
					if (this._currentframe == this._totalframes) {
						// deaktivieren
						_parent.showRock();
						// punkte
						Pinball.countScore(200);
						// ueberwachung beenden
						delete(this.onEnterFrame);
					}
				}
				// abbrechen
				break;
			}
		}

// 		// kollision mit rock (falls der noch sichtbar ist)
// 		if (rock_mc._visible) {
// 			// mittelpunkt des kreises
// 			var center:Object = {x : mc._x, y : mc._y};
// 			// in globale koordinaten
// 			mc._parent.localToGlobal(center);
// 			// testen, ob der mittelpunkt des kreises ueber den rock rollt
// 			var hit:Boolean = rock_mc.hitTest(center.x, center.y, true);
// 			// rock getroffen
// 			if (hit) {
// 				// ball frontal reflektieren
// 				// bewegungsrichtung des balls
// 				var trajectory:Line = circle.getTrajectory();
// 				// senkrechte dazu
// 				var perpendicular:Line = trajectory.getPerpendicular();
// 				// bewegungswinkel des balls aendern
// 				circle.changeAngleOnCollision(perpendicular);
// 				// abbremsen
// 				circle.changeSpeedOnCollision(0.70);
// 			}
// 		}
	}
	
	public  function showRock()
	{
		// kreise fuer kollision de- / aktivieren
		active = (myStones.length != 0);
		// testen, ob alle steine weg
		if  (!active) {
			// rock unsichtbar (und damit durchlaessig) machen
			rock_mc._visible = false;
			// sound abspielen
			_root.sound_mc.setSound("srock", 1);
			// punkte
			Pinball.countScore(250);
		}
	}

} /* end class Stones */
