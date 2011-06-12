import flash.geom.Point;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.ITweenable {

	public function getPosition():Point;

	public function getScale():Number;

	public function onTweenStarted():Void;

	public function onTweening():Void;

	public function onTweenFinished():Void;

}