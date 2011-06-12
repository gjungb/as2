import mx.utils.Delegate;

import com.adgamewonderland.eplus.basecasting.controllers.TweenController;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.TweenControllerUI extends MovieClip {

	private var next_btn:Button;

	private var prev_btn:Button;

	function TweenControllerUI() {
	}

	public function onLoad():Void
	{
		// buttons
		next_btn.onRelease = Delegate.create(this, doNext);
		prev_btn.onRelease = Delegate.create(this, doPrev);
	}

	public function setActive(aActive:Boolean ):Void
	{
		// buttons de- / aktivieren
		next_btn.enabled = prev_btn.enabled = aActive;
	}

	private function doNext():Void
	{
		// nach rechts
		TweenController.getInstance().doTween(TweenController.DIRECTION_PREV);
	}

	private function doPrev():Void
	{
		// nach links
		TweenController.getInstance().doTween(TweenController.DIRECTION_NEXT);
	}

}