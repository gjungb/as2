import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.ui.AntwortUI;

class com.adgamewonderland.eplus.base.tarifberater.ui.AntworticonUI extends AntwortUI {
	
	public function AntworticonUI() {
		super();
	}
	
	public function onLoad() : Void {
		// zu passendem icon
		this.gotoAndStop("fr" + ApplicationController.getInstance().getAutomat().getZustand().getId());
	}
}