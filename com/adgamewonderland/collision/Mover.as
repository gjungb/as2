/* Mover
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Mover
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	28.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

class com.adgamewonderland.collision.Mover extends Circle{

	// Attributes
	
// 	public var myPosition:Point;
	
	public var myVelocity:Vector;
	
	public var myVmax:Number;
	
	public var myAcceleration:Vector;
	
	public var myTrajectory:Line;

	public var myContactObj;
	
	public var myContactNum:Number;
	
	public var myMovieclip:MovieClip;
	
	public var myCell:Object;
	
	// Operations
	
	public  function Mover(xpos:Number , ypos:Number , radius:Number)
	{
		// radius
		myRadius = radius;
		// position
		myPosition = new Point(xpos, ypos);
		// geschwindigkeit
		myVelocity = new Vector(0, 0);
		// maximale lineargeschwindigkeit
		myVmax = 20;
		// beschleunigung
		myAcceleration = new Vector(0, 0);
		// bewegungsrichtung
		myTrajectory = new Line(0, 0);

		myContactObj = null;
		
		// zahl der beruehrungskontakte
		myContactNum = 0;
		// aktuelle rasterzelle
		myCell = new Object();
		// movieclip, das den mover auf der buehne anzeigt
		myMovieclip = new MovieClip();

	}

	public  function getVelocity():Vector
	{
		return (myVelocity);
	}

	public  function getAcceleration():Vector
	{
		return (myAcceleration);
	}

	public  function getTrajectory():Line
	{
		return (myTrajectory);
	}

	public  function getContactObj()
	{
		return (myContactObj);
	}

	public  function getContactNum()
	{
		return (myContactNum);
	}

	public  function getCell()
	{
		return (myCell);
	}

	public  function setVelocity(xdiff:Number, ydiff:Number )
	{
		// kleine werte abfangen
		if (Math.abs(xdiff) <= 0.01) xdiff *= 1 / 100000;
		if (Math.abs(ydiff) <= 0.01) ydiff *= 1 / 100000;
		// neue geschwindigkeit speichern
		myVelocity.setDiff(xdiff, ydiff);
		// bewegungsrichtung updaten
		updateTrajectory();
	}

	public  function setAcceleration(acceleration:Vector )
	{
		// neue beschleunigung speichern
		myAcceleration = acceleration;
	}

	public  function updateTrajectory()
	{
		// steigung des geschwindigkeitsvektors
		var slope:Number = myVelocity.getSlope();
		// aktuelle position
		var point = getPosition();
		// y-achsenabschnitt aus steigung und aktueller position (b = y - m*x)
		var intercept:Number = point.y - slope * point.x;
		// linie updaten: y-achsenabschnitt
		myTrajectory.setIntercept(intercept);
		// linie updaten: steigung
		myTrajectory.setSlope(slope);
	}

	public  function setContactObj(obj )
	{
		// object, das ich gerade beruehre speichern
		myContactObj = obj;
	}

	public  function setContactNum(num:Number )
	{
		// zahl der beruehrungskontakte
		myContactNum = num;
	}

	public  function setCell(cell:Object )
	{
		// aktuelle rasterzelle
		myCell = cell;
	}

	public  function registerMovieclip(mc:MovieClip )
	{
		myMovieclip = mc;
	}
	
	// movieclip zurueck geben
	public  function getMovieclip():MovieClip
	{
		return (myMovieclip);
	}

	public  function unregisterMovieclip()
	{
		// von buehne loeschen
		myMovieclip.removeMovieClip();
		// referenz loeschen
		myMovieclip = null;
	}

	public  function updateStage()
	{
		// registriertes movieclip positionieren
		myMovieclip._x = myPosition.x;
		myMovieclip._y = myPosition.y;
	}

	public  function getNextPosition(steps:Number ):Point
	{
		// aktuelle position
		var point:Point = getPosition();
		// aktuelle geschwindigkeit
		var velo:Vector = getVelocity();
		// aktuelle beschleunigung
		var acc:Vector = getAcceleration();
		// neue position
		var nextpos:Point = new Point(point.x + steps * (velo.xdiff + acc.xdiff), point.y + steps * (velo.ydiff  + acc.ydiff));

		// zurueck geben
		return (nextpos);
	}
	
	public  function getFrontPosition():Point
	{
		// aktuelle bewegungsrichtung
		var trajectory:Line = getTrajectory();
		// steigung
		var slope:Number = trajectory.getSlope();
		// radius
		var radius:Number = getRadius();
		// aktuelle position
		var position:Point = getPosition();
		// x-abstand
		var dx:Number = Math.sqrt(radius * radius / (1 + slope * slope));
		// y-abstand
		var dy:Number = slope * dx;
		
		// 1. der beiden moeglichen position
		var pos1:Point = new Point(position.x + dx, position.y + dy);
		// abstand dieser position zur naechsten position des balls
		var diff1:Number = Detector.getPointPointDistance(getNextPosition(1), pos1);
		// 2. der beiden moeglichen position
		var pos2:Point = new Point(position.x - dx, position.y - dy);
		// abstand dieser position zur naechsten position des balls
		var diff2:Number = Detector.getPointPointDistance(getNextPosition(1), pos2);

		// gesuchte position
		var frontpos:Point = (diff1 < diff2 ? pos1 : pos2);
		
		// zurueck geben
		return (frontpos);
	}

	public  function getTimeToPoint(point:Point ):Number
	{
		// abbrechen, wenn zielpunkt nicht auf bewegungslinie liegt
		if (!Detector.checkPointOnLine(point, getTrajectory())) {
			return (1000);
		}
		
		// naechste position des movers
		var pos:Point = getNextPosition(1);

		// abstand zum ziel in x-richtung
		var xdiff:Number = point.x - pos.x;
		// abstand zum ziel in y-richtung
		var ydiff:Number = point.y - pos.y;
		// zeit = 0, wenn abstand in beide richtungen 0
		if (xdiff == 0 && ydiff == 0) return (0);
		
		// vorzeichen in x-richtung
		var xsign:Number = (xdiff > 0 ? 1 : -1); // * 1e14 
		if (xdiff == 0) xsign = 0;
		// vorzeichen in y-richtung
		var ysign:Number = (ydiff > 0 ? 1 : -1); // * 1e14  
		if (ydiff == 0) ysign = 0;
		// vorzeichen der geschwindigkeit in x-richtung
		var vxsign:Number = (getVelocity().xdiff  > 0 ? 1 : -1); // * 1e14 
		if (getVelocity().xdiff == 0) vxsign = 0;
		// vorzeichen der geschwindigkeit in y-richtung
		var vysign:Number = (getVelocity().ydiff  > 0 ? 1 : -1); // * 1e14 
		if (getVelocity().ydiff == 0) vysign = 0;
		// abbrechen, wenn zielpunkt nicht in bewegungsrichtung liegt
		if (xsign != vxsign && ysign != vysign) {
			return (2000);
		}

		// abstand bis zum zielpunkt
		var distance:Number = Detector.getPointPointDistance(pos, point);
		// aktuelle lineargeschwindigkeit
		var velolin:Number = getVelocity().getLength();
		// zeit bis zum zielpunkt
		var time:Number = distance / velolin;

		// zurueck geben
		return(time);
	}

	public  function changeAngleOnCollision(line:Line )
	{
// 		trace("changeAngleOnCollision");
		// bisheriger winkel
		var oldangle:Number = myVelocity.getAngle();
		// winkel der linie, mit der ich kollidiere
		var lineangle:Number = Math.atan(line.getSlope());
		// neuer winkel ist doppeltes des linienwinkels - bisherigem winkel
		var newangle:Number = lineangle + lineangle - oldangle;

		// geschwindigkeitsvektor aendern
		myVelocity.setAngle(newangle);

		// bewegungsrichtung
		updateTrajectory();
	}
	
	public  function changeAngleOnContact(line:Line, first:Boolean )
	{
// 		trace("changeAngleOnContact");
		// neuer winkel ist winkel der linie, die ich beruehre
		var newangle:Number = Math.atan(line.getSlope());
		// aktuelle lineargeschwindigkeit
// 		var velolin:Number = getVelocity().getLength();
// 		trace("velo: " + velolin);
		// geschwindigkeitsvektor aendern
		myVelocity.setAngle(newangle);
		// geschwindigkeit an winkel anpassen
		myVelocity.multiplyBy(Math.sin(newangle));
		// beschleunigungsvektor aendern
		myAcceleration.setAngle(newangle);
		// beschleunigung an winkel anpassen
		myAcceleration.multiplyBy(Math.sin(newangle) * 2);
		// bei erstem kontakt
// 		if (first) {
// 			// geschwindigkeit an winkel anpassen
// 			myVelocity.multiplyBy(Math.sin(newangle));
// 			// beschleunigung an winkel anpassen
// 			myAcceleration.multiplyBy(Math.sin(newangle));
// 			// laenge an bisherige lineargeschwindigkeit anpassen
// 			myVelocity.multiplyBy(velolin / getVelocity().getLength());
// 		}
// 		trace("acc: " + myAcceleration.getLength());

		// bewegungsrichtung
		updateTrajectory();
	}
	
	public  function changeAngleOnFlipper(flipperline:Line, radius:Number, percent:Number, flipperup:Boolean, relation:Number)
	{
		// waagerechte linie
		var line:Line = new Line(0, 1e-8);
		// lotrechte linie
		var perpendicular:Line = line.getPerpendicular();
		// verschieben, so dass sie durch meinen mittelpunkt gibt
		perpendicular.moveToPoint(getPosition());
		// schnittpunkt zwischen flipperlinie und lotrechter
		var intersection:Point = Detector.getLineLineIntersection(flipperline, perpendicular);
		// weiter nach aussen
		var xpos:Number = intersection.x + percent / 100 * 50;
		// weiter nach oben
		var ypos:Number = flipperline.getY(xpos) + relation * 2 * radius;
		// an neue position
		setPosition(xpos, ypos);
		
		// neuer winkel (270° +/- 65°)
		var newangle:Number = (270 + percent / 100 * 65) / 180 * Math.PI; // Math.PI / 2 * 3 + percent / 100 * Math.PI / 4;
		// nach unten ?
		if (!flipperup) newangle += Math.PI;
		// geschwindigkeitsvektor aendern
		myVelocity.setAngle(newangle);

		// bewegungsrichtung
		updateTrajectory();
		// anzeigen
		updateStage();
	}
	
	public  function changeSpeedOnCollision(factor:Number )
	{
		// geschwindigkeitsvektor aendern
		myVelocity.multiplyBy(factor);
		// neue lineargeschwindigkeit
		var velolin:Number = getVelocity().getLength();
		// ggf. deckeln
		if (velolin > myVmax) myVelocity.multiplyBy(myVmax / velolin);
	}

	// geschwindigkeit um beschleunigung aendern
	public  function updateVelocity()
	{
		// aktuelle beschleunigung
		var acc:Vector = getAcceleration();
		// aktuelle geschwindigkeit
		var velo:Vector = getVelocity();
		// neue geschwindigkeit
		setVelocity(acc.xdiff + velo.xdiff, acc.ydiff + velo.ydiff);

	}

} /* end class Mover */
