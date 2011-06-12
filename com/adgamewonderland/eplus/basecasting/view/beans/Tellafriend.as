import com.adgamewonderland.agw.Formprocessor;
/**
 * Eine Weitersagen-Nachricht beim "BASE Clip"-Wettbewerb
 */
class com.adgamewonderland.eplus.basecasting.view.beans.Tellafriend
{
	/**
	 * E-Mail-Adresse des Empfängers
	 */
	private var receiveremail:String;
	/**
	 * Name des Empfängers
	 */
	private var receivername:String;
	/**
	 *  E-Mail-Adresse des Absenders
	 */
	private var senderemail:String;
	/**
	 * Name des Absenders
	 */
	private var sendername:String;
	/**
	 * persönliche Nachricht
	 */
	private var message:String;

	public function Tellafriend() {
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
		// zurueck geben
		return sender;
	}

	public function getErrors():Array
	{
		// sind die attribute alle korrekt befuellt
		var errors:Array = new Array();
		// parameter zur uebergabe an den formprocessor
		var params:Array = new Array();
		params.push(Formprocessor.TYPE_EMPTY, "sendername", getSendername());
		params.push(Formprocessor.TYPE_EMAIL, "senderemail", getSenderemail());
		params.push(Formprocessor.TYPE_EMPTY, "receivername", getReceivername());
		params.push(Formprocessor.TYPE_EMAIL, "receiveremail", getReceiveremail());
		// validieren
		errors = new Formprocessor().checkForm(params);
		// zurueck geben
		return errors;
	}

	public function setReceiveremail(receiveremail:String):Void
	{
		this.receiveremail = receiveremail;
	}

	public function getReceiveremail():String
	{
		return this.receiveremail;
	}

	public function setReceivername(receivername:String):Void
	{
		this.receivername = receivername;
	}

	public function getReceivername():String
	{
		return this.receivername;
	}

	public function setSenderemail(senderemail:String):Void
	{
		this.senderemail = senderemail;
	}

	public function getSenderemail():String
	{
		return this.senderemail;
	}

	public function setSendername(sendername:String):Void
	{
		this.sendername = sendername;
	}

	public function getSendername():String
	{
		return this.sendername;
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