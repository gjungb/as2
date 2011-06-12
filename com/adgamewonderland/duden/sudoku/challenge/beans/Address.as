/**
 *
 * Adressdaten des Users (für Verlosung und interne Zwecke wie z.B. Newsletter)
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Address
{
	public static var SEX_MALE:Number = 0;
	public static var SEX_FEMALE:Number = 1;

	private var ID:Number;
	/**
	 *
	 * Geschlecht (z.B. für Anrede in Newsletter)
	 */
	private var sex:Number;
	/**
	 *
	 * Vorname
	 */
	private var firstname:String;
	/**
	 *
	 * Nachname
	 */
	private var lastname:String;
	/**
	 *
	 * Strasse
	 */
	private var street:String;
	/**
	 *
	 * Postleitzahl (als String, damit führende 0 nicht verloren geht)
	 */
	private var postcode:String;
	/**
	 *
	 * Wohnort
	 */
	private var city:String;
	/**
	 *
	 * Staat (ISO-Code s. http://java.sun.com/j2se/1.4.2/docs/api/java/util/Locale.html)
	 */
	private var country:String;
	/**
	 *
	 * Telefonnummer
	 */
	private var phone:String;
	/**
	 *
	 *
	 * Mobiltelefonnummer
	 */
	private var mobile:String;

	public function Address()
	{
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Address", Address);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setSex(sex:Number):Void
	{
		this.sex = sex;
	}

	public function getSex():Number
	{
		return this.sex;
	}

	public function setFirstname(firstname:String):Void
	{
		this.firstname = firstname;
	}

	public function getFirstname():String
	{
		return this.firstname;
	}

	public function setLastname(lastname:String):Void
	{
		this.lastname = lastname;
	}

	public function getLastname():String
	{
		return this.lastname;
	}

	public function setStreet(street:String):Void
	{
		this.street = street;
	}

	public function getStreet():String
	{
		return this.street;
	}

	public function setPostcode(postcode:String):Void
	{
		this.postcode = postcode;
	}

	public function getPostcode():String
	{
		return this.postcode;
	}

	public function setCity(city:String):Void
	{
		this.city = city;
	}

	public function getCity():String
	{
		return this.city;
	}

	public function setCountry(country:String):Void
	{
		this.country = country;
	}

	public function getCountry():String
	{
		return this.country;
	}

	public function setPhone(phone:String):Void
	{
		this.phone = phone;
	}

	public function getPhone():String
	{
		return this.phone;
	}

	public function setMobile(mobile:String):Void
	{
		this.mobile = mobile;
	}

	public function getMobile():String
	{
		return this.mobile;
	}
}