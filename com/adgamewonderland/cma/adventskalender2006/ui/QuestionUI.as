import com.adgamewonderland.cma.adventskalender2006.beans.*;

/**
 * Darstellung einer Frage auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.QuestionUI extends MovieClip
{
	private var question:com.adgamewonderland.cma.adventskalender2006.beans.Question;
	private var question_txt:TextField;
	private var answer1_mc:com.adgamewonderland.cma.adventskalender2006.ui.AnswerUI;
	private var answer2_mc:com.adgamewonderland.cma.adventskalender2006.ui.AnswerUI;
	private var answer3_mc:com.adgamewonderland.cma.adventskalender2006.ui.AnswerUI;

	public function QuestionUI()
	{
	}

	/**
	 * Frage anzeigen
	 * @param question Frage gekapselt in entsprechendem Bean
	 */
	public function showQuestion(question:com.adgamewonderland.cma.adventskalender2006.beans.Question):Void
	{
		// frage speichern
		setQuestion(question);
		// text anzeigen
		question_txt.text = getQuestion().getText();
		// antworten anzeigen
		answer1_mc.showAnswer(getQuestion().toAnswersArray()[0], "A)");
		answer2_mc.showAnswer(getQuestion().toAnswersArray()[1], "B)");
		answer3_mc.showAnswer(getQuestion().toAnswersArray()[2], "C)");
	}

	public function onLoad():Void
	{
		// frage anzeigen
		showQuestion(_parent.getQuiz().getQuestion());
	}

	public function setQuestion(question:com.adgamewonderland.cma.adventskalender2006.beans.Question):Void
	{
		this.question = question;
	}

	public function getQuestion():com.adgamewonderland.cma.adventskalender2006.beans.Question
	{
		return this.question;
	}
}