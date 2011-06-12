import mx.utils.Delegate;

import com.adgamewonderland.eplus.base.tarifberater.ui.AntwortUI;

class com.adgamewonderland.eplus.base.tarifberater.ui.AntwortBASEUI extends AntwortUI {
	
	private var box_mc : MovieClip;

	public function AntwortBASEUI() {
		this.onEnterFrame = doFollow;
	}
	
	private function doFollow() : Void {
		if (_currentframe == _totalframes) {
			super.onLoad();
			// box als button
			box_mc.onRelease = Delegate.create(this, onAuswaehlen);
			delete(onEnterFrame);
		}
	}
}