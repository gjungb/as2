/* Obstacle
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Obstacle
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

class com.adgamewonderland.collision.Obstacle extends MovieClip{

	// Attributes

	private var myCirclemcs:Array;

	private var circlesActive:Boolean = false;
	
	// Operations
	
	public  function Obstacle()
	{
		// array mit registrierten circle mcs
		myCirclemcs = [];
		// registrieren
		Pinball.registerObstacle(this);
	}

	public function get active():Boolean {
		return (circlesActive);
	}

	public function set active(bool:Boolean ):Void {
		circlesActive = bool;
	}
	
	public  function registerCircle(mc:MovieClip )
	{
		// in array schreiben
		myCirclemcs.push(mc);
		// unsichtbar
		mc._visible = false;
	}

	public  function getCircles():Array
	{
		// array mit Circle-objekten
		var circles:Array = [];
		// abbrechen, wenn nicht aktiv
		if (!active) return (circles);

		// schleife ueber alle registrieren mcs
		for (var i in myCirclemcs) {
			// aktuelles mc
			var mc:MovieClip = myCirclemcs[i];
			// position
			var pos:Object = {x : mc._x, y : mc._y};
			// in globale koordinaten
			mc._parent.localToGlobal(pos);
			// radius
			var radius:Number = mc._width / 2;
			// neuer kreis
			var circle:Circle = new Circle(pos.x, pos.y, radius);
			// in array schreiben
			circles.push(circle);
		}

		// zurueck geben
		return (circles);
	}
	
	public  function onCollision(circle:Circle )
	{
// 		trace("onCollision noch nicht implementiert fuer " + this);
	
	}

} /* end class Obstacle */
