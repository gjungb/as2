import com.adgamewonderland.aldi.fischspiel.behaviours.MoveBehaviour;
import com.adgamewonderland.aldi.fischspiel.interfaces.IMovable;

import flash.geom.Point;
import flash.geom.Matrix;

class com.adgamewonderland.aldi.fischspiel.behaviours.MoveByMouse extends MoveBehaviour
{

	private var elasticity:Number = 1;

	public function MoveByMouse(aElasticity:Number ) {
		// elastizitaet
		if (aElasticity > 0)
			this.elasticity = aElasticity;
	}

	public function moveMe(aObj:IMovable ):Void
	{
		// position des zu bewegenden objekts
		var pos:Point = aObj.getPosition().clone();
		// mausposition
		var mousepos:Point = new Point(_root._xmouse, _root._ymouse);
		// richtung
		var direction:Matrix = new Matrix();
		// abstand
		direction.translate((mousepos.x - pos.x) / this.elasticity, (mousepos.y - pos.y) / this.elasticity);
		// elastisch verschieben
		pos = direction.transformPoint(pos);
		// erlaubten bereich checken
		pos = correctBounds(pos);
		// position updaten
		aObj.updatePosition(pos);
	}

	public function toString() : String {
		return "com.adgamewonderland.aldi.fischspiel.behaviours.MoveByMouse";
	}
}
