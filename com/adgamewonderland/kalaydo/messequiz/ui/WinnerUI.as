import com.adgamewonderland.kalaydo.messequiz.controllers.QuizController;
/**
 * @author gerd
 */
class com.adgamewonderland.kalaydo.messequiz.ui.WinnerUI extends MovieClip {

	function WinnerUI() {
	}

	public function onLoad():Void
	{
		// gewinner
		var winner:Number = QuizController.getInstance().getWinner();
		// hinspringen
		gotoAndStop(winner + 1);
	}

}