import com.adgamewonderland.duden.sudoku.challenge.beans.Address;
import com.adgamewonderland.duden.sudoku.challenge.beans.Challenge;
import com.adgamewonderland.duden.sudoku.challenge.beans.Login;
import com.adgamewonderland.duden.sudoku.challenge.beans.Preference;
import com.adgamewonderland.duden.sudoku.challenge.beans.Statistics;
/**
 *
 * Grundlegende Angaben zum User
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.User
{
	private var ID:Number = 0;
	/**
	 *
	 * E-Mail-Adresse des Users, die als eindeutiger Schlüssel bei der Registrierung und Herausforderung gilt und nicht geändert werden darf.
	 */
	private var email:String = "";
	/**
	 *
	 * Nickname, mit dem der User im Spiel angesprochen sowie in E-Mails, Highscorelisten etc. zu sehen ist. Der Nickname darf nachträglich geändert werden.
	 */
	private var nickname:String = "";
	private var hashkey:String = "";
	private var challenges:Array = new Array();
	private var address:Address;
	private var preference:Preference;
	private var statistics:Statistics;
	private var login:Login;

	public function User()
	{
//		// id
//		this.ID = 0;
//		// email
//		this.email = "";
//		// nickname
//		this.nickname = "";
//		// hashkey fuer double optin
//		this.hashkey = "";
//		// adresse
//		this.address = new Address();
//		// preferences
//		this.preference = new Preference();
//		// statistics
//		this.statistics = new Statistics();
//		// login
//		this.login = new Login();
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.User", User);
	}

	public function addChallenges(challenges:Challenge):Void
	{
		this.challenges.push(challenges);
	}

	public function removeChallenges(challenges:Challenge):Void
	{
		for (var i:Number = 0; i < this.challenges.length; i++)
		{
			if (this.challenges[i] == challenges)
			{
				this.challenges.splice(i, 1);
			}
		}
	}

	public function toChallengesArray():Array
	{
		return this.challenges;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setAddress(address:Address):Void
	{
		this.address = address;
	}

	public function getAddress():Address
	{
		return this.address;
	}

	public function setPreference(preference:Preference):Void
	{
		this.preference = preference;
	}

	public function getPreference():Preference
	{
		return this.preference;
	}

	public function setStatistics(statistics:Statistics):Void
	{
		this.statistics = statistics;
	}

	public function getStatistics():Statistics
	{
		return this.statistics;
	}

	public function setLogin(login:Login):Void
	{
		this.login = login;
	}

	public function getLogin():Login
	{
		return this.login;
	}

	public function setEmail(email:String):Void
	{
		this.email = email;
	}

	public function getEmail():String
	{
		return this.email;
	}

	public function setNickname(nickname:String):Void
	{
		this.nickname = nickname;
	}

	public function getNickname():String
	{
		return this.nickname;
	}

	public function setHashkey(hashkey:String):Void
	{
		this.hashkey = hashkey;
	}

	public function getHashkey():String
	{
		return this.hashkey;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.User\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}