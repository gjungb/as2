import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.CityheadlineUI;
import com.adgamewonderland.eplus.basecasting.beans.Casting;
import com.adgamewonderland.eplus.basecasting.util.Tracking;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CityUI extends MovieClip implements IApplicationControllerListener, ICityControllerListener {

	private var headline_mc:CityheadlineUI;

	function CityUI() {
		// ausblenden
		_visible = false;
	}

	public function onLoad():Void
	{
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);
		// als listener registrieren
		CityController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);
		// als listener deregistrieren
		CityController.getInstance().removeListener(this);
	}

	public function onStateChanged(aState:String, aNewstate:String ):Void
	{
		// je nach neuem state
		switch (aNewstate) {
			// startseite
			case ApplicationController.STATE_START :
				// ausblenden
				_visible = false;
				// controller resetten
				CityController.getInstance().changeState(CityController.STATE_HIDDEN);

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// einblenden
				_visible = true;
				// castingtermine anzeigen
				CityController.getInstance().changeState(CityController.STATE_DATES);
				// tracking
				var city:CityImpl = CitiesController.getInstance().getCurrentcity();
				// aufrufen
				Tracking.getInstance().doTrack(city.getName(), city.getName(), "");

				break;
		}
	}

	public function onStateChangeInited(aState:String, aNewstate:String ):Void
	{
	}

	public function onCityStateChanged(aState:String, aNewstate:String ):Void
	{
//		trace(aState + " # " + aNewstate);
	}

	public function onCastingSelected(aCasting : Casting) : Void {
	}

}