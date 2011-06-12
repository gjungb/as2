/**
 * @author gerd
 */
interface com.adgamewonderland.ricola.sudoku.interfaces.IDraggable {
	
	public function onStartDrag(contentid:Number ):Void;
	
	public function onDoDrag():Void;
	
	public function onStopDrag():Void;
	
	public function getContentid():Number;
	
}