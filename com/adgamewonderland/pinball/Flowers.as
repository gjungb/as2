/* Flowers
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Flowers
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

class com.adgamewonderland.pinball.Flowers extends Obstacle {

	// Attributes

	public var myFlowers:Array;
	
	public var myNum:Number;
	
	public var flower1_mc:MovieClip;
	
	public var flower2_mc:MovieClip;
	
	public var flower3_mc:MovieClip;
	
	public var mySavers:MovieClip;

	public var myInterval:Number;
	
	// Operations
	
	public  function Flowers()
	{
		// blumen mcs auf buehne
		myFlowers = [flower1_mc, flower2_mc, flower3_mc];
		// saver, die aktiviert werden
		mySavers = (this._name.indexOf("2") == -1 ? _parent.savers_mc : _parent.savers2_mc);
		// initialisieren
		initFlowers();
		// beim entladen initialisieren, um interval los zu werden
		onUnload = function () {
			initFlowers();
		}
	}
	
	// initialisieren
	public  function initFlowers()
	{
		// interval loeschen
		clearInterval(myInterval);
		// alle blumen ausblenden
		for (var i in myFlowers) myFlowers[i]._alpha = 0;
		// anzahl der eingeblendeten blumen
		myNum = 0;
	}
	
	// wird bei positivem hittest des balls mit den blumen aufgerufen
	public  function onCollision(circle:Mover )
	{
		// abbrechen, wenn schon alle blumen weg sind
		if (myNum == myFlowers.length) return;
		
		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();
		// schleife ueber alle blumen
		for (var i in myFlowers) {
			// aktuelle blume
			var flower:MovieClip = myFlowers[i];
// 			// mittelpunkt der blume
// 			var center:Object = {x : flower._x, y : flower._y};
// 			// in globale koordinaten
// 			this.localToGlobal(center);
// 			// testen, ob der kreis ueber den mittelpunkt der blume rollt
// 			var hit:Boolean = mc.hitTest(center.x, center.y, true);
			var hit:Boolean = mc.hitTest(flower);
			// blume getroffen
			if (hit && flower._alpha != 100) {
				// einblenden
				flower._alpha = 100;
				// hochzaehlen
				myNum ++;
				// sound abspielen
				_root.sound_mc.setSound("sflower", 1);
				// punkte
				Pinball.countScore(500);
				// abbrechen
				break;
			}
		}
		// testen, ob alle blumen eingeblendet
		if (myNum == myFlowers.length) {
			// saver aktivieren
			mySavers.setActive(true);
			// nach pause wieder initialisieren
			myInterval = setInterval(this, "play", 1000);
		}
	}

} /* end class Flowers */
