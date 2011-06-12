/**
 * @author gerd
 */
class com.adgamewonderland.dhl.adventsgewinnspiel.beans.Winner {
	
	private var ID:Number;
	
	private var firstname:String;
	
	private var lastname:String;
	
	private var email:String;
	
	private var street:String;
	
	private var postcode:String;
	
	private var city:String;
	
	private var postno:String;
	
	private var optin:Boolean;
	
	private var newsletter:Boolean;
	
	private var reminder:Boolean;
	
	private var lastgame:Date;
	
	public function Winner() {
		ID = 0;
		firstname = "";
		lastname = "";
		email = "";
		street = "";
		postcode = "";
		city = "";
		postno = "";
		optin = false;
		newsletter = false;
		reminder = true;
		lastgame = null;
	}
	
	public function getFirstname():String {
		return firstname;
	}

	public function setFirstname(firstname:String):Void {
		this.firstname = firstname;
	}

	public function getReminder():Boolean {
		return reminder;
	}

	public function setReminder(reminder:Boolean):Void {
		this.reminder = reminder;
	}

	public function getCity():String {
		return city;
	}

	public function setCity(city:String):Void {
		this.city = city;
	}

	public function getStreet():String {
		return street;
	}

	public function setStreet(street:String):Void {
		this.street = street;
	}

	public function getPostcode():String {
		return postcode;
	}

	public function setPostcode(postcode:String):Void {
		this.postcode = postcode;
	}

	public function getOptin():Boolean {
		return optin;
	}

	public function setOptin(optin:Boolean):Void {
		this.optin = optin;
	}

	public function getNewsletter():Boolean {
		return newsletter;
	}

	public function setNewsletter(newsletter:Boolean):Void {
		this.newsletter = newsletter;
	}

	public function getLastname():String {
		return lastname;
	}

	public function setLastname(lastname:String):Void {
		this.lastname = lastname;
	}

	public function getLastgame():Date {
		return lastgame;
	}

	public function setLastgame(lastgame:Date):Void {
		this.lastgame = lastgame;
	}

	public function getEmail():String {
		return email;
	}

	public function setEmail(email:String):Void {
		this.email = email;
	}

	public function getPostno():String {
		return postno;
	}

	public function setPostno(postno:String):Void {
		this.postno = postno;
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

}