import flash.geom.Point;

import com.adgamewonderland.eplus.basecasting.interfaces.ITweenable;

class com.adgamewonderland.eplus.base.tarifberater.ui.RahmenUI extends MovieClip implements ITweenable {

	public function getPosition() : Point {
		return new Point(_x, _y);
	}
	
	public function getScale() : Number {
		return _yscale;
	}

	public function onTweenStarted() : Void {
	}
	
	public function onTweening() : Void {
	}
	
	public function onTweenFinished() : Void {
	}
}