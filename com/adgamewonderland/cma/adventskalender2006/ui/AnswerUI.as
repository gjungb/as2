import com.adgamewonderland.cma.adventskalender2006.beans.*;
import com.adgamewonderland.cma.adventskalender2006.util.*;

/**
 * Darstellung einer Antwort auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.AnswerUI extends MovieClip
{
	private var answer:com.adgamewonderland.cma.adventskalender2006.beans.Answer;
	private var answer_txt:TextField;
	private var character_txt:TextField;
	private var hitarea_mc:MovieClip;

	public function AnswerUI()
	{
		// anzeige buchstabe
		character_txt.autoSize = "left";
	}

	/**
	 * Antwort anzeigen
	 * @param answer Antwort gekapselt in entsprechendem Bean
	 * @param character neben der Antwort anzuzeigenden Buchstabe
	 */
	public function showAnswer(answer:Answer, character:String):Void
	{
		// antwort speichern
		setAnswer(answer);
		// text anzeigen
		answer_txt.text = getAnswer().getAntworttext();
		// buchstabe anzeigen
		character_txt.text = character;
	}

	public function onLoad():Void
	{
		// hitarea erzeugen
		hitarea_mc = CalendarUtils.createHitarea(this, answer_txt);
		// als hitarea
		this.hitArea = hitarea_mc;
	}

	public function onRelease():Void
	{
		// antwort uebergeben
		Adventcalendar.getInstance().answerQuestion(getAnswer());
	}

	public function setAnswer(answer:com.adgamewonderland.cma.adventskalender2006.beans.Answer):Void
	{
		this.answer = answer;
	}

	public function getAnswer():com.adgamewonderland.cma.adventskalender2006.beans.Answer
	{
		return this.answer;
	}
}