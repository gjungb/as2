/**
 * @author gerd
 */
 
class com.adgamewonderland.dhl.adventskalender.beans.User {
	
	private var name:String;
	
	private var email:String;
	
	public function User() {
		this.name = "";
		this.email = "";
	}
	
	public function getEmail():String {
		return email;
	}

	public function setEmail(email:String):Void {
		this.email = email;
	}

	public function getName():String {
		return name;
	}

	public function setName(name:String):Void {
		this.name = name;
	}
	
}