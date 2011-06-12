/**
 * @author gerd
 */
class com.adgamewonderland.dhl.adventsgewinnspiel.ui.ShutterUI extends MovieClip {

	public function ShutterUI() {
	}
	
	public function openShutter():Void {
		// abspielen
		gotoAndPlay("frIn");	
	}
	
	public function closeShutter():Void {
		// schliessen
		gotoAndStop(1);
	}
}