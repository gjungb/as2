/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventsgewinnspiel.ui.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.QuizUI extends MovieClip {

	private static var ATTEMPTS_MAX:Number = 3;

	private var myCalendarUI:CalendarUI;

	private var currentday:Number;

	private var attempts:Number;

	private var answers:Object;

	private var tasks_mc:TasksUI;

	private var close_btn:Button;

	public function QuizUI() {
		myCalendarUI = CalendarUI(_parent);
		// tag, dessen aufgabe angezeigt wird
		this.currentday = 0;
		// anzahl der versuche, die aufgabe zu loesen
		this.attempts = 0;
//		// antworten, die in tasks_mc angezeigt werden (assoziatives array)
//		this.answers = new Object();
	}

	public function showQuiz(day:Number ):Void
	{
		// tag, dessen aufgabe angezeigt wird
		setCurrentday(day);
		// anzahl der versuche, die aufgabe zu loesen
		setAttempts(0);
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// einblenden
		gotoAndPlay("frIn");
	}

	public function init():Void
	{
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.closeQuiz();
	 	};
	 	// trackpoint
	 	_root.getReportingProcessor().setTrackpoint(getCurrentday(), "day" + getCurrentday());
	}

//	public function registerAnswer(answer:AnswerUI ):Void
//	{
//		// antwort speichern
//		this.answers[answer._name] = answer;
//	}

	public function onSolveQuiz(answer:AnswerUI ):Void
	{
		// ergebnis je nach aktuellem tag und korrektheit der antwort
		var result:Number = 0;
		// aufgabe ausblenden
		tasks_mc.showTask(false);
		// anzahl der versuche, die aufgabe zu loesen
		setAttempts(getAttempts() + 1);

		// antwort nicht korrekt / korrekt
		switch (answer.getCorrect()) {
			// nicht korrekt
			case false :
				// noch versuche uebrig
				if (getAttempts() < ATTEMPTS_MAX) {
					result = 1;
				// kein versuch mehr uebrig
				} else {
					// aufgabe des aktuellen tages
					if (myCalendarUI.getToday().getDate() == getCurrentday()) {
						result = 2;
					// aufgabe eines vergangenen tages
					} else {
						result = 3;
					}
					// trackpoint
	  				_root.getReportingProcessor().setTrackpoint(48 + getCurrentday(), "lose" + getCurrentday());
				}

				break;

			// korrekt
			case true :
				// aufgabe des aktuellen tages
				if (myCalendarUI.getToday().getDate() == getCurrentday()) {
					result = 5;
				// aufgabe eines vergangenen tages
				} else {
					result = 4;
				}

				break;
		}
		// aufgabe des aktuellen tages
		if (result == 2) { //  || result == 5
			// speichern, dass heute gespielt
			myCalendarUI.finishGame();
		}
		// testen, ob zum gewinnformular
		if (result == 5) {
			// zum gewinnformular
			myCalendarUI.showWin();
			// hinspringen
			gotoAndPlay("frClose");

		} else {
			// ergebnis anzeigen
			gotoAndStop("frResult" + result);
		}
	}

	public function repeatQuiz():Void
	{
		// aufgabe einblenden
		tasks_mc.showTask(true);
		// hinspringen
		gotoAndStop("frTask");
	}

	public function closeQuiz():Void
	{
		// kalender einblenden
		myCalendarUI.showCalendar();
		// hinspringen
		gotoAndPlay("frClose");
	}

	public function getCurrentday():Number {
		return currentday;
	}

	public function setCurrentday(currentday:Number):Void {
		this.currentday = currentday;
	}

	public function getAnswers():Object {
		return answers;
	}

	public function getAttempts():Number {
		return attempts;
	}

	public function setAttempts(attempts:Number):Void {
		this.attempts = attempts;
	}

}