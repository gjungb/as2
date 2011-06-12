class com.adgamewonderland.cma.adventskalender2006.beans.Quiz 
{
	private var question:com.adgamewonderland.cma.adventskalender2006.beans.Question;
	private var day:com.adgamewonderland.cma.adventskalender2006.beans.Day;

	public function Quiz(question:com.adgamewonderland.cma.adventskalender2006.beans.Question, day:com.adgamewonderland.cma.adventskalender2006.beans.Day)
	{
		// frage
		this.question = question;
		// kalendertag
		this.day = day;
	}

	public function setQuestion(question:com.adgamewonderland.cma.adventskalender2006.beans.Question):Void
	{
		this.question = question;
	}

	public function getQuestion():com.adgamewonderland.cma.adventskalender2006.beans.Question
	{
		return this.question;
	}

	public function setDay(day:com.adgamewonderland.cma.adventskalender2006.beans.Day):Void
	{
		this.day = day;
	}

	public function getDay():com.adgamewonderland.cma.adventskalender2006.beans.Day
	{
		return this.day;
	}
	
	public function toString(Void) : String {
		return "Quiz: " + getDay().getDate() + ", " + getQuestion();
	}
}