/*
klasse:			Mover
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		06.03.2005
zuletzt bearbeitet:	09.03.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.baseclip.interfaces.Strokable;
import com.adgamewonderland.eplus.baseclip.interfaces.Movable;
import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.agw.math.Vector;
import com.adgamewonderland.eplus.baseclip.ui.StrokeUI;

class com.adgamewonderland.eplus.baseclip.util.Mover implements Strokable {

	private static var MOVER_TYPE_LINEAR:Number = 0;

	private static var MOVER_TYPE_SINE:Number = 1;

	private static var MOVER_TYPE_CIRCLE:Number = 2;

	private static var MOVER_TYPE_LIN_ACC:Number = 2;

	private static var MOVER_PARAMS_LINEAR:Object = {velocity : "com.adgamewonderland.collision.Vector", acceleration : "com.adgamewonderland.collision.Vector"};

	private static var MOVER_PARAMS_CIRCLE:Object = {direction : "Number"};

	private var myStroke:StrokeUI;

	private var myTarget:Movable;

	private var myType:Number;

	private var myPosition:Object;

	private var myParams:Object;

	private var myStepsMax:Number;

	private var myStepsAct:Number;

	public function Mover(target:Movable )
	{
		// taktgeber
		myStroke = _global.Stroke;
		// ziel, das bewegt werden soll
		myTarget = target;
		// art der bewegung
		myType = null;
		// position (start, ziel, aktuell)
		myPosition = {start : new Point(0, 0), end : new Point(0, 0), act : new Point(0, 0)};
		// berechnugsparameter (je nach art der bewegung)
		myParams = {};
		// gesamte anzahl schritte je bewegungszyklus
		myStepsMax = 0;
		// verbleibende anzahl schritte
		myStepsAct = 0;
	}

	public function startMove(type:Number, pstart:Point, pend:Point, time:Number, params:Object ):Number
	{
		// art der bewegung
		myType = type;
		// startposition
		myPosition.start = pstart;
		// zielposition
		myPosition.end = pend;
		// aktuelle position
		setPositionAct(pstart);
		// gesamte anzahl schritte je bewegungszyklus
		myStepsMax = Math.round(time / myStroke.fpsstroke);
		// aktuelle anzahl schritte
		myStepsAct = 0;
		// berechnugsparameter (je nach art der bewegung)
		myParams = params;
		// lineargeschwindigkeit
		myParams["velocity"] = new Vector((pend.x - pstart.x) / myStepsMax, (pend.y - pstart.y) / myStepsMax);
		// linearbeschleunigung (zunaechst 0)
		myParams["acceleration"] = new Vector(0, 0);

//		setStartLinear(pstart, pend, 50);

		// beim taktgeber anmelden
		myStroke.addListener(this);
		// anzahl schritte je bewegungszyklus zurueck geben
		return myStepsMax;
	}

	public function stopMove():Void
	{
		// beim taktgeber abmelden
		myStroke.removeListener(this);
		// ziel informieren, dass angekommen
		myTarget.onStopMove();
	}

	public function onUpdateStroke():Void
	{
		// schritte zaehlen
		if (++myStepsAct > myStepsMax) {
			// auf zielposition
			setPositionAct(myPosition.end);
			// bewegung stoppen
			stopMove();
			// abbrechen
			return;
		}
		// callback waehrend bewegung
		myTarget.onMove();
		// je nach art der bewegung
		switch (myType) {
			// linear
			case MOVER_TYPE_LINEAR :
				// aktuelle anzahl schritte
//				var steps:Number = myStepsAct;
				// aktuelle position
				var pact:Point = getPositionAct();
				// aktuelle geschwindigkeit
				var velo:Vector = myParams["velocity"];
				// aktuelle beschleunigung
				var acc:Vector = myParams["acceleration"];
				// beschleunigen
				velo = updateVelocity(velo, acc);
				// neue position berechnen
				var newpos:Point = getLinearPosition(pact, velo);
				// neue position speichern
				setPositionAct(newpos);

				break;
			// sinusfoermig
			case MOVER_TYPE_SINE :
				// aktuelle position
				var pact:Point = getPositionAct();
				// startposition
				var pstart:Point = myPosition.start;
				// zielposition
				var pend:Point = myPosition.end;
				// aktuelle geschwindigkeit
				var velo:Vector = myParams["velocity"];
				// exponent fuer sinus
				var exponent:Number = 1;
				// neue position berechnen
				var newpos:Point = getSinePosition(pact, pstart, pend, velo, exponent);
				// neue position speichern
				setPositionAct(newpos);

				break;
			// kreisfoermig
			case MOVER_TYPE_CIRCLE :
				// aktuelle anzahl schritte
				var steps:Number = myStepsAct;
				// aktuelle position
				var pact:Point = getPositionAct();
				// startposition
				var pstart:Point = myPosition.start;
				// zielposition
				var pend:Point = myPosition.end;
				// aktuelle geschwindigkeit
				var velo:Vector = myParams["velocity"];
				// richtung fuer kreisbahn
				var dir:Number = myParams["direction"];
				// neue position berechnen
				var newpos:Point = getCirclePosition(steps, pact, pstart, pend, velo, dir);
				// neue position speichern
				setPositionAct(newpos);

				break;
			// unbekannt
			default :
				trace("unbekannte bewegung");
				// bewegung stoppen
				stopMove();
		}
	}

	private function setPositionAct(pact:Point ):Void
	{
		// aktuelle position
		myPosition.act = pact;
		// target positionieren
		myTarget.setPosition(pact.x, pact.y);
	}

	private function getPositionAct():Point
	{
		// aktuelle position
		return myPosition.act;
	}

	private function getLinearPosition(pact:Point, velo:Vector ):Point
	{
		// neue position
		var nextpos:Point = new Point(pact.x + velo.xdiff, pact.y + velo.ydiff);
		// zurueck geben
		return (nextpos);
	}

	private function getSinePosition(pact:Point, pstart:Point, pend:Point, velo:Vector, exponent:Number ):Point
	{
		// neue position
		var nextpos:Point = getLinearPosition(pact, velo);
		// startposition auf x-achse
		var xmin:Number = pstart.x;
		// endposition auf yx-achse
		var xmax:Number = pend.x;
		// faktor in y-richtung
		var yfactor:Number = (pend.x - pstart.x) * 1;
		// winkelgrade in bogenmass
		var rad:Number = (nextpos.x - pstart.x) / (pend.x - pstart.x) * Math.PI;
		// funktionswert (y = sin (x ^ a))
		nextpos.y = pstart.y + Math.sin(Math.pow(rad, exponent)) * yfactor;
		// zurueck geben
		return (nextpos);
	}

	private function getCirclePosition(steps:Number, pact:Point, pstart:Point, pend:Point, velo:Vector, dir:Number ):Point
	{
		// HINT: hoehensatz des euklid
		// neue position
		var nextpos:Point = new Point(0, 0);
		// linker abschnitt auf x-achse
		var xa:Number = pact.x - pstart.x;
		// rechter abschnitt auf x-achse
		var xb:Number = pend.x - pact.x;
		// flaeche
		var area:Number = xa * xb;
		// gesuchte hoehe (h = sqrt(a * b))
		var height:Number = Math.round(Math.sqrt(area));
		// neue x-koordinate aus linearer verschiebung
		nextpos.x = pact.x + velo.xdiff;
		// neue y-koordinate aus linearer und kreis verschiebung
		nextpos.y = pstart.y + steps * velo.ydiff + dir * height;
		// zurueck geben
		return (nextpos);
	}

	// geschwindigkeit um beschleunigung aendern
	private function updateVelocity(velo:Vector, acc:Vector ):Vector
	{
		// geschwindigkeit aendern
		var xdiff:Number = velo.xdiff + acc.xdiff;
		var ydiff:Number = velo.ydiff + acc.ydiff;
		// kleine werte abfangen
		if (Math.abs(xdiff) <= 0.01) xdiff *= 1 / 100000;
		if (Math.abs(ydiff) <= 0.01) ydiff *= 1 / 100000;
		// neue geschwindigkeit speichern
		velo.setDiff(xdiff, ydiff);
		// zurueck geben
		return velo;
	}

	// durchschnitts- / anfangsgeschwindigkeit, linearbeschleunigung ausrechnen
	private function setStartLinear(pstart:Point, pend:Point, vmult:Number ):Void
	{
		// durchschnittliche lineargeschwindigkeit
		var vaverage:Vector = new Vector((pend.x - pstart.x) / myStepsMax, (pend.y - pstart.y) / myStepsMax);
		// anfangs lineargeschwindigkeit
		var vstart:Vector = new Vector(vaverage.xdiff, vaverage.ydiff);
		// multiplizieren, um am anfang / am ende abzubremsen
		if (vmult > -100 && vmult < 100) {
			// in x- / y-richtung prozentual veraendern
			vstart.setDiff(vstart.xdiff * (1 + vmult / 100), vstart.ydiff * (1 + vmult / 100));
		}
		// beschleunigung resutliert aus multiplikator, anzahl schritte und durchschnittliche lineargeschwindigkeit
		var ax:Number = -2 * vmult / (myStepsMax - 1) / 100 * vaverage.xdiff;
		var ay:Number = -2 * vmult / (myStepsMax - 1) / 100 * vaverage.ydiff;
		// linearbeschleunigung
		var astart:Vector = new Vector(ax, ay);

		// lineargeschwindigkeit
		myParams["velocity"] = vstart;
		// linearbeschleunigung
		myParams["acceleration"] = astart;
//		trace(myStepsMax);
//		trace(vstart.xdiff + " # " + astart.xdiff);
//		trace(vstart.ydiff + " # " + astart.ydiff);
	}
}