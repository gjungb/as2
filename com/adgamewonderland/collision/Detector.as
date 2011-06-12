/* Detector
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Detector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		18.01.2004
zuletzt bearbeitet:	05.04.2004
durch			gj
status:			final
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.*

class com.adgamewonderland.collision.Detector{

	// Attributes

	// Operations

	/*static public  function Detector()
	{

	}*/

	static public function getLineLineIntersection(line1:Line , line2:Line ):Point
	{
		// achsenabschnitt 1. linie
		var b1 = line1.getIntercept();
		// achsenabschnitt 2. linie
		var b2 = line2.getIntercept();
		// steigung 1. linie
		var m1 = line1.getSlope();
		// steigung 2. linie
		var m2 = line2.getSlope();
		// x-schnittpunkt
		var x = (b2 - b1) / (m1 - m2);
		// parallelen abfangen
		if (m1 == m2) x = 1e8;
		// y-schnittpunkt
		var y = m1 * x + b1;

		// schnittpunkt zurueck geben
		return(new Point(x, y));
	}

	static public function getCircleLineIntersection(circle:Mover , line:Line ):Point
	{
		// bewegungsrichtung des kreises
		var trajectory:Line = circle.getTrajectory();
		// schnittpunkt zwischen bewegungsrichtung und linie
		var intersection:Point = getLineLineIntersection(trajectory, line);

		// winkel der bewegungsrichtung des kreises (= einfallswinkel zu einer geraden mit steigung 0)
		var theta:Number = getLineLineAngle(trajectory, new Line(0, 0));
		// einfallswinkel zwischen bewegungsrichtung des kreises und linie
		var gamma:Number = getLineLineAngle(trajectory, line);

		// abstand in bewegungsrichtung zwischen schnittpunkt und position zum zeitpunkt der kollison (aus sinussatz)
		var diff:Number = circle.getRadius() / Math.sin(gamma);

		// x-koordinate der kollisonsposition
		var xtheo1:Number = intersection.x - diff * Math.cos(theta);
		// y-koordinate der kollisonsposition
		var ytheo1:Number = intersection.y - diff * Math.sin(theta);
		// (theoretische) position des kreises zum zeitpunkt der kollison
		var collision1:Point = new Point(xtheo1, ytheo1);
		// abstand des kreises bis zur position zum zeitpunkt der kollison
		var diff1:Number = getPointPointDistance(circle.getPosition(), collision1); // getNextPosition(1)

		// x-koordinate der kollisonsposition
		var xtheo2:Number = intersection.x + diff * Math.cos(theta);
		// y-koordinate der kollisonsposition
		var ytheo2:Number = intersection.y + diff * Math.sin(theta);
		// (theoretische) position des kreises zum zeitpunkt der kollison
		var collision2:Point = new Point(xtheo2, ytheo2);
		// abstand des kreises bis zur position zum zeitpunkt der kollison
		var diff2:Number = getPointPointDistance(circle.getPosition(), collision2); // getNextPosition(1)

		// naehere position zum zeitpunkt der kollison
		var collision:Point = (diff1 < diff2 ? collision1 : collision2);

		// position zurueck geben
		return(collision);
	}
	
	static public  function getCircleLineContact(circle:Mover, line:Line ):Point
	{
		// position des kreises
		var position:Point = circle.getNextPosition(1); // getPosition();
		// radius des kreises
		var radius:Number = circle.getRadius();
		// abstand zwischen mover und linie
		var distance:Number = getPointLineDistance(position, line);
		// differenz, um die der kreis verschoben werden muss
		var diff:Number = distance - radius;
		// senkrechte zur linie (auf der senkrechten wird der kreis verschoben)
		var perpendicular:Line = line.getPerpendicular();
		// steigung der senkrechten
		var slope = perpendicular.getSlope();
		// x-differenz aus cosinussatz
		var xdiff:Number = diff * Math.cos(slope);
		// y-differenz aus sinussatz
		var ydiff:Number = diff * Math.sin(slope);
		// darf nur nach oben verschoben werden
		if (ydiff > 0) {
			ydiff *= -1;
			xdiff *= -1;
		}
		// neue position zurueck geben
		return (new Point(position.x + xdiff, position.y + ydiff));
	}

	static public function checkCircleLineCollision(circle:Mover , line:Line ):Boolean
	{
		// (theoretische) position des kreises zum zeitpunkt der kollison
		var collision:Point = getCircleLineIntersection(circle, line);
		// abbrechen, wenn theoretische position nicht auf der strecke liegt
		if (!checkPointOnSegment(collision, line)) return (false);

		return(true);
	}
	
	static public function timeToCircleLineCollision(circle:Mover , line:Line ):Number
	{
		// (theoretische) position des kreises zum zeitpunkt der kollison
		var collision:Point = getCircleLineIntersection(circle, line);
// 		if (isNaN(collision.x)) trace("timeToCircleLineCollision");
		// zeit bis zu diesem punkt
		var time:Number = circle.getTimeToPoint(collision);

		// senkrechte durch die linie
		var perpendicular:Line = line.getPerpendicular();
		// parallel verschieben, so dass sie durch den punkt geht
		perpendicular.moveToPoint(collision);
		// schnittpunkt
		var intersection:Point = getLineLineIntersection(line, perpendicular);

		// abbrechen, wenn nicht auf der strecke
		if (checkPointOnSegment(intersection, line) == false) time = 3000;

		// zurueck geben
		return(time);
	}

	static public function checkPointOnSegment(point:Point , line:Line ):Boolean
	{
		// endpunkte der strecke
		var ends:Object = line.getEnds();
		// testen, ob innerhalb der x- und y-grenzen
		if ((point.x >= ends["start"].x && point.x <= ends["end"].x)
		|| (point.x <= ends["start"].x && point.x >= ends["end"].x)
		|| (point.y >= ends["start"].y && point.y <= ends["end"].y)
		|| (point.y <= ends["start"].y && point.y >= ends["end"].y)) return (true);
		// ausserhalb
		return (false);
	}

	static public  function checkPointOnLine(point:Point , line:Line ):Boolean
	{
		// punkt liegt auf der geraden, wenn er die geradengleichung erfuellt (ohne rundung war z.b. 33.66666667 != 33.66666667 :-()
		return (Math.round(point.y) == Math.round(line.getSlope() * point.x + line.getIntercept()));
	}

	static public  function getLineLineAngle(line1:Line , line2:Line ):Number
	{
		// winkel der ersten linie
		var angle1:Number = Math.atan(line1.getSlope());
		// winkel der zweiten linie
		var angle2:Number = Math.atan(line2.getSlope());
		// differenz zurueck geben
		return (angle1 - angle2);
	}

	static public  function getPointPointDistance(point1:Point , point2:Point ):Number
	{
		// abstand zwischen den punkten in x-richtung
		var xdiff:Number = point1.x - point2.x;
		// abstand zwischen den punkten in y-richtung
		var ydiff:Number = point1.y - point2.y;

		// abstand zwischen den punkten
		var distance:Number = Math.sqrt(xdiff * xdiff + ydiff * ydiff);

		// zurueck geben
		return (distance);
	}
	
	static public  function getPointLineDistance(point:Point , line:Line ):Number
	{
		// senkrechte durch die linie
		var perpendicular:Line = line.getPerpendicular();
		// parallel verschieben, so dass sie durch den punkt geht
		perpendicular.moveToPoint(point);
		// schnittpunkt
		var intersection:Point = getLineLineIntersection(line, perpendicular);
		// abstand des punktes zum schnittpunkt
		var distance:Number = getPointPointDistance(point, intersection);
		
		// zurueck geben
		return (distance);
	}
	
	static public  function getPointLineRelation(point:Point , line:Line ):Number
	{
		// senkrechte durch die linie
		var perpendicular:Line = line.getPerpendicular();
		// parallel verschieben, so dass sie durch den punkt geht
		perpendicular.moveToPoint(point);
		// schnittpunkt
		var intersection:Point = getLineLineIntersection(line, perpendicular);
		// y-abstand
		var dy:Number = point.y - intersection.y;
// 		_root.cross1_mc._x = point.x;
// 		_root.cross1_mc._y = point.y;
// 		_root.cross2_mc._x = intersection.x;
// 		_root.cross2_mc._y = intersection.y;
		
		// zurueck geben
		return (dy < 0 ? -1 : 1);
	}
	
	static public  function getCircleCircleIntersection(circle1:Mover , circle2:Circle ):Point
	{
		// bewegungsrichtung des 1. kreises
		var trajectory:Line = circle1.getTrajectory();
		// radius des 1. kreises
		var r1:Number = circle1.getRadius();
		// steigung der bewegungsrichtung des 1. kreises
		var m:Number = trajectory.getSlope();
		// position des 2. kreises
		var position:Point = circle2.getPosition();
		// radius des 2. kreises
		var r2:Number = circle2.getRadius();
		
		// senkrechte zur bewegungsrichtung
		var perpendicular:Line = trajectory.getPerpendicular();
		// parallel verschieben, so dass sie durch den mittelpunkt des 2. kreises geht
		perpendicular.moveToPoint(position);
		// schnittpunkt der linien
		var lineintersec:Point = getLineLineIntersection(trajectory, perpendicular);
		// abstand des mittelpunkt des 2. kreises zum schnittpunkt
		var a:Number = getPointPointDistance(position, lineintersec);
		// abstand des schnittpunktes zum gesuchten punkt
		var b:Number = Math.sqrt((r1 + r2) * (r1 + r2) - a * a);
		// wurzel einer negativen zahl abfangen
		if (isNaN(b)) b = 0;
		// x-abstand zwischen schnittpunkt und gesuchtem punkt
		var dx:Number = b / Math.sqrt(m * m + 1);
		
		// (theoretische) position des 1. kreises zum zeitpunkt der kollison
		var collision1:Point = new Point(lineintersec.x + dx, trajectory.getY(lineintersec.x + dx));
		// abstand des 1. kreises bis zur position zum zeitpunkt der kollison
		var diff1:Number = getPointPointDistance(circle1.getNextPosition(1), collision1); // getPosition()
		// (theoretische) position des 1. kreises zum zeitpunkt der kollison
		var collision2:Point = new Point(lineintersec.x - dx, trajectory.getY(lineintersec.x - dx));
		// abstand des 1. kreises bis zur position zum zeitpunkt der kollison
		var diff2:Number = getPointPointDistance(circle1.getNextPosition(1), collision2); // getPosition()
		
		// naehere position zum zeitpunkt der kollison
		var collision:Point = (diff1 < diff2 ? collision1 : collision2);

		// zurueck geben
		return(collision);
	}
	
	static public  function getCircleCircleTangent(circle1:Mover , circle2:Circle ):Line
	{
		// mittelpunkt des 1. kreises zum zeitpunkt der kollision
		var collision:Point = getCircleCircleIntersection(circle1, circle2);
		// mittelpunkt des 2. kreises
		var position:Point = circle2.getPosition();
		// radius des 2. kreises
		var r2:Number = circle2.getRadius();
		// steigung der linie durch beide mittelpunkte
		var m:Number = (collision.y - position.y) / (collision.x - position.x);
		// neue verbindungslinie zwischen beiden mittelpunkten
		var connection:Line = new Line(0, m);
		// parallel verschieben, so dass sie durch beide mittelpunkte geht
		connection.moveToPoint(position);
		// gesucht wird schnittpunkt der kreislinie mit der verbindungslinie
		// x-abstand zwischen mittelpunkt und gesuchtem punkt
		var dx:Number =  r2 / Math.sqrt(m * m + 1);
		// 1. schnittpunkt
		var intersection1:Point = new Point(position.x + dx, connection.getY(position.x + dx));
		// abstand des 1. schnittpunkts bis zur position zum zeitpunkt der kollison
		var diff1:Number = getPointPointDistance(intersection1, collision);
		// 2. schnittpunkt
		var intersection2:Point = new Point(position.x - dx, connection.getY(position.x - dx));
		// abstand des 2. schnittpunkts bis zur position zum zeitpunkt der kollison
		var diff2:Number = getPointPointDistance(intersection2, collision);
		// naehere position zum zeitpunkt der kollison
		var intersection:Point = (diff1 < diff2 ? intersection1 : intersection2);
		
		// senkrechte dazu
		var tangent:Line = connection.getPerpendicular();
		// parallel verschieben, so dass sie durch den gesuchten schnittpunkt geht
		tangent.moveToPoint(intersection);
		// in strecke teilen
		tangent.segmentLine(position.x - r2, position.x + r2);
		// typ setzen
		tangent.setType("circle");
		
		// zurueck geben
		return(tangent);
	}

	static public  function checkCircleLineContact(circle:Mover , line:Line ):Boolean
	{
		// abbrechen, wenn keine linie uebergeben
		if (!(line instanceof Line)) {
			return (false);
		}
		// mittelpunkt des kreises
		var position:Point = circle.getNextPosition(1);
// 		trace(getPointLineDistance(position, line));
		// radius des kreises
		var radius:Number = circle.getRadius();
		// senkrechte durch die linie
		var perpendicular:Line = line.getPerpendicular();
		// parallel verschieben, so dass sie durch den punkt geht
		perpendicular.moveToPoint(position);
		// schnittpunkt
		var intersection:Point = getLineLineIntersection(line, perpendicular);
		// abstand des punktes zum schnittpunkt
		var distance:Number = getPointPointDistance(position, intersection);
		// kontakt besteht, wenn schnittpunkt auf strecke, abstand kleiner gleich radius
		var contact:Boolean = (checkPointOnSegment(intersection, line) && (distance / radius) < 1.01);
		// zurueck geben
		return (contact);
	}

	static public  function checkCircleInCircle(circle1:Mover , circle2:Circle ):Boolean
	{
		// abstand zwischen den kreisen
		var distance = getPointPointDistance(circle1.getNextPosition(1), circle2.getPosition());
		// testen, ob kleiner als summe der radien
		var inside = (distance < (circle1.getRadius() + circle2.getRadius()));
		// zurueck geben
		return (inside);
	}
	
	static public  function checkCircleObstacleCollision(circle:Mover , obstacle:Obstacle ):Boolean
	{
		// movieclip des kreises
		var mc:MovieClip = circle.getMovieclip();
		// hittest machen und ergebnis zurueck geben
		return (obstacle.hitTest(mc));
	}
	
	static public  function getCircleFlipperConnection(circle:Mover, flipper:Flipper, sign:Number):Line
	{
		// mittelpunkt des kreises
		var cpos:Point = circle.getNextPosition(1);
		// registrierpunkt des flippers
		var fpos:Point = new Point(flipper._x, flipper._y);
		// steigung der linie durch beide punkte
		var m:Number = (cpos.y - fpos.y) / (cpos.x - fpos.x) * sign;
		// neue verbindungslinie zwischen beiden punkten
		var connection:Line = new Line(0, m);
		// parallel verschieben, so dass sie durch beide punkte geht
		connection.moveToPoint(cpos);
		// in strecke teilen
		connection.segmentLine(cpos.x, fpos.x);
		// zurueck geben
		return (connection);
	}

} /* end class Detector */
