/**
 * @author gerd
 */
 
import com.adgamewonderland.aldi.sudoku.beans.Field;
import com.adgamewonderland.aldi.sudoku.beans.Grid;
import com.adgamewonderland.aldi.sudoku.interfaces.IGridListener;
import com.adgamewonderland.aldi.sudoku.ui.CounterUI;

class com.adgamewonderland.aldi.sudoku.ui.ContentcounterCounterUI extends MovieClip implements IGridListener {
	
	private var _id:Number;
	
	private var counter_mc:CounterUI;
	
	public function ContentcounterCounterUI() {
	}
	
	public function init():Void
	{
		// als listener registrieren
		Grid.getInstance().addListener(this);
		// nicht fertig
		gotoAndStop("frOff");
	}
	
	public function onGridChanged(field:Field ):Void
	{
		// anzeigen, ob fertig
		gotoAndStop(Grid.getInstance().getContentcounter().getCount(_id) == 9 ? "frOn" : "frOff");
	}
	
	public function onGridFinished():Void
	{
	}
	
	public function get_id():Number {
		return _id;
	}

}