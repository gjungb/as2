/**
 *
 * Layout eines Sudoku-Spiels mit 9 x 9 Feldern
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Sudoku
{

	public static var DIFFICULTY_EASY:Number = 1;

	public static var DIFFICULTY_MEDIUM:Number = 2;

	public static var DIFFICULTY_HARD:Number = 3;

	private var ID:Number;
	/**
	 * Datum zu dem Sudoku in Tabelle angelegt wurde
	 */
	private var creationdate:Date;
	/**
	 * Schwierigkeitsgrad mit dem das Sudoku im Flash-Film/Frontend angezeigt wird.
	 */
	private var difficulty:Number;
	/**
	 * Ziffern, die zur Lösung des Sudoku eingetragen werden müssen
	 * Als String mit 81 Ziffern von 0..9, zeilenweise beginnend mit dem Feld in der ersten Zeile und ersten Spalte
	 */
	private var solutions:String;
	/**
	 * Felder, der Inhalt beim Start des Sudoku zu sehen sind Als String mit 81 Ziffern von 0..1, zeilenweise beginnend mit dem Feld in der ersten Zeile und ersten Spalte
	 * 0: Feld ist nicht zu sehen
	 * 1: Feld ist zu sehen
	 */
	private var starters:String;

	public function Sudoku()
	{
//		this.ID = 0;
//		this.creationdate = new Date();
//		this.difficulty = DIFFICULTY_EASY;
//		this.solutions = "928675143537142869461839572374281695895763214612954738789326451156498327243517986";
//		this.starters = "010011110111000111001111010100111001111000111100111001010111100111000111011110010";
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Sudoku", Sudoku);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setCreationdate(creationdate:Date):Void
	{
		this.creationdate = creationdate;
	}

	public function getCreationdate():Date
	{
		return this.creationdate;
	}

	public function setDifficulty(difficulty:Number):Void
	{
		this.difficulty = difficulty;
	}

	public function getDifficulty():Number
	{
		return this.difficulty;
	}

	public function setSolutions(solutions:String):Void
	{
		this.solutions = solutions;
	}

	public function getSolutions():String
	{
		return this.solutions;
	}

	public function setStarters(starters:String):Void
	{
		this.starters = starters;
	}

	public function getStarters():String
	{
		return this.starters;
	}

	public function clone():Sudoku
	{
		// neues sudoku
		var sudoku:Sudoku = new Sudoku();
		// bean befuellen
		sudoku.setID(getID());
		sudoku.setCreationdate(getCreationdate());
		sudoku.setDifficulty(getDifficulty());
		sudoku.setSolutions(getSolutions());
		sudoku.setStarters(getStarters());
		// zurueck geben
		return sudoku;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.Sudoku\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}