/* Flipper
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Flipper
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		04.02.2004
zuletzt bearbeitet:	14.04.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.Pinball

class com.adgamewonderland.pinball.Flipper extends MovieClip {

	// Attributes

	public var _mySymbol:String, myFlipper:MovieClip;

	public var _myKey:Number, myKey:Number;

	public var _myAngle:Object, myAngle:Object;
	
	public var isActive:Boolean;

	public var myLines:Array;

	public var myCirclemcs:Array;

	public var hitarea_mc:MovieClip;

	// Operations

	public  function Flipper()
	{
		// nicht aktiv
		isActive = false;
		// array mit registrierten linien mcs und deren richtungen
		myLines = [];
		// array mit registrierten circle mcs
		myCirclemcs = [];
		// auf buehne bringen
		myFlipper = attachMovie(_mySymbol, "flipper_mc", 1);

		// taste aus komponentenparametern
		myKey = _myKey;

		// winkelinfos aus komponentenparametern
		myAngle = _myAngle;

		// registrieren
		Pinball.registerFlipper(this);

		// hitarea drehen
		hitarea_mc._xscale *= myAngle["adir"];
	}
	
	public  function setActive(bool:Boolean )
	{
		// umschalten
		isActive = bool;
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

	public  function registerLine(mc:MovieClip, dir:Number )
	{
		// in array schreiben
		this.myLines.push({mc : mc, dir : dir});
		// unsichtbar
		mc._visible = false;
	}

	public  function getLines(playground:MovieClip, usenextangle:Boolean ):Array
	{
		// array mit Line-objekten
		var lines:Array = [];

		// schleife ueber alle registrieren mcs
		for (var i in myLines) {
			// aktuelles mc
			var mc:MovieClip = myLines[i].mc;
			// richtung
			var dir:Number = myLines[i].dir;
			// steigung bei drehung 0
			var slope:Number = mc._height / mc._width * dir;
			// neue linie
			var line:Line = new Line(0, slope);
			// drehen
			line.rotateLine((usenextangle ? getNextAngle(Key.isDown(myKey)) : myFlipper._rotation) / 180 * Math.PI);
			// position
			var pos:Object = {x : mc._x, y : mc._y};
			// in globale koordinaten
			mc._parent.localToGlobal(pos);
			// parallel verschieben, so dass sie deckungsgleich mit dem mc ist
			line.moveToPoint(new Point(pos.x, pos.y));
			// grenzen auf der buehne
			var bounds:Object = mc.getBounds(playground);
			// in strecke teilen
			line.segmentLine(bounds.xMin, bounds.xMax);
			// typ setzen
			line.setType("flipper");

			// in array schreiben
			lines.push(line);
		}
		// zurueck geben
		return (lines);

	}
	
	public  function getNextAngle(bool:Boolean ):Number
	{
		// drehung nach oben oder unten
		var rot:Number = myFlipper._rotation;
		// je nach tastendruck
		if (bool) {
			// nach oben
			rot += myAngle.astep * myAngle.adir;
			// hitarea ausblenden
			hitarea_mc._visible = false;
		} else {
			// nach unten
			rot -= myAngle.astep * myAngle.adir;
			// hitarea einblenden
			hitarea_mc._visible = true;
		}

		// testen, ob innerhalb der grenzen
		if (rot > myAngle.amax) rot = myAngle.amax;
		if (rot < myAngle.amin) rot = myAngle.amin;
		
		// zurueck geben
		return(rot);
	}
	
	public  function setAngle(angle:Number )
	{
		// auf buehne zeigen
		myFlipper._rotation = angle;
	}

	public  function updateAngle(circle:Mover, playground:MovieClip ):Boolean
	{
		// abbrechen, wenn nicht aktiv
		if (!isActive) return;
		// neuen winkel holen
		var newangle:Number = getNextAngle(Key.isDown(myKey));
		// aktuelle position des balls
		var position = circle.getNextPosition(0);
		// obere linie des flippers
		var upperline:Line = getLines(playground, false)[0];
		// relation zwischen ball und oberer linie des flippers (-1: oberhalb, 1: unterhalb)
		var relation:Number = Detector.getPointLineRelation(position, upperline);
		// wurde der winkel seit dem letzten mal geaendert
		var anglechanged = (newangle != myFlipper._rotation);
		// flipper wurde bewegt
		if (anglechanged) {
			// auf buehne zeigen
			setAngle(newangle);
			// flipper nach oben bewegt
			var flipperup:Boolean = (newangle == (myAngle.adir == 1 ? myAngle.amax : myAngle.amin));
			// vorderer punkt des balls in bewegungsrichtung
			var frontpos:Point = circle.getFrontPosition();
			// testen, ob ball in der naehe des flippers
			if (hitarea_mc.hitTest(frontpos.x, frontpos.y, true)) {
				// sound abspielen
				_root.sound_mc.setSound("sflipper", 1);
				// punkte
				Pinball.countScore(10);
				// verbindungslinie zwischen flipper und ball
				var connection:Line = Detector.getCircleFlipperConnection(circle, this, -myAngle["adir"]);
				// obere / untere linie des flippers
				var flipperline:Line = (relation == -1 ? getLines(playground, true)[0] : getLines(playground, true)[1]); // getLines(playground)[0]; 
				// endpunkte der linie
				var ends:Object = flipperline.getEnds();
				// abstand der endpunkte
				var flipperlinelength:Number = Detector.getPointPointDistance(ends["start"], ends["end"]) / 2;
				// abstand zwischen drehpunkt und ball
				var connectionlength:Number = Detector.getPointPointDistance(new Point(_x, _y), circle.getPosition());
				// relativer abstand zwischen ball und drehpunkt
				var percent = Math.round(connectionlength / flipperlinelength * 100) - 30;
				// positionieren, damit ball am flipper klebt; ausfallswinkel setzen
				circle.changeAngleOnFlipper(flipperline, circle.getRadius(), -myAngle["adir"] * percent, flipperup, relation);
				
				// aktuelle geschwindigkeit des balls
				var velolin:Number = circle.getVelocity().getLength();
				// gewuenschte geschwindigkeit (nur nach oben beschleunigen)
				var newvelo:Number = (relation == -1 ? 12 + percent / 100 * 8 : 1);
				// beschleunigen
				circle.changeSpeedOnCollision(newvelo / velolin);
				
// 				if (relation == 1) {
// 					upperline.drawLine(_root.grid_mc, 2, 0xffccff, 100);
// 					Pinball.stopLevel();
// 				}
				
				return true;
				
			} else {
				
				return false;
			}
		} else {
			return false;
		}
	}

} /* end class Flipper */
