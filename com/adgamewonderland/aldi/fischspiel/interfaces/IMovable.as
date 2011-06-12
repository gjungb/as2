import flash.geom.Point;
import flash.geom.Matrix;

interface com.adgamewonderland.aldi.fischspiel.interfaces.IMovable
{

	public function updatePosition(aPos:Point):Void;

	public function getPosition():Point;

	public function getDirection():Matrix;
}
