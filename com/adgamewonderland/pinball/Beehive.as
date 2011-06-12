/* Beehive
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Beehive
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		16.02.2004
zuletzt bearbeitet:	05.04.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.Pinball

class com.adgamewonderland.pinball.Beehive extends Obstacle{

	// Attributes

	private var door_mc:MovieClip;

	private var myState:Boolean;

	private var firstTime:Boolean;

	private var myInterval:Number;

	// Operations

	public  function Beehive()
	{
		// status (false : geschlossen, true : geoeffnet)
		myState = false;
		// landen im korb darf nur einmal gezaehlt werden
		firstTime = true;
		
// 		setState(true);

	}

	public  function onCollision(circle:Mover )
	{
		// abbrechen, wenn geschlossen
		if (myState == false) return;

		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();
		// mittelpunkt des kreises
		var center:Object = {x : mc._x, y : mc._y};
		// in globale koordinaten
		mc._parent.localToGlobal(center);
		// testen, ob der mittelpunkt des kreises ueber die tuer rollt
		var hit:Boolean = door_mc.hitTest(center.x, center.y, true);
// 		var hit:Boolean = door_mc.hitTest(mc);
		// tuer zum ersten mal getroffen
		if (hit && firstTime) {
			// nur einmal
			firstTime = false;
			// sound abspielen
			_root.sound_mc.setSound("sballout", 1);
			// ball stoppen
			Pinball.stopBall();
			// punkte
			Pinball.countScore(500);
			// extra ball
			Pinball.extraBall();
			// nach pause tuer wieder schliessen
			myInterval = setInterval(this, "setState", 5000, false);
		}
	}

	public  function setState(bool:Boolean )
	{
		// interval loeschen
		clearInterval(myInterval);
		// status umschalten
		myState =bool;
		// kreise fuer kollision de- / aktivieren
		active = !bool;
		// landen im korb darf nur einmal gezaehlt werden
		firstTime = true;
		// tuer oeffnen / schliessen
		gotoAndStop(myState ? 2 : 1);

	}

} /* end class Beehive */
