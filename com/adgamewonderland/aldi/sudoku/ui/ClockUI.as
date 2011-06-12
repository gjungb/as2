/**
 * @author gerd
 */

import com.adgamewonderland.agw.interfaces.ITimeUI;
import com.adgamewonderland.agw.util.Timer;
import com.adgamewonderland.aldi.sudoku.ui.CounterUI;

class com.adgamewonderland.aldi.sudoku.ui.ClockUI extends MovieClip implements ITimeUI {
	
	private var c0_mc:CounterUI;
	
	private var c1_mc:CounterUI;
	
	private var c2_mc:CounterUI;
	
	private var c3_mc:CounterUI;
	
	private var c4_mc:CounterUI;
	
	private var c5_mc:CounterUI;
	
	public function ClockUI() {
		
	}
	
	public function showTime(tobj:Timer ):Void
	{
		// sekunden
		var seconds:Object = tobj.getSeconds();
		// vergangen
		var gone:Number = seconds["gone"];
		// formatieren
		var ftime:Array = Timer.getFormattedTime(gone, "").split("");
		// anzeigen
		for (var i:Number = 0; i < ftime.length; i++) {
			// aktueller counter
			var counter:CounterUI = this["c" + i + "_mc"];
			// anzeigen
			counter.showCount(Number(ftime[i]));
		}
	}
}