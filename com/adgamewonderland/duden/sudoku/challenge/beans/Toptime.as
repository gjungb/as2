/**
 * Bestzeit (inkl. ihm zugerechnete Strafzeit), die ein Spieler im Sudoku bei einem Schwierigkeitsgrad erzielt hat [sec]
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Toptime
{
	private var ID:Number;
	/**
	 * Schwierigkeitsgrad (@see Sudoku)
	 */
	private var difficulty:Number;
	/**
	 * Spielzeit (inkl. Strafzeit) [sec]
	 */
	private var time:Number;

	public function Toptime()
	{
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Toptime", Toptime);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setDifficulty(difficulty:Number):Void
	{
		this.difficulty = difficulty;
	}

	public function getDifficulty():Number
	{
		return this.difficulty;
	}

	public function setTime(time:Number):Void
	{
		this.time = time;
	}

	public function getTime():Number
	{
		return this.time;
	}

	public function toString() : String {
		return "com.adgamewonderland.duden.sudoku.challenge.beans.Toptime: " + getID() + ", " + getDifficulty() + ", " + getTime();
	}
}