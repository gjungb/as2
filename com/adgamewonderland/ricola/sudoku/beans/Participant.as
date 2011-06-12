/**
 * @author gerd
 */
 
class com.adgamewonderland.ricola.sudoku.beans.Participant {
	
	private var ID:Number;
	
	private var sex:Number;
	
	private var firstname:String;
	
	private var lastname:String;
	
	private var email:String;
	
	private var street:String;
	
	private var postcode:String;
	
	private var city:String;
	
	private var optin:Boolean;
	
	private var phoneprefix:String;
	
	private var phoneextension:String;
	
	public function Participant() {
		ID = 0;
		sex = 0;
		firstname = "";
		lastname = "";
		email = "";
		street = "";
		postcode = "";
		city = "";
		optin = false;
		phoneprefix = "";
		phoneextension = "";

		Object.registerClass("com.adgamewonderland.ricola.sudoku.beans.Participant", Participant);
	}
	
//	public function isKnown():Boolean
//	{
//		// testen, ob offizielle userid
//		return (getID() > 0);	
//	}
	
	public function getOptin():Boolean {
		return optin;
	}

	public function setOptin(optin:Boolean):Void {
		this.optin = optin;
	}

	public function getCity():String {
		return city;
	}

	public function setCity(city:String):Void {
		this.city = city;
	}

	public function getEmail():String {
		return email;
	}

	public function setEmail(email:String):Void {
		this.email = email;
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

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getSex():Number {
		return sex;
	}

	public function setSex(sex:Number):Void {
		this.sex = sex;
	}

	public function getPostcode():String {
		return postcode;
	}

	public function setPostcode(postcode:String):Void {
		this.postcode = postcode;
	}

	public function getFirstname():String {
		return firstname;
	}

	public function setFirstname(firstname:String):Void {
		this.firstname = firstname;
	}

	public function getPhoneprefix():String {
		return phoneprefix;
	}

	public function setPhoneprefix(phoneprefix:String):Void {
		this.phoneprefix = phoneprefix;
	}

	public function getPhoneextension():String {
		return phoneextension;
	}

	public function setPhoneextension(phoneextension:String):Void {
		this.phoneextension = phoneextension;
	}
	
	public function toString():String
	{
		var ret:String = "Participant: ";
		for (var i:String in this) ret += i + ": " + this[i] + ", ";
		return (ret);
	}

}