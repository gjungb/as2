/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.DaysUI extends MovieClip {
	
	private var myCalendarUI:CalendarUI;
	
	private var myDays:Array;
	
	private var blind_mc:MovieClip;
	
	public function DaysUI() {
		myCalendarUI = CalendarUI(_parent);
		// tuerchen der einzelnen tage
		myDays = [];
		
		
	}
	
	public function registerDay(mc:DayUI ):Number
	{
		// tag im dezember
		var today:Number = myCalendarUI.getToday();
		// tag des tuerchens
		var day:Number = mc.getDay();
		// speichern
		myDays[day] = mc;
		// entsprechenden status zurueck geben
		if (day < today) {
			return DayUI.STATE_PAST;
		} else if (day == today) {
			return DayUI.STATE_PRESENT;
		} else {
			return DayUI.STATE_FUTURE;	
		}
	}
	
	public function selectDay(mc:DayUI ):Void
	{
		// spiel des gewaehlten tuerchens starten
		myCalendarUI.startGame(mc.getDay());
	}
	
	public function setDaysEnabled(bool:Boolean ):Void
	{
		// schleife ueber alle tuerchen
		for (var i:Number = 0; i < myDays.length; i++) {
			// de- / aktivieren
			myDays[i].setEnabled(bool);
		}	
	}
	
}