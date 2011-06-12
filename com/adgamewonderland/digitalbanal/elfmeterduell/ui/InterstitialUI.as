/**
 * @author gerd
 */

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.InterstitialUI extends MovieClip {
	
	public function InterstitialUI() {
		
	}
	
	public function onInterstitialFinished():Void
	{
		// parent informieren
		_parent.onInterstitialFinished();
	}
}