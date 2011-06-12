import mx.utils.Delegate;

import com.adgamewonderland.duden.sudoku.challenge.ui.GameUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.InputUI;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.ImprintUI extends InputUI {

	private var close_btn:Button;

	public function ImprintUI() {

	}

	public function onLoad():Void
	{
		// button schliessen
		close_btn.onRelease = Delegate.create(this, onClose);
	}

	public function onClose():Void
	{
		// imprint schliessen
		GameUI.getMovieClip().hideImprint();
	}

}