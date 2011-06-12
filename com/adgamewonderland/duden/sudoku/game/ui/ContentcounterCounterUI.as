/**
 * @author gerd
 */

import com.adgamewonderland.duden.sudoku.game.beans.Field;
import com.adgamewonderland.duden.sudoku.game.beans.Grid;
import com.adgamewonderland.duden.sudoku.game.interfaces.IGridListener;
import com.adgamewonderland.duden.sudoku.game.ui.CounterUI;

class com.adgamewonderland.duden.sudoku.game.ui.ContentcounterCounterUI extends MovieClip implements IGridListener {

	private var _id:Number;

	private var id_txt:TextField;

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
		// testen, ob fertig
		var finished:Boolean = Grid.getInstance().getContentcounter().getCount(_id) == 9;
		// wenn fertig, anzeigen
		if (finished) {
			// hintergrund anzeigen
			gotoAndStop("frOn");
			// loesungsbuchstaben anzeigen
			id_txt.autoSize = "center";
			id_txt.text = Grid.getInstance().getCharacter(_id);
		}
	}

	public function onGridFinished():Void
	{
	}

	public function getId():Number {
		return _id;
	}

}