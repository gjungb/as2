/* User
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			User
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			n24
erstellung: 		21.04.2004 (e-plus)
zuletzt bearbeitet:	25.11.2005
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.n24.christmas.User {

	// Attributes
	
	private var myUserid:Number;
	
	private var myEmail:String;
	
	private var myNickname:String;
	
	private var myPassword:String;
	
	private var myLoginStatus:Boolean;
	
	private var myScore:Number;
	
	private var myScoreday:Number;
	
	private var myScoremax:Number;
	
	private var myTimestamp:Number;
	
	private var myOptin:Number;
	
	// Operations
	
	public function User(emstr:String )
	{
		// userid
		userid = null;
		// email
		email = emstr;
		// nickname
		nickname = "";
		// password
		password = "";
		// loginstatus
		loginstatus = false;
		// score
		score = 0;
		// scoreday
		scoreday = 0;
		// scoremax
		scoremax = 0;
	}
	
	public function set userid(num:Number ):Void
	{
		myUserid = num;
	}
	
	public function get userid():Number
	{
		return (myUserid);
	}
	
	public function set email(str:String ):Void
	{
		myEmail = str;
	}
	
	public function get email():String
	{
		return (myEmail);
	}
	
	public function set nickname(str:String ):Void
	{
		myNickname = str;
	}
	
	public function get nickname():String
	{
		return (myNickname);
	}
	
	public function set password(str:String ):Void
	{
		myPassword = str;
	}
	
	public function get password():String
	{
		return (myPassword);
	}
	
	public function set loginstatus(bool:Boolean ):Void
	{
		myLoginStatus = bool;
	}
	
	public function get loginstatus():Boolean
	{
		return (myLoginStatus);
	}
	
	public function set score(num:Number ):Void
	{
		myScore = num;
	}
	
	public function get score():Number
	{
		return (myScore);
	}
	
	public function set scoreday(num:Number ):Void
	{
		myScoreday = num;
	}
	
	public function get scoreday():Number
	{
		return (myScoreday);
	}
	
	public function set scoremax(num:Number ):Void
	{
		myScoremax = num;
	}
	
	public function get scoremax():Number
	{
		return (myScoremax);
	}
	
	public function set timestamp(num:Number ):Void
	{
		myTimestamp = num;
	}
	
	public function get timestamp():Number
	{
		return (myTimestamp);
	}
	
	public function set optin(num:Number ):Void
	{
		myOptin = num;
	}
	
	public function get optin():Number
	{
		return (myOptin);
	}

} /* end class User */
