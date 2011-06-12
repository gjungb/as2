
/** * @author gerd */import flash.geom.Point;
import flash.geom.Rectangle;

interface com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable {

	public function getPosition() : Point;

	public function getSize() : Rectangle;
	
	public function getName() : String;
}