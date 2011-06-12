import com.adgamewonderland.aldi.fischspiel.interfaces.IMovable;
import flash.geom.Rectangle;

interface com.adgamewonderland.aldi.fischspiel.behaviours.IMoveBehaviour
{

	public function setBounds(aBounds:Rectangle):Void;

	public function moveMe(aObj:IMovable):Void;
}
