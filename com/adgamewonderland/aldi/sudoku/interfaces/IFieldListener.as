/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.sudoku.beans.ContainerImpl;
import com.adgamewonderland.aldi.sudoku.beans.Content;
import com.adgamewonderland.aldi.sudoku.beans.Field;

interface com.adgamewonderland.aldi.sudoku.interfaces.IFieldListener {
	
	public function onContentChanged(field:Field, oldcontent:Content ):Void;
	
	public function onGuessChanged(field:Field, guess:Content, added:Boolean ):Void;
	
	public function onContainerFinished(container:ContainerImpl ):Void;
}