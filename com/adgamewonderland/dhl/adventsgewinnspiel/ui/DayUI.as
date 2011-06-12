/**
 * @author gerd
 */
import com.adgamewonderland.dhl.adventsgewinnspiel.ui.DaysUI;
import com.adgamewonderland.dhl.adventsgewinnspiel.ui.ShutterUI;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.DayUI extends MovieClip {
	
	public static var STATE_PAST:Number = -1;
	
	public static var STATE_PRESENT:Number = 0;
	
	public static var STATE_FUTURE:Number = 1;
	
	private var _myDay:Number;
	
	private var myDaysUI:DaysUI;
	
	private var myState:Number;
	
	private var shutter_mc : ShutterUI;

	private var number1_txt:TextField;
	
	private var number2_txt:TextField;
	
	private var day_btn:Button;
	
	public function DayUI() {
		myDaysUI = DaysUI(_parent);
		// registrieren und status setzen
		myState = myDaysUI.registerDay(this);
		// button initialisieren
		initButton();
		// button entsprechend de- / aktivieren
		if (myState == STATE_FUTURE) {
			// deaktivieren
			setEnabled(false);
			
		} else {
			// aktivieren
			setEnabled(true);
		}
	}
	
	public function onSelectDay():Void
	{
		// tuer oeffnen
		shutter_mc.openShutter();
	}

	public function onShutterOpen():Void
	{
		// spiel des tages anzeigen
		myDaysUI.selectDay(this);
	}
	
	public function getDay():Number
	{
		return _myDay;
	}
	
	public function setEnabled(bool:Boolean ):Void
	{
		// button de- / aktivieren
		day_btn.enabled = (bool && myState != STATE_FUTURE);
		// klappe schliessen
		if (bool)
			shutter_mc.closeShutter();
	}
	
	private function initButton():Void
	{
		// spiel des tages anzeigen
		day_btn.onRelease = function():Void {
			this._parent.onSelectDay();
		};
	}
	
	
}