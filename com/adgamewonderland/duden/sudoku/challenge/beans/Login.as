/**
 *
 * Login-Information zu einem User
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Login
{
	public static var STATUS_CLOSED:Number = 0;
	public static var STATUS_OPEN:Number = 1;

	private var ID:Number;
	/**
	 *
	 * Passwort, mit dem sich der User einloggt. Darf nachträglich geändert werden.
	 */
	private var password:String;
	/**
	 *
	 * Status des Accounts entsprechend der statischen Felder STATUS_
	 */
	private var status:Number = 0;

	public function Login()
	{
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Login", Login);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setPassword(password:String):Void
	{
		this.password = password;
	}

	public function getPassword():String
	{
		return this.password;
	}

	public function setStatus(status:Number):Void
	{
		this.status = status;
	}

	public function getStatus():Number
	{
		return this.status;
	}
}