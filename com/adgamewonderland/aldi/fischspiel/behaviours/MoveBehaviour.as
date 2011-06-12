import com.adgamewonderland.aldi.fischspiel.behaviours.IMoveBehaviour;
import com.adgamewonderland.aldi.fischspiel.interfaces.IMovable;

import flash.geom.Rectangle;
import flash.geom.Point;

class com.adgamewonderland.aldi.fischspiel.behaviours.MoveBehaviour implements IMoveBehaviour
{
	private var bounds:Rectangle;

	public function MoveBehaviour() {

	}

	public function setBounds(aBounds:Rectangle):Void
	{
		// grenzen der bewegung
		this.bounds = aBounds;
	}

	public function moveMe(aObj:IMovable):Void
	{
	}

	private function correctBounds(aPos:Point ):Point
	{
		// pruefen, ob ausserhalb des erlaubten rahmens
		if (this.bounds.containsPoint(aPos) == false) {
			// links raus
			if (aPos.x < this.bounds.x)
				aPos.x += this.bounds.width;
			// rechts raus
			if (aPos.x > this.bounds.right)
				aPos.x -= this.bounds.width;
			// oben raus
			if (aPos.y < this.bounds.y)
				aPos.y += this.bounds.height;
			// unten raus
			if (aPos.y > this.bounds.bottom)
				aPos.y -= this.bounds.height;
		}
		// zurueck geben
		return aPos;
	}
}
