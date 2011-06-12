/**
 * @author gerd
 */
 
import com.adgamewonderland.aldi.sudoku.beans.Content;
import com.adgamewonderland.aldi.sudoku.beans.Field;
import com.adgamewonderland.aldi.sudoku.beans.Grid;
import com.adgamewonderland.aldi.sudoku.interfaces.IGridListener;

class com.adgamewonderland.aldi.sudoku.ui.JokerUI extends MovieClip implements IGridListener {
	
	private static var JOKERS:Number = 4;
	
	private var numjokers:Number;
	
	public function JokerUI() {
	}
	
	public function init():Void
	{
		// anzahl joker
		setNumjokers(JOKERS);
		// anzeigen
		showJokers();
		// als listener registrieren
		Grid.getInstance().addListener(this);
	}
	
	public function onGridChanged(field:Field ):Void
	{
		// testen, ob fehler
		if (field.getContent().getId() != Content.CONTENT_EMPTY && !field.getSolved()) {
			// testen, ob noch joker uebrig
			if (getNumjokers() > 0) {
				// runter zeahlen
				setNumjokers(getNumjokers() - 1);
				// anzeigen
				showJokers();
			} else {
				// zeitstrafe
				_parent.onError();
			}
		}
	}
	
	public function onGridFinished():Void
	{
	}
	
	public function getNumjokers():Number {
		return numjokers;
	}

	public function setNumjokers(numjokers:Number):Void {
		this.numjokers = numjokers;
	}
	
	private function showJokers():Void
	{
		// zaehler
		var i:Number = 0;
		// schleife ueber alle jokers
		while (this["joker" +  (++i) + "_mc"] != undefined) {
			// ein- ausblenden
			this["joker" +  i + "_mc"]._visible = (i <= getNumjokers());
		}
	}

}