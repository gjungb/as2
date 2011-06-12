import com.adgamewonderland.aldi.fischspiel.interfaces.IMovable;
import com.adgamewonderland.aldi.fischspiel.behaviours.MoveBehaviour;
import flash.geom.Point;
import flash.geom.Matrix;

class com.adgamewonderland.aldi.fischspiel.behaviours.MoveByRandom extends MoveBehaviour
{
	private static var MINSTEPS:Number = 200;

	private static var MAXSTEPS:Number = 400;

	private var minrange:Number = 200;

	private var maxrange:Number = 600;

	private var steps:Number = 300;

	private var remaining:Number;

	private var direction:Matrix;

	public function MoveByRandom(aMinrange:Number, aMaxrange:Number, aSteps:Number ) {
		// mindeststrecke
		if (aMinrange > 0)
			this.minrange = Math.min(aMinrange, this.maxrange);
		// maximalstrecke
		if (aMaxrange > 0)
			this.maxrange = Math.max(aMaxrange, this.minrange);
		// schritte bis zum erreichen des ziels
		if (aSteps > 0)
			this.steps = aSteps;
		// verbleibende schritte
		this.remaining = 0;
		// verschiebungsmatrix
		this.direction = new Matrix();
	}

	public function moveMe(aObj:IMovable ):Void
	{
		// testen, ob noch schritte uebrig
		if (this.remaining > 0) {
			// naechster schritt
			nextStep(aObj);
		} else {
			// neue bewegung
			initMove();
		}
	}

	private function nextStep(aObj:IMovable):Void
	{
		// runter zaehlen
		this.remaining --;
		// position des zu bewegenden objekts
		var pos:Point = aObj.getPosition().clone();
		// verschieben
		pos = this.direction.transformPoint(pos);
		// erlaubten bereich checken
		pos = correctBounds(pos);
		// position updaten
		aObj.updatePosition(pos);
	}

	private function initMove():Void
	{
		// schritte bis zum erreichen des ziels
		this.steps = Math.round(MINSTEPS + Math.random() * (MAXSTEPS - MINSTEPS));
		// x-richtung
		var xdir:Number = (Math.random() < 0.5 ? -1 : 1);
		// y-richtung
		var ydir:Number = (Math.random() < 0.5 ? -1 : 1);
		// gesamtverschiebung in x-richtung
		var xdiff:Number = xdir * (this.minrange + Math.random() * (this.maxrange - this.minrange));
		// gesamtverschiebung in y-richtung
		var ydiff:Number = ydir * (this.minrange + Math.random() * (this.maxrange - this.minrange));
		// x-verschiebung je schritt
		this.direction.tx = xdiff / this.steps;
		// y-verschiebung je schritt
		this.direction.ty = ydiff / this.steps;
		// verbleibende schritte
		this.remaining = this.steps;
	}

	public function toString() : String {
		return "com.adgamewonderland.aldi.fischspiel.behaviours.MoveByRandom";
	}

}
