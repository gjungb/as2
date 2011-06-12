/**
 * eine Frage mit Antworten
 */
class com.adgamewonderland.cma.adventskalender2006.beans.Question 
{
	private var fid:Number;
	private var text:String;
	private var answers:Array;

	public function Question(fid:Number, text:String)
	{
		// ids der frage aus dem gewinnspiel-backend
		this.fid = fid;
		// text der frage
		this.text = text;
		// array der antworten
		this.answers = new Array();
	}

	public function addAnswers(answers:com.adgamewonderland.cma.adventskalender2006.beans.Answer):Void
	{
		this.answers.push(answers);
	}

	public function removeAnswers(answers:com.adgamewonderland.cma.adventskalender2006.beans.Answer):Void
	{
		for (var i:Number = 0; i < this.answers.length; i++)
		{
			if (this.answers[i] == answers)
			{
				this.answers.splice(i, 1);
			}
		}
	}

	public function toAnswersArray():Array
	{
		return this.answers;
	}

	public function setFid(fid:Number):Void
	{
		this.fid = fid;
	}

	public function getFid():Number
	{
		return this.fid;
	}

	public function setText(text:String):Void
	{
		this.text = text;
	}

	public function getText():String
	{
		return this.text;
	}
	
	public function toString() : String {
		return "Question " + getFid() + ": " + getText() + "\r\n" + toAnswersArray();
	}
}