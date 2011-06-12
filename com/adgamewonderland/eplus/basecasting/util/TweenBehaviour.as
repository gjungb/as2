import mx.transitions.Tween;

import com.adgamewonderland.eplus.basecasting.interfaces.ITweenable;
import com.adgamewonderland.eplus.basecasting.interfaces.ITweenBehaviour;

import flash.geom.Point;
import mx.utils.Delegate;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.util.TweenBehaviour implements ITweenBehaviour {

	private var startpos:Point;

	private var endpos:Point;

	private var startscale:Number;

	private var endscale:Number;

	public function setRange(aStart:Point, aEnd:Point):Void
	{
		this.startpos = aStart;
		this.endpos = aEnd;
	}

	public function setScale(aStart:Number, aEnd:Number):Void
	{
		this.startscale = aStart;
		this.endscale = aEnd;
	}

	public function tweenMe(aObj:ITweenable, aDuration:Number, aFunc:Function ):Void
	{
		// tween fur x-position
		var t1:Tween = new Tween(aObj, "_x", aFunc, this.startpos.x, this.endpos.x, aDuration, true);
		// tween fur y-position
		var t2:Tween = new Tween(aObj, "_y", aFunc, this.startpos.y, this.endpos.y, aDuration, true);
		// tween fur x-skalierung
		var t3:Tween = new Tween(aObj, "_xscale", aFunc, this.startscale, this.endscale, aDuration, true);
		// tween fur y-skalierung
		var t4:Tween = new Tween(aObj, "_yscale", aFunc, this.startscale, this.endscale, aDuration, true);
		// start melden
		aObj.onTweenStarted();
		// callback am ende
		t1.onMotionFinished = function():Void {
			aObj.onTweenFinished();
		};
	}

}