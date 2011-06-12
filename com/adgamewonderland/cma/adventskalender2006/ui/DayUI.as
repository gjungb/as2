import com.adgamewonderland.cma.adventskalender2006.beans.*;
import com.adgamewonderland.cma.adventskalender2006.ui.*;

/**
 * Darstellung eine Tages auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.DayUI extends MovieClip
{
	private static var COLOR_ENABLED:Number = 0x999999;
	private static var COLOR_DISABLED:Number = 0x000000;
	private static var ALPHA_UP:Number = 100;
	private static var ALPHA_OVER:Number = 50;
	private var _id:Number;
	private var calendar_mc:AdventcalendarUI;
	private var day:Day;
	private var id_txt:TextField;
	private var outline1_txt:TextField;
	private var outline2_txt:TextField;
	private var outline3_txt:TextField;
	private var outline4_txt:TextField;
	private var outline5_txt:TextField;
	private var outline6_txt:TextField;
	private var outline7_txt:TextField;
	private var outline8_txt:TextField;
	private var hitarea_mc:MovieClip;

	public function DayUI()
	{
		// referenz auf kalender
		this.calendar_mc = AdventcalendarUI(_parent);
		// anzuzeigender tag
		this.day = Adventcalendar.getInstance().getDayById(_id);
		// tageszahl anzeigen
		id_txt.text = getDay().getDate().getDate().toString();
		// outlines anzeigen
		for (var i:Number = 1; i <= 8; i++) {
			// aktuelle outline
			this["outline" + i + "_txt"].text = id_txt.text;
		}
		// hitarea
		this.hitArea = hitarea_mc;

		// tag im dezember
		var today:Date = Adventcalendar.getInstance().getToday();
		// testen, ob aktiv
		if (getDay().getDate().getDate() <= today.getDate() && today.getMonth() == 11) {
			// tageszahl einfaerben
			id_txt.textColor = COLOR_ENABLED;

		} else {
			// deaktivieren
			this.enabled = false;
			// tageszahl einfaerben
			id_txt.textColor = COLOR_DISABLED;
		}
	}

	public function onLoad():Void
	{
		// registrieren
		calendar_mc.registerDay(this);
	}

	public function onRollOver():Void
	{
		// tageszahl faden
		id_txt._alpha = ALPHA_OVER;
	}

	public function onRollOut():Void
	{
		// tageszahl faden
		id_txt._alpha = ALPHA_UP;
	}

	public function onRelease():Void
	{
		// callback
		calendar_mc.onSelectDay(this);
	}

	public function setCalendar_mc(calendar_mc:com.adgamewonderland.cma.adventskalender2006.ui.AdventcalendarUI):Void
	{
		this.calendar_mc = calendar_mc;
	}

	public function getCalendar_mc():com.adgamewonderland.cma.adventskalender2006.ui.AdventcalendarUI
	{
		return this.calendar_mc;
	}

	public function setDay(day:com.adgamewonderland.cma.adventskalender2006.beans.Day):Void
	{
		this.day = day;
	}

	public function getDay():com.adgamewonderland.cma.adventskalender2006.beans.Day
	{
		return this.day;
	}
}