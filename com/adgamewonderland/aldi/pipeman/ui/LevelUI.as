/**
 * @author gerd
 */

import mx.utils.Delegate;

import com.adgamewonderland.aldi.pipeman.beans.Level;
import com.adgamewonderland.aldi.pipeman.beans.Pipeman;

class com.adgamewonderland.aldi.pipeman.ui.LevelUI extends MovieClip {
	
	private var nextlevel_btn:Button;
	
	public function LevelUI() {
		// registrieren
		Pipeman.getInstance().addListener(this);
	}
	
	public function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// button initialisieren
		nextlevel_btn.onRelease = Delegate.create(this, onPressNext);
	}
	
	public function onLevelStopped(nextlevel:Level ):Void
	{
		// einblenden
		_visible = true;
	}
	
	public function onPressNext():Void
	{
		// ausblenden
		_visible = false;
		// naechstes level
		Pipeman.getInstance().startLevel();
	}
}