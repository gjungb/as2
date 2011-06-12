/**
 * @author gerd
 */

import com.adgamewonderland.aldi.sudoku.ui.ContentcounterCounterUI;

class com.adgamewonderland.aldi.sudoku.ui.ContentcounterUI extends MovieClip {
	
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