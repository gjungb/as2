import com.adgamewonderland.duden.sudoku.challenge.beans.Sudoku;
import com.adgamewonderland.duden.sudoku.challenge.beans.Term;
import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail;
import com.adgamewonderland.duden.sudoku.challenge.beans.User;
/**
 *
 * Spielpartie mit zwei Usern, die per E-Mail über Herausforderung und Siegerehrung informiert werden
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Challenge
{
	public static var STATUS_CHALLENGER_DONE:Number = 1;
	public static var STATUS_OPPONENT_DONE:Number = 2;
	public static var STATUS_OPPONENT_AWARDED:Number = 3;
	public static var STATUS_CHALLENGER_AWARDED:Number = 4;
	public static var STATUS_REJECTED:Number = 5;

	private var ID:Number = 0;
	/**
	 * 32-stellige ID, die zur Identifizierung des Spiels über den Link in der Herausforderungs- / Siegerehrungs-E-Mail verwendet wird.
	 */
	private var hashkey:String = "";
	/**
	 * aktueller Status der Spielpartie (s. statische Variablen STATUS_)
	 */
	private var status:Number;
	private var sudoku:Sudoku;
	private var details:Array = new Array();
	private var term:Term;

	public function Challenge()
	{
//		this.ID = 0;
//		this.hashkey = "";
//		this.status = 0;
//		this.sudoku = new Sudoku();
//		this.details  = new Array();
//		this.term = new Term();
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Challenge", Challenge);
	}

	public function getDetail(mode:Number):ChallengeDetail
	{
		return null;
	}

	public function addDetail(mode:Number, detail:ChallengeDetail):Void
	{
	}

	public function getWinner():User
	{
		return null;
	}

	public function setSudoku(sudoku:Sudoku):Void
	{
		this.sudoku = sudoku;
	}

	public function getSudoku():Sudoku
	{
		return this.sudoku;
	}

	public function setTerm(term:Term):Void
	{
		this.term = term;
	}

	public function getTerm():Term
	{
		return this.term;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setHashkey(hashkey:String):Void
	{
		this.hashkey = hashkey;
	}

	public function getHashkey():String
	{
		return this.hashkey;
	}

	public function setStatus(status:Number):Void
	{
		this.status = status;
	}

	public function getStatus():Number
	{
		return Number(this.status);
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.Challenge\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}