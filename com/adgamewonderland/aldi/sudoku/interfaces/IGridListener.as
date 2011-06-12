/**
 * @author gerd
 */
 
import com.adgamewonderland.aldi.sudoku.beans.Field;

interface com.adgamewonderland.aldi.sudoku.interfaces.IGridListener {
	
	public function onGridChanged(field:Field ):Void;
	
	public function onGridFinished():Void;
}