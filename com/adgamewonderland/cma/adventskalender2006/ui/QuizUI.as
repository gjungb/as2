import com.adgamewonderland.cma.adventskalender2006.beans.*;

import mx.utils.Delegate;

/**
 * Darstellung des Quiz eines Tages auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.QuizUI extends MovieClip
{
	private static var INITFRAME:Number = 14;
	private var quiz:com.adgamewonderland.cma.adventskalender2006.beans.Quiz;
	private var question_mc:com.adgamewonderland.cma.adventskalender2006.ui.QuestionUI;
	private var recipe_mc:com.adgamewonderland.cma.adventskalender2006.ui.RecipeUI;
	private var link_mc:com.adgamewonderland.cma.adventskalender2006.ui.LinkUI;
	private var user_mc:com.adgamewonderland.cma.adventskalender2006.ui.UserUI;
	private var day_txt:TextField;
	private var close_btn:Button;
	private var again_btn:Button;
	private var next_btn:Button;

	public function QuizUI()
	{
	}

	/**
	 * Quiz anzeigen
	 * @param quiz Quiz eines Tages gekapselt in entsprechendem Bean
	 */
	public function showQuiz(quiz:com.adgamewonderland.cma.adventskalender2006.beans.Quiz):Void
	{
		// quiz speichern
		setQuiz(quiz);
		// nach maske nochmal initialisieren
		onEnterFrame = function() {
			// erster frame nach maske
			if (_currentframe == INITFRAME) {
				// initialisieren
				initQuiz();
				// nur einmal
				delete (onEnterFrame);
			}
		};
		// abspielen
		gotoAndPlay("frIn");
	}

	/**
	 * Anzeige des Quiz initialisieren
	 */
	public function initQuiz():Void
	{
		// anzeige kalendertag
		day_txt.autoSize = "center";
		day_txt.text = String(getQuiz().getDay().getDate().getDate());
		// schliessen button
		close_btn.onRelease = Delegate.create(this, closeQuiz);
	}

	/**
	 * Ergebnis der Aktion des Users anzeigen
	 * @param correct hat der User eine korrekte oder nicht korrekte Antwort gegeben
	 */
	public function showResult(correct:Boolean):Void
	{
		// antwort korrekt / falsch
		switch (correct) {
			// korrekt
			case true :
//				// tag abgelaufen / nicht abgelaufen
//				if (getQuiz().getDay().getDate().getDate() < Adventcalendar.getInstance().getToday().getDate()) {
//					// zur fehlermeldung
//					gotoAndStop("frResult2");
//					// weiter button
//					next_btn.onRelease = Delegate.create(this, closeQuiz);
//
//				} else {
					// zum formular
					gotoAndStop("frResult3");
//				}

				break;

			// falsch
			case false :
				// frage ausblenden
				question_mc._visible = false;
				// zur fehlermeldung
				gotoAndStop("frResult1");
				// zurueck button
				again_btn.onRelease = Delegate.create(this, showQuestion);

				break;
		}
	}

	/**
	 * Frage anzeigen
	 */
	public function showQuestion():Void
	{
		// zur frage
		gotoAndStop("frQuestion");
		// frage einblenden
		question_mc._visible = true;
	}

	/**
	 * Bestätigung nach Versenden der Daten anzeigen
	 */
	public function showConfirmation():Void
	{
		// zur bestaetigung
		gotoAndStop("frSent");
		// weiter button
		next_btn.onRelease = Delegate.create(this, closeQuiz);
	}

	/**
	 * Quiz beenden
	 */
	public function closeQuiz():Void
	{
		// abspielen
		gotoAndPlay("frClose");
		// quiz beenden
		Adventcalendar.getInstance().stopQuiz();
	}

	public function setQuiz(quiz:com.adgamewonderland.cma.adventskalender2006.beans.Quiz):Void
	{
		this.quiz = quiz;
	}

	public function getQuiz():com.adgamewonderland.cma.adventskalender2006.beans.Quiz
	{
		return this.quiz;
	}
}