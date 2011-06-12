/**
 * @author gerd
 */

import com.adgamewonderland.duden.sudoku.game.ui.ContentcounterCounterUI;

class com.adgamewonderland.duden.sudoku.game.ui.ContentcounterUI extends MovieClip {

	public function ContentcounterUI() {

	}

	public function init():Void
	{
		// zaehler
		var i:Number = 0;
		// schleife ueber alle counter
		while (this["counter" + (++i) + "_mc"] != undefined) {
			// aktueller counter
			var counter:ContentcounterCounterUI = ContentcounterCounterUI(this["counter" + i + "_mc"]);
			// initialisieren
			counter.init();
		}
	}
}