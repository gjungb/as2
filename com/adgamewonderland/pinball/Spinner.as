/* Spinner
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Spinner
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.02.2004
zuletzt bearbeitet:	26.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Spinner extends Obstacle{

	// Attributes
	
	public var myHitareas:Array;
	
	public var hitarea1_mc:MovieClip;
	
	public var hitarea2_mc:MovieClip;

	public var myLastHit:Number;

	public var myInterval:Number;
	
	// Operations
	
	public  function Spinner()
	{
		// hitarea mcs auf buehne
		myHitareas = [hitarea1_mc, hitarea2_mc];
		// zuletzt vom kreis ueberrollte hitarea
		myLastHit = myHitareas.length;
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
				// testen, ob andere als beim letzten mal
				if (i != myLastHit) {
					// sound abspielen
					_root.sound_mc.setSound("sspinner", 1);
					// punkte
					Pinball.countScore(200);
					// testen, ob nummer groesser als bisher (sprich richtig rum gerollt)
					if (i > myLastHit) {
						// banditen ausloesen
						_parent.bandit_mc.startBandit();
					}
					// wenn 0te hitarea, nach pause wieder resetten
					if (i == 0) myInterval = setInterval(this, "resetSpinner", 3000);
					// nummer merken
					myLastHit = Number(i);
				}
				// abbrechen
				break;
			}
		}
	}
	
	public  function resetSpinner()
	{
		// interval loeschen
		clearInterval(myInterval);
		// zuletzt vom kreis ueberrollte hitarea
		myLastHit = myHitareas.length;
	}

} /* end class Spinner */
