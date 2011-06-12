import com.adgamewonderland.cma.adventskalender2006.beans.*;
import com.adgamewonderland.cma.adventskalender2006.ui.*;
import com.adgamewonderland.cma.adventskalender2006.util.*;

/**
 * Darstellung des Adventskalenders auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.AdventcalendarUI extends MovieClip implements ICalendarListener
{
	private var days:Array;
	private var quiz_mc:QuizUI;
	private var loader_mc:MovieClip;

	public function AdventcalendarUI()
	{
		// movieclips der einzelnen kalendertage
		this.days = new Array();
		// als listener beim calendar registrieren
		Adventcalendar.getInstance().addListener(this);
		// loader ausblenden
		loader_mc._visible = false;
	}

	/**
	 * registriert das MovieClip eines Tages beim Adventskalender
	 * @param mc MovieClip eines Tages
	 */
	public function registerDay(mc:com.adgamewonderland.cma.adventskalender2006.ui.DayUI):Void
	{
		// movieclip speichern
		addDays(mc);
	}

	/**
	 * Callback nach Klick auf einen Tag
	 * @param mc MovieClip des akgeklickten Tages
	 */
	public function onSelectDay(mc:com.adgamewonderland.cma.adventskalender2006.ui.DayUI):Void
	{
		// alle tage deaktivieren
		setDaysEnabled(false);
		// loader einblenden
		loader_mc._visible = true;
		// quiz aufrufen lassen
		Adventcalendar.getInstance().startQuiz(mc.getDay());
	}

	/**
	 * Callback nach Starten des Quiz eines Tages
	 * @param quiz Quiz eines Tages
	 */
	public function onStartQuiz(quiz:Quiz):Void
	{
		// loader ausblenden
		loader_mc._visible = false;
		// quiz starten
		quiz_mc.showQuiz(quiz);
	}

	/**
	 * Callback nach Beantworten einer Frage
	 * @param answer Eingaben des Users gekapselt in entsprechendem Bean
	 */
	public function onAnswerQuestion(answer:Answer):Void
	{
		// ergebnis anzeigen
		quiz_mc.showResult(answer.isAntwort_ok());
	}

	/**
	 * Callback nach beenden des Quiz eines Tages
	 */
	public function onStopQuiz():Void
	{
		// alle tage aktivieren
		setDaysEnabled(true);
	}

	public function addDays(days:com.adgamewonderland.cma.adventskalender2006.ui.DayUI):Void
	{
		this.days.push(days);
	}

	public function removeDays(days:com.adgamewonderland.cma.adventskalender2006.ui.DayUI):Void
	{
		for (var i:Number = 0; i < this.days.length; i++)
		{
			if (this.days[i] == days)
			{
				this.days.splice(i, 1);
			}
		}
	}

	public function toDaysArray():Array
	{
		return this.days;
	}

	/**
	 * aktiviert / deaktiviert die Klickbarkeit der auf der Bühnen angezeigten Tage
	 * @param bool sollen die Tage aktiviert oder deaktiviert werden
	 */
	private function setDaysEnabled(bool:Boolean):Void
	{
		// schleife ueber alle tage
		for (var i:String in this.days) {
			// aktueller tag
			var day:DayUI = this.days[i];
			// de- / aktivieren
			day.enabled = (bool && day.getDay().getDate().getDate() <= Adventcalendar.getInstance().getToday().getDate() && Adventcalendar.getInstance().getToday().getMonth() == 11);
		}

	}
}