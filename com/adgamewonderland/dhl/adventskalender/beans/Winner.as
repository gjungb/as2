/**
 * @author gerd
 */
class com.adgamewonderland.dhl.adventskalender.beans.Winner {
	
	private var firstname:String;
	
	private var lastname:String;
	
	private var email:String;
	
	private var postcode:String;
	
	private var city:String;
	
	private var street:String;
	
	private var optin:Boolean;
	
	private var postno:String;
	
	private var gid:Number;
	
	public function Winner() {
		firstname = "";
		lastname = "";
		email = "";
		postcode = "";
		city = "";
		street = "";
		optin = false;
		postno = "";
		gid = null;
	}
	
	public function getPostno():String {
		return postno;
	}

	public function setPostno(postno:String):Void {
		this.postno = postno;
	}

	public function getFirstname():String {
		return firstname;
	}

	public function setFirstname(firstname:String):Void {
		this.firstname = firstname;
	}

	public function getStreet():String {
		return street;
	}

	public function setStreet(street:String):Void {
		this.street = street;
	}

	public function getLastname():String {
		return lastname;
	}

	public function setLastname(lastname:String):Void {
		this.lastname = lastname;
	}

	public function getPostcode():String {
		return postcode;
	}

	public function setPostcode(postcode:String):Void {
		this.postcode = postcode;
	}

	public function getEmail():String {
		return email;
	}

	public function setEmail(email:String):Void {
		this.email = email;
	}

	public function getCity():String {
		return city;
	}

	public function setCity(city:String):Void {
		this.city = city;
	}

	public function getGid():Number {
		return gid;
	}

	public function setGid(gid:Number):Void {
		this.gid = gid;
	}

	public function getOptin():Boolean {
		return optin;
	}

	public function setOptin(optin:Boolean):Void {
		this.optin = optin;
	}

}