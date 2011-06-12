/**
 *
 * Ergebnis einer Hälfte einer Spielpartie (Herausforderer || Gegner)
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Result
{
	private var ID:Number;
	/**
	 * Vom User benötigte Zeit zum Lösen der Aufgabe [sec]
	 */
	private var time:Number;
	/**
	 * Anzahl der Fehler, die der Spieler gemacht hat
	 */
	private var errors:Number;
	/**
	 * Strafzeit [sec], die dem User aufgrund von Fehlern angerechnet wurde
	 */
	private var penaltytime:Number;
	/**
	 * Punktzahl, die dem Spieler gutgeschrieben wurde
	 */
	private var score:Number;
	/**
	 * Bonuspunkte, die dem Spieler gutgeschrieben wurden, wenn er einen noch nicht registrierten User herausgefordert hat
	 */
	private var bonus:Number;

	public function Result()
	{
//		this.ID = 0;
//		this.time = Number.MAX_VALUE;
//		this.errors = 0;
//		this.penaltytime = 0;
//		this.score = 0;
//		this.bonus = 0;
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Result", Result);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setTime(time:Number):Void
	{
		this.time = time;
	}

	public function getTime():Number
	{
		return Number(this.time);
	}

	public function setErrors(errors:Number):Void
	{
		this.errors = errors;
	}

	public function getErrors():Number
	{
		return Number(this.errors);
	}

	public function setPenaltytime(penaltytime:Number):Void
	{
		this.penaltytime = penaltytime;
	}

	public function getPenaltytime():Number
	{
		return Number(this.penaltytime);
	}

	public function setScore(score:Number):Void
	{
		this.score = score;
	}

	public function getScore():Number
	{
		return Number(this.score);
	}

	public function setBonus(bonus:Number):Void
	{
		this.bonus = bonus;
	}

	public function getBonus():Number
	{
		return Number(this.bonus);
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.Result\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}