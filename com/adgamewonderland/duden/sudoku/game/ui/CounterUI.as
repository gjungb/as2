/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.game.ui.CounterUI extends MovieClip {

	public function CounterUI() {
		// initialisieren
		showCount(_parent.get_id());
	}

	public function showCount(num:Number ):Void
	{
		// hinspringen
		gotoAndStop(num + 1);
	}
}