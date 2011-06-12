/**
 * @author gerd
 */

import com.adgamewonderland.aldi.pipeman.beans.Grid;

class com.adgamewonderland.aldi.pipeman.ui.LiquidUI extends MovieClip {
	
	public function LiquidUI() {
		
	}
	
	public function onLoad() {
		// registrieren
		Grid.getInstance().addListener(this);
	}
	
	public function onFlowStarted():Void
	{
		// TODO: animation

//		Grid.getInstance().updateFlow();
	}
}