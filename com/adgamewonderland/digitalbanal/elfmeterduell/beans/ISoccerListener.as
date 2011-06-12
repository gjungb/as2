/**
 * @author gerd
 */
 

interface com.adgamewonderland.digitalbanal.elfmeterduell.beans.ISoccerListener {
	
	public function onSoccerStarted(mode:Number ):Void;
	
	public function onSoccerStopped(mode:Number ):Void;
	
	public function onSetMove(count:Number, move:Number ):Void;
	
}