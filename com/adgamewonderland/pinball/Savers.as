/* Savers
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Savers
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.02.2004
zuletzt bearbeitet:	05.04.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.Pinball

class com.adgamewonderland.pinball.Savers extends Obstacle{

	// Attributes
	
	public var mySavers:Array;
	
	public var saver1_mc:MovieClip;
	
	public var saver2_mc:MovieClip;
	
	public var saver3_mc:MovieClip;

	public var myInterval:Number;

	public var firstTime:Boolean;
	
	// Operations
	
	public  function Savers()
	{
		// stein mcs auf buehne
		mySavers = [saver1_mc , saver2_mc, saver3_mc];
		// aktivieren
		setActive(true);
		// zum ersten mal
		firstTime = true;
		// beim entladen deaktivieren, um interval los zu werden
		onUnload = function () {
			setActive(false);
		}
	}
	
	// de- / aktivieren
	public  function setActive (bool:Boolean )
	{
		// zweimal gleiches umschalten nicht erlaubt
		if (active == bool) return;
		// interval loeschen
		clearInterval(myInterval);
		// alle steine ein- / ausblenden
		for (var i in mySavers) mySavers[i]._visible = bool;
		// kreise fuer kollision de- / aktivieren
		active = bool;
		// nach pause wieder deaktivieren
		if (bool) myInterval = setInterval(this, "play", 30000);
	}
	
// 	// wird bei positivem hittest des balls mit den savern aufgerufen
// 	public  function onCollision(circle:Mover )
// 	{		
// 		// movieclip des kreises
// 		var mc:MovieClip = circle.getMovieclip();
// 
// 		// schleife ueber alle saver
// 		for (var i in mySavers) {
// 			// aktueller stein
// 			var saver:MovieClip = mySavers[i];
// 			// hit test
// 			var hit:Boolean = (mc.hitTest(saver) && saver._visible);
// 			// stein getroffen
// 			if (hit) {
// 				// sound abspielen
// 				_root.sound_mc.setSound("ssaver", 1);
// 				// ball frontal reflektieren
// 				// bewegungsrichtung des balls
// 				var trajectory:Line = circle.getTrajectory();
// 				// senkrechte dazu
// 				var perpendicular:Line = trajectory.getPerpendicular();
// 				// bewegungswinkel des balls aendern
// 				circle.changeAngleOnCollision(perpendicular);
// 				// beschleunigen
// 				circle.changeSpeedOnCollision(1.2);
// 			}
// 		}
// 	}

} /* end class Savers */
