/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.ecard.ui.*;

class com.adgamewonderland.aldi.ecard.ui.ToolbarSentUI extends MovieClip {
	
	private var myToolbarUI:ToolbarUI;
	
	private var compose_btn:Button;
	
	public function ToolbarSentUI() {
		myToolbarUI = ToolbarUI(_parent);
		// neue ecard verfassen
		compose_btn.onRelease = function() {
			this._parent.onCompose();
		}
	}
	
	public function onCompose():Void
	{
		// neue ecard
		_global.EcardUI.initEcard(null, null);
	}
}