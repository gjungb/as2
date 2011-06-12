/**
 * @author gerd
 */
 
import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;
 
class com.adgamewonderland.digitalbanal.elfmeterduell.beans.User {
	
	private var userID:Number;
	
	private var nickname:String;
	
	private var email:String;
	
	private var password:String;
	
	private var address:Address;
	
	private var preference:Preference;
	
	private var statistics:Statistics;
	
	private var games:Array;
	
	public function User() {
		this.userID = null;
		this.nickname = "";
		this.email = "";
		this.password = "";
		this.address = new Address();
		this.preference = new Preference();
		this.statistics = new Statistics();
		this.games = new Array();
		
//		Object.registerClass("User", com.adgamewonderland.digitalbanal.elfmeterduell.beans.User);
	}
	
	public function getNickname():String {
		return nickname;
	}

	public function setNickname(nickname:String):Void {
		this.nickname = nickname;
	}

	public function getPassword():String {
		return password;
	}

	public function setPassword(password:String):Void {
		this.password = password;
	}

	public function getEmail():String {
		return email;
	}

	public function setEmail(email:String):Void {
		this.email = email;
	}

	public function getUserID():Number {
		return userID;
	}

	public function setUserID(userID:Number):Void {
		this.userID = userID;
	}

	public function getAddress():Address {
		return address;
	}

	public function setAddress(address:Address):Void {
		this.address = address;
	}

	public function getPreference():Preference {
		return preference;
	}

	public function setPreference(preference:Preference):Void {
		this.preference = preference;
	}

	public function getStatistics():Statistics {
		return statistics;
	}

	public function setStatistics(statistics:Statistics):Void {
		this.statistics = statistics;
	}

}