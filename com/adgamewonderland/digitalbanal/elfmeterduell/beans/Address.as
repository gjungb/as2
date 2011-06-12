/**
 * @author gerd
 */
class com.adgamewonderland.digitalbanal.elfmeterduell.beans.Address {
	
	public static var SEX_MALE:Number = 0;
	
	public static var SEX_FEMALE:Number = 1;
	
	private var addressID:Number;
	
	private var sex:Number;
	
	private var firstname:String;
	
	private var lastname:String;
	
	private var street:String;
	
	private var postcode:String;
	
	private var city:String;
	
	private var country:String;
	
	public function Address() {
		this.addressID = null;
		this.sex = null;
		this.firstname = "";
		this.lastname = "";
		this.street = "";
		this.postcode = "";
		this.city = "";
		this.country = "";
		
//		Object.registerClass("Address", com.adgamewonderland.digitalbanal.elfmeterduell.beans.Address);
	}
	
	public function getAddressID():Number {
		return addressID;
	}

	public function setAddressID(addressID:Number):Void {
		this.addressID = addressID;
	}

	public function getCity():String {
		return city;
	}

	public function setCity(city:String):Void {
		this.city = city;
	}

	public function getPostcode():String {
		return postcode;
	}

	public function setPostcode(postcode:String):Void {
		this.postcode = postcode;
	}

	public function getStreet():String {
		return street;
	}

	public function setStreet(street:String):Void {
		this.street = street;
	}

	public function getSex():Number {
		return sex;
	}

	public function setSex(sex:Number):Void {
		this.sex = sex;
	}

	public function getFirstname():String {
		return firstname;
	}

	public function setFirstname(firstname:String):Void {
		this.firstname = firstname;
	}

	public function getLastname():String {
		return lastname;
	}

	public function setLastname(lastname:String):Void {
		this.lastname = lastname;
	}

	public function getCountry():String {
		return country;
	}

	public function setCountry(country:String):Void {
		this.country = country;
	}

}