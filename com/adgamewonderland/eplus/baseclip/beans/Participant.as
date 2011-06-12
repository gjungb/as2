import com.adgamewonderland.eplus.baseclip.interfaces.ISendable;
import com.adgamewonderland.agw.Formprocessor;
import com.adgamewonderland.agw.util.TimeFormater;
/**
 * Ein Teilnehmer am "BASE Clip"-Wettbewerb
 */
class com.adgamewonderland.eplus.baseclip.beans.Participant implements ISendable
{
	public static var SALUTATION_MALE:Number = 1;
	public static var SALUTATION_FEMALE:Number = 2;

	private var ID:Number;
	/**
	 * Geschlecht / Anrede (siehe statische Felder SEX_)
	 */
	private var salutation:Number;
	/**
	 * Vorname
	 */
	private var firstname:String;
	/**
	 * Nachname
	 */
	private var lastname:String;
	/**
	 * Straße und Hausnummer
	 */
	private var street:String;
	/**
	 * Postleitzahl ohne Länderkennung, mit führender Null
	 */
	private var postcode:String;
	/**
	 * Wohnort
	 */
	private var city:String;
	/**
	 * Geburtsdatum
	 */
	private var birthday:Date;
	/**
	 * Mobiltelefonnummer unformatiert
	 */
	private var mobile:String;
	/**
	 * E-Mail Adresse
	 */
	private var email:String;
	/**
	 * Nickname
	 */
	private var nickname:String;
	/**
	 * Zustimmung Einverständniserklärung
	 */
	private var optin1:Boolean;
	/**
	 * Zustimmung Teilnahmebedingungen
	 */
	private var optin2:Boolean;
	/**
	 * Datum und Uhrzeit der Teilnahme
	 */
	private var registrationdate:Date;

	public function Participant() {

	}

	public function getLoadVars():LoadVars
	{
		// neues loadvars object
		var sender:LoadVars = new LoadVars();
		// mit allen eigenschaften der bean befuellen
		for (var i : String in this) {
			// befuellen
			sender[i] = this[i];
		}
		// sonderbehandlung birthday
		sender["birthday.day"] = getBirthday().getDate();
		sender["birthday.month"] = getBirthday().getMonth();
		sender["birthday.year"] = getBirthday().getFullYear();
		// zurueck geben
		return sender;
	}

	public function getErrors():Array
	{
		// sind die attribute alle korrekt befuellt
		var errors:Array = new Array();
		// parameter zur uebergabe an den formprocessor
		var params:Array = new Array();
		params.push(Formprocessor.TYPE_EMPTY, "salutation", getSalutation());
		params.push(Formprocessor.TYPE_EMPTY, "firstname", getFirstname());
		params.push(Formprocessor.TYPE_EMPTY, "lastname", getLastname());
		params.push(Formprocessor.TYPE_EMPTY, "street", getStreet());
		params.push(Formprocessor.TYPE_PLZ, "postcode", getPostcode());
		params.push(Formprocessor.TYPE_EMPTY, "city", getCity());
		params.push(Formprocessor.TYPE_DATE, "birthday", TimeFormater.getDayMonthYear(getBirthday(), ""));
		params.push(Formprocessor.TYPE_EMPTY, "mobile", getMobile());
		params.push(Formprocessor.TYPE_EMAIL, "email", getEmail());
		params.push(Formprocessor.TYPE_EMPTY, "nickname", getNickname());
		params.push(Formprocessor.TYPE_TRUE, "optin1", isOptin1());
		params.push(Formprocessor.TYPE_TRUE, "optin2", isOptin2());
		// sonderbehandlung birthday
		params.push(Formprocessor.TYPE_NUMBER, "birthday_day", getBirthday().getDate());
		params.push(Formprocessor.TYPE_NUMBER, "birthday_month", getBirthday().getMonth());
		params.push(Formprocessor.TYPE_NUMBER, "birthday_year", getBirthday().getFullYear());
		// validieren
		errors = new Formprocessor().checkForm(params);
		// zurueck geben
		return errors;
	}

	public function setSalutation(salutation:Number):Void
	{
		this.salutation = salutation;
	}

	public function getSalutation():Number
	{
		return this.salutation;
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

	public function setBirthday(birthday:Date):Void
	{
		this.birthday = birthday;
	}

	public function getBirthday():Date
	{
		return this.birthday;
	}

	public function setMobile(mobile:String):Void
	{
		this.mobile = mobile;
	}

	public function getMobile():String
	{
		return this.mobile;
	}

	public function setEmail(email:String):Void
	{
		this.email = email;
	}

	public function getEmail():String
	{
		return this.email;
	}

	public function setNickname(nickname:String):Void
	{
		this.nickname = nickname;
	}

	public function getNickname():String
	{
		return this.nickname;
	}

	public function setOptin1(optin1:Boolean):Void
	{
		this.optin1 = optin1;
	}

	public function isOptin1():Boolean
	{
		return this.optin1;
	}

	public function setOptin2(optin2:Boolean):Void
	{
		this.optin2 = optin2;
	}

	public function isOptin2():Boolean
	{
		return this.optin2;
	}

	public function setRegistrationdate(registrationdate:Date):Void
	{
		this.registrationdate = registrationdate;
	}

	public function getRegistrationdate():Date
	{
		return this.registrationdate;
	}

	/**
	 * @Override
	 */
	public function toString() : String {
		var str:String = "com.adgamewonderland.eplus.baseclip.beans.Participant";
		for (var i : String in this) {
			str += i + ": " + this[i] + "\r\n";
		}
		return str;
	}

}