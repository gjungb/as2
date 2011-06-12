import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CharityUI extends MovieClip {

	function CharityUI() {
	}

	public function onLoad():Void
	{
		// aktuelle stadt
		var city:CityImpl = CitiesController.getInstance().getCurrentcity();
		// zum text springen
		gotoAndStop(city.getID() + 1);
	}

}