import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.eplus.basecasting.beans.Casting;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.controllers.CityController extends DefaultController {

	public static var STATE_HIDDEN:String = "hidden";

	public static var STATE_LATEST:String = "latest";

	public static var STATE_HIGHSCORE:String = "highscore";

	public static var STATE_SCHEDULE:String = "schedule";

	public static var STATE_ARCHIVE:String = "archive";

	public static var STATE_CHARITY:String = "charity";

	public static var STATE_DATES:String = "dates";

	private static var instance : CityController;

	private var state:String;

	private var casting:Casting;

	/**
	 * @return singleton instance of CityController
	 */
	public static function getInstance() : CityController {
		if (instance == null)
			instance = new CityController();
		return instance;
	}

	/**
	 * aendert den aktuellen state
	 * @param state neuer state (s. STATE_)
	 */
	public function changeState(aState:String ):Void
	{
//		// abbrechen, wenn state nicht geaendert
//		if (aState == getState())
//			return;
		// bisheriger state
		var oldstate:String = getState();
		// neuer state
		setState(aState);
		// listener informieren
		_event.send("onCityStateChanged", oldstate, getState());
	}

	/**
	 * waehlt ein casting aus
	 * @param aCasting ausgewaehltes casting
	 */
	public function selectCasting(aCasting:Casting ):Void
	{
		// je nach aktuellem state
		switch (this.state) {
			// archiv
			case STATE_ARCHIVE :
				// aktuelles casting (nur fuer archiv)
				this.casting = aCasting;

				break;

			// alle anderen
			default :
				// kein aktuelles casting
				this.casting = null;
				// die neusten clips anzeigen
				changeState(CityController.STATE_LATEST);
		}
		// listener informieren
		_event.send("onCastingSelected", this.casting);
	}

	public function getSelectedCasting():Casting
	{
		// aktuelles casting
		var selected:Casting = this.casting;
		// resetten
		this.casting = null;
		// zurueck geben
		return selected;
	}

	public function setState(aState:String ):Void
	{
		this.state = aState;
	}

	public function getState():String
	{
		return this.state;
	}

	private function CityController() {
		super();
		// aktuller state
		this.state = STATE_LATEST;
		// aktuelles casting (nur fuer archiv)
		this.casting = null;
	}

}