import mx.transitions.easing.None;

import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.eplus.basecasting.interfaces.ITweenable;
import com.adgamewonderland.eplus.basecasting.interfaces.ITweenBehaviour;
import com.adgamewonderland.eplus.basecasting.util.TweenBehaviour;

import flash.geom.Point;
import mx.transitions.easing.Bounce;
import mx.transitions.easing.Elastic;
import mx.transitions.easing.Regular;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.controllers.TweenController extends DefaultController {

	public static var DIRECTION_NEXT:Number = 1;

	public static var DIRECTION_PREV:Number = -1;

	private static var DURATION:Number = 0.75;

	private static var FUNCTION:Function = Regular.easeOut;

	private static var instance : TweenController;

	private var tweenables:Array;

	/**
	 * @return singleton instance of TweenController
	 */
	public static function getInstance() : TweenController {
		if (instance == null)
			instance = new TweenController();
		return instance;
	}

	private function TweenController() {
		// tweenbare objekte
		this.tweenables = new Array();
	}

	public function addTweenable(aObj:ITweenable ):Void
	{
		// zur liste der tweenbaren objekte
		this.tweenables.push(aObj);
	}

	public function doTween(aDirection:Number ):Void
	{
		// tweenbare objekte nach x-position sortieren
		this.tweenables.sort(sortOnXpos);
		// aktuelles tweenbares objekt
		var tweenable:ITweenable;
		// benachbartes tweenbares objekt (ziel)
		var target:ITweenable;
		// tween verhalten
		var behaviour:ITweenBehaviour;
		// startposition
		var starpos:Point;
		// zielposition
		var endpos:Point;
		// startskalierung
		var startscale:Number;
		// zielskalierung
		var endscale:Number;
		// schleife ueber tweenbare objekte
		for (var i : Number = 0; i < this.tweenables.length; i++) {
			// aktuelles tweenbares objekt
			tweenable = ITweenable(this.tweenables[i]);
			// benachbartes tweenbares objekt (ziel)
			if (aDirection == DIRECTION_NEXT) {
				// rechts
				target = this.tweenables[i == this.tweenables.length - 1 ? 0 : i + 1];

			} else if (aDirection == DIRECTION_PREV) {
				// links
				target = this.tweenables[i > 0 ? i - 1 : this.tweenables.length - 1];

			} else {
				// unbekannt
				break;
			}
			// tween verhalten
			behaviour = new TweenBehaviour();
			// startposition
			starpos = tweenable.getPosition();
			// zielposition
			endpos = target.getPosition();
			// startskalierung
			startscale = tweenable.getScale();
			// zielskalierung
			endscale = target.getScale();
			// start- und zielposition
			behaviour.setRange(starpos, endpos);
			// start- und zielskalierung
			behaviour.setScale(startscale, endscale);
			// tweenen
			behaviour.tweenMe(tweenable, DURATION, FUNCTION);
		}
	}

	public function updateDepth(aObj:ITweenable ):Void
	{
		// tweenbare objekte nach skalierung sortieren
		this.tweenables.sort(sortOnScale);
		// aktuelles tweenbares objekt
		var tweenable:MovieClip;
		// schleife ueber tweenbare objekte
		for (var i : Number = 0; i < this.tweenables.length; i++) {
			// aktuelles tweenbares objekt
			tweenable = this.tweenables[i];
			// depth setzen
			tweenable.swapDepths(i + 1);
		}
	}

	private function sortOnXpos(t1:ITweenable, t2:ITweenable ):Number
	{
		if (t1.getPosition().x < t2.getPosition().x) {
			return -1;
		} else if (t1.getPosition().x > t2.getPosition().x) {
			return 1;
		} else {
			return 0;
		}
	}

	private function sortOnScale(t1:ITweenable, t2:ITweenable ):Number
	{
		if (t1.getScale() < t2.getScale()) {
			return -1;
		} else if (t1.getScale() > t2.getScale()) {
			return 1;
		} else {
			return 0;
		}
	}

}