import mx.utils.Delegate;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.beans.Casting;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CitynavigationUI extends MovieClip implements ICityControllerListener {

	private var latest_mc:MovieClip;

	private var highscore_mc:MovieClip;

	private var schedule_mc:MovieClip;

	private var archive_mc:MovieClip;

	private var charity_mc:MovieClip;

	function CitynavigationUI() {
	}

	public function onLoad():Void
	{
		// als listener registrieren
		CityController.getInstance().addListener(this);
		// buttons
		latest_mc.onRelease = Delegate.create(this, doLatest);
		highscore_mc.onRelease = Delegate.create(this, doHighscore);
		schedule_mc.onRelease = Delegate.create(this, doSchedule);
		archive_mc.onRelease = Delegate.create(this, doArchive);
		charity_mc.onRelease = Delegate.create(this, doCharity);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		CityController.getInstance().removeListener(this);
	}

	public function onCityStateChanged(aState:String, aNewstate:String ):Void
	{
		// aktuelle stadt
		var city:CityImpl = CitiesController.getInstance().getCurrentcity();
		// pruefen, ob aktive castings vorhanden
		var active:Boolean = city.hasActiveCastings();
		// je nach state einen button over anzeigen
		setButtonState(latest_mc, active, aNewstate == CityController.STATE_LATEST);
		setButtonState(highscore_mc, active, aNewstate == CityController.STATE_HIGHSCORE);
		setButtonState(schedule_mc, true, aNewstate == CityController.STATE_SCHEDULE);
		setButtonState(archive_mc, active, aNewstate == CityController.STATE_ARCHIVE);
		setButtonState(charity_mc, true, aNewstate == CityController.STATE_CHARITY);
	}

	private function doLatest():Void
	{
		CityController.getInstance().changeState(CityController.STATE_LATEST);
	}

	private function doHighscore():Void
	{
		CityController.getInstance().changeState(CityController.STATE_HIGHSCORE);
	}

	private function doSchedule():Void
	{
		CityController.getInstance().changeState(CityController.STATE_SCHEDULE);
	}

	private function doArchive():Void
	{
		CityController.getInstance().changeState(CityController.STATE_ARCHIVE);
	}

	private function doCharity():Void
	{
		CityController.getInstance().changeState(CityController.STATE_CHARITY);
	}

	private function setButtonState(aButton:MovieClip, aActive:Boolean, aOver:Boolean ):Void
	{
		// hinspringen
		aButton.gotoAndStop(aOver ? "_over" : "_up");
		// ein- / ausblenden
		aButton._alpha = aActive ? 100 : 30;
		// de- / aktivieren
		aButton.enabled = aActive && !aOver;
	}

	public function onCastingSelected(aCasting : Casting) : Void {
	}

}