import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.LayerUI;
import com.adgamewonderland.eplus.basecasting.beans.Casting;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.ScheduleaniUI extends LayerUI implements ICityControllerListener {

	function ScheduleaniUI() {
		super();
	}

	public function onLoad():Void
	{
		super.onLoad();
		// als listener registrieren
		CityController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		super.onUnload();
		// als listener deregistrieren
		CityController.getInstance().removeListener(this);
	}

	public function hideLayer():Void
	{
		super.hideLayer();
		// aktuelle stadt
		var city:CityImpl = CitiesController.getInstance().getCurrentcity();
		// castimgtermine anzeigen
		CityController.getInstance().changeState(CityController.STATE_DATES);
//		// pruefen, ob schon castings existieren
//		if (city.hasActiveCastings() == false)
//			CityController.getInstance().changeState(CityController.STATE_DATES);
//		else
//			CityController.getInstance().changeState(CityController.STATE_LATEST);
	}

	public function onCityStateChanged(aState:String, aNewstate:String ):Void
	{
		// einblenden, wenn termin
		if (aNewstate == CityController.STATE_SCHEDULE)
			showLayer();
	}

	public function onCastingSelected(aCasting : Casting) : Void {
	}

}