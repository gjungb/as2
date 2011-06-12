/**
 * @author gerd
 */
 
import com.adgamewonderland.duden.sudoku.game.beans.*;

interface com.adgamewonderland.duden.sudoku.game.interfaces.IGridListener {
	
	public function onGridChanged(field:Field ):Void;
	
	public function onGridFinished():Void;
}