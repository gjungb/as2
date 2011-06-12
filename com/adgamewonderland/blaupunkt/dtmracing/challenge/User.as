/*
klasse:			User
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		08.06.2005
zuletzt bearbeitet:	15.06.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

class com.adgamewonderland.blaupunkt.dtmracing.challenge.User {

	// Attributes
    
    public static var STATUS_SUCCESS:Number = 1;
    
    public static var STATUS_FAILED:Number = 2;
	
	private var uid:Number;
	
	private var email:String;
	
	private var password:String;
	
	private var nickname:String;
	
	private var address:UserAddress;
	
	// Operations
	
	public function User(uid:Number, email:String, password:String, nickname:String, address:UserAddress )
	{
		// uid
		this.uid = uid;
		// email
		this.email = email;
		// password
		this.password = password;
		// nickname
		this.nickname = nickname;
		// adresse
		this.address = address;
	}
	
	public function setUid(num:Number ):Void
	{
		uid = num;
	}
	
	public function getUid():Number
	{
		return (uid);
	}
	
	public function setEmail(str:String ):Void
	{
		email = str;
	}
	
	public function getEmail():String
	{
		return (email);
	}
	
	public function setNickname(str:String ):Void
	{
		nickname = str;
	}
	
	public function getNickname():String
	{
		return (nickname);
	}
	
	public function setPassword(str:String ):Void
	{
		password = str;
	}
	
	public function getPassword():String
	{
		return (password);
	}
	
	public function setAddress(obj:UserAddress ):Void
	{
		address = obj;
	}
	
	public function getAddress():UserAddress
	{
		return (address);
	}

} /* end class User */
