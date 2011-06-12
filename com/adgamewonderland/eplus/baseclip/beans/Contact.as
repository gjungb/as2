import com.adgamewonderland.eplus.baseclip.interfaces.ISendable;
import com.adgamewonderland.agw.Formprocessor;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.beans.Contact implements ISendable
{

	public static var SALUTATION_MALE:Number = 1;
	public static var SALUTATION_FEMALE:Number = 2;

	private var salutation:Number;

	private var firstname:String;

	private var lastname:String;

	private var mobile:String;

	private var email:String;

	private var message:String;

	public function Contact() {
	}

	public function getLoadVars():LoadVars
	{
		// neues loadvars object
		var sender:LoadVars = new LoadVars();
		// mit allen eigenschaften der bean befuellen
		for (var i:String in this) {
			// befuellen
			sender[i] = this[i];
		}
		// sonderbehandlung salutation
		if (getSalutation() == SALUTATION_MALE) sender["salutation"] = "Herr";
		if (getSalutation() == SALUTATION_FEMALE) sender["salutation"] = "Frau";
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
		params.push(Formprocessor.TYPE_EMPTY, "mobile", getMobile());
		params.push(Formprocessor.TYPE_EMAIL, "email", getEmail());
		params.push(Formprocessor.TYPE_EMPTY, "sendermessage", getMessage());
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

	public function setMessage(message:String):Void
	{
		this.message = message;
	}

	public function getMessage():String
	{
		return this.message;
	}
}