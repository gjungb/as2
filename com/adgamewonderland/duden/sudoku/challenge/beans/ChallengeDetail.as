import com.adgamewonderland.duden.sudoku.challenge.beans.User;
import com.adgamewonderland.duden.sudoku.challenge.beans.Result;
/**
 *
 * Details zu einer Hälfte einer Spielpartie (Herausforderer || Gegner)
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail
{
	public static var MODE_CHALLENGER:Number = 0;
	public static var MODE_OPPONENT:Number = 1;
	public static var STATUS_WON:Number = 1;
	public static var STATUS_LOST:Number = 2;
	public static var STATUS_DRAWN:Number = 3;

	private var ID:Number;
	/**
	 *
	 * Modus des Users ( Herausforderer || Gegner), s. statische Variablen MODE_
	 */
	private var mode:Number;
	/**
	 *
	 * Abschließender Status dieser Hälfte der Spielpartie, s. statische Variablen STATUS_
	 */
	private var status:Number;
	/**
	 *
	 * E-Mail-Adresse des Herausgeforderten
	 */
	private var opponentemail:String;
	/**
	 *
	 * Schalter, ob diese Details in den Listen zu offenen Herausforderungen / Siegerehrungen angezeigt werden sollen
	 */
	private var showinlist:Boolean;
	private var user:User;
	private var result:Result;

	public function ChallengeDetail()
	{
//		this.ID = 0;
//		this.mode = MODE_CHALLENGER;
//		this.status = 0;
//		this.opponentemail = "";
//		this.showinlist = false;
//		this.user = new User();
//		this.result = new Result();
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail", ChallengeDetail);
	}

	public function setUser(user:User):Void
	{
		this.user = user;
	}

	public function getUser():User
	{
		return this.user;
	}

	public function setResult(result:Result):Void
	{
		this.result = result;
	}

	public function getResult():Result
	{
		return this.result;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setMode(mode:Number):Void
	{
		this.mode = mode;
	}

	public function getMode():Number
	{
		return this.mode;
	}

	public function setStatus(status:Number):Void
	{
		this.status = status;
	}

	public function getStatus():Number
	{
		return this.status;
	}

	public function setOpponentemail(opponentemail:String):Void
	{
		this.opponentemail = opponentemail;
	}

	public function getOpponentemail():String
	{
		return this.opponentemail;
	}

	public function setShowinlist(showinlist:Boolean):Void
	{
		this.showinlist = showinlist;
	}

	public function isShowinlist():Boolean
	{
		return this.showinlist;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}