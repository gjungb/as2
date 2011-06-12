/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.DayUI extends MovieClip {
	
	public static var STATE_PAST:Number = -1;
	
	public static var STATE_PRESENT:Number = 0;
	
	public static var STATE_FUTURE:Number = 1;
	
	private var _myDay:Number;
	
	private var myDaysUI:DaysUI;
	
	private var myState:Number;
	
	private var number1_txt:TextField;
	
	private var number2_txt:TextField;
	
	private var day_btn:Button;
	
	public function DayUI() {
		myDaysUI = DaysUI(_parent);
		// registrieren und status setzen
		myState = myDaysUI.registerDay(this);
		// entsprechend anzeigen
		if (myState == STATE_FUTURE) {
			gotoAndStop("frFuture");
			number1_txt.autoSize = number2_txt.autoSize = "center";
			number1_txt.text = number2_txt.text = String(getDay());
		} else if (myState == STATE_PRESENT) {
			gotoAndStop("frPresent");
			initButton();
		} else if (myState == STATE_PAST) {
			gotoAndStop("frPast");
			initButton();
		}
	}
	
	public function onSelectDay():Void
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
		day_btn.enabled = bool;	
	}
	
	private function initButton():Void
	{
		// spiel des tages anzeigen
		day_btn.onRelease = function():Void {
			this._parent.onSelectDay();
		};
	}
	
	
}