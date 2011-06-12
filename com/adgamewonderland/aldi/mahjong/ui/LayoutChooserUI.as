/**
 * @author gerd
 */
 
import com.adgamewonderland.aldi.mahjong.ui.GameUI;
 
class com.adgamewonderland.aldi.mahjong.ui.LayoutChooserUI extends MovieClip {
	
	private var layouts_mc:MovieClip;
	
	private var prev_btn:Button;
	
	private var next_btn:Button;
	
	private var game_mc:GameUI;
	
	public function LayoutChooserUI() {
		// buttons
		prev_btn.onRelease = function() {
			this._parent.changeLayout(-1);
		};
		next_btn.onRelease = function() {
			this._parent.changeLayout(1);
		};
		// spiel
		game_mc = _root.game_mc;
		// wechseln
		layouts_mc.gotoAndStop(game_mc.getLayoutid());
	}
	
	public function changeLayout(dir:Number ):Void
	{
		// layout
		var layout:Number = layouts_mc._currentframe;
		// je nach richtung wechseln
		switch (dir > 0) {
			case true :
				if (++layout > layouts_mc._totalframes) layout = 1;
				break;
			case false :
				if (--layout < 1) layout = layouts_mc._totalframes;
				break;
		}
		// anzeigen
		layouts_mc.gotoAndStop(layout);
		// wechseln
		game_mc.setLayoutid(layout);
	}
}