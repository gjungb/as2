import flash.geom.Point;
import com.adgamewonderland.eplus.basecasting.interfaces.ITweenable;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.ITweenBehaviour {

	public function setRange(aStart:Point, aEnd:Point ):Void;

	public function setScale(aStart:Number, aEnd:Number ):Void;

	public function tweenMe(aObj:ITweenable, aDuration:Number, aFunc:Function ):Void;

}