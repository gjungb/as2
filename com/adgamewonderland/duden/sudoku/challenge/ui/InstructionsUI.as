import mx.utils.Delegate;

import com.adgamewonderland.duden.sudoku.challenge.ui.GameUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.InputUI;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.InstructionsUI extends InputUI {

	private var close_btn:Button;

	public function InstructionsUI() {

	}

	public function onLoad():Void
	{
		// button schliessen
		close_btn.onRelease = Delegate.create(this, onClose);
	}

	public function onClose():Void
	{
		// instruction schliessen
		GameUI.getMovieClip().hideInstructions();
	}

}