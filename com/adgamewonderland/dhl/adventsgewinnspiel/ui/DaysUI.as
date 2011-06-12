/**
 * @author gerd
 */
import com.adgamewonderland.dhl.adventsgewinnspiel.ui.CalendarUI;
import com.adgamewonderland.dhl.adventsgewinnspiel.ui.DayUI;
import com.adgamewonderland.dhl.adventsgewinnspiel.ui.PackageUI;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.DaysUI extends MovieClip {
	
	private var myCalendarUI:CalendarUI;
	
	private var myDays:Array;
	
	private var blind_mc:MovieClip;
	
	public function DaysUI() {
		myCalendarUI = CalendarUI(_parent);
		// tuerchen der einzelnen tage
		myDays = [];
	}
	
	public function onLoad():Void
	{
		// textfelder mit tageszahlen initialisieren
		initNumbers();
		
	}
	
	public function registerDay(mc:DayUI ):Number
	{
		// aktuelles datum
		var now:Date = myCalendarUI.getToday();
		// nur im dezember aktiv
		if (now.getMonth() != 11)
			return DayUI.STATE_FUTURE;
		// tag im dezember
		var today:Number = now.getDate();
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
		// packet einblenden
		var p:PackageUI = PackageUI(this["p" + mc.getDay() + "_mc"]);
		p.openPackage();
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
	
	private function initNumbers():Void
	{
		// aktuelles datum
		var now:Date = myCalendarUI.getToday();
		// nur im dezember aktiv
		if (now.getMonth() != 11)
			return;
		// tag im dezember
		var today:Number = now.getDate();
		// aktuelles textfeld
		var day_txt:TextField;
		// schleife ueber alle textfelder
		for (var i:String in this) {
			// aktuelles textfeld
			if (this[i] instanceof TextField) {
				// textfeld
				day_txt = this[i];
				// tag des textfelds
				var day:Number = Number(day_txt._name.substring(3, day_txt._name.indexOf("_")));
				// einfaerben
				if (day <= today) day_txt.textColor = 0x000000;
			}
		}
		
	}
	
}