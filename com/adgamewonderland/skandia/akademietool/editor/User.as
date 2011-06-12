/*
klasse:			User
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		11.02.2005
zuletzt bearbeitet:	11.02.2005
durch			gj
status:			final
*/  

class com.adgamewonderland.skandia.akademietool.editor.User {
	
	private var myUserid:Number;
	
	private var myNickname:String;
	
	private var myName:String;
	
	private var myEmail:String;
	
	public function User()
	{
		// user id aus datenbank
		myUserid = null;
		// nickname 6stellig
		myNickname = "";
		// name
		myName = "";
		// email
		myEmail = "";	
	}
	
	public function set userid(num:Number ):Void
	{
		// user id aus datenbank
		myUserid = num;
	}
	
	public function get userid():Number
	{
		// user id aus datenbank
		return myUserid;
	}
	
	public function set nickname(str:String ):Void
	{
		// nickname 6stellig
		myNickname = str;	
	}
	
	public function get nickname():String
	{
		// nickname 6stellig
		return myNickname;
	}
	
	public function set name(str:String ):Void
	{
		// name
		myName = str;	
	}
	
	public function get name():String
	{
		// name
		return myName;
	}
	
	public function set email(str:String ):Void
	{
		// email
		myEmail = str;	
	}
	
	public function get email():String
	{
		// email
		return myEmail;
	}
}