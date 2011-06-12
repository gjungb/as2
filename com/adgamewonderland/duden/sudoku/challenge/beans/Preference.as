/**
 *
 * Spezielle Einstellungen des Users
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Preference
{
	private var ID:Number;
	/**
	 *
	 * Sprache (zunächst nicht genutzt bzw. Default deutsch)
	 */
	private var language:String;
	/**
	 *
	 * Zustimmmung zur Speicherung und Verwendung der Daten zu Marketingzwecken.
	 */
	private var optin:Boolean;
	/**
	 *
	 * Zustimmung, einen Newsletter zu erhalten
	 */
	private var newsletter:Boolean;
	/**
	 *
	 * Zustimmung, per E-Mail über Herausforderungen und Siegerehrungen informiert zu werden
	 */
	private var receiveemail:Boolean;
	/**
	 *
	 * Zustimmung, ob die eigene E-Mail-Adresse anderen Usern angezeigt werden darf
	 */
	private var showemail:Boolean;

	public function Preference()
	{
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Preference", Preference);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setLanguage(language:String):Void
	{
		this.language = language;
	}

	public function getLanguage():String
	{
		return this.language;
	}

	public function setOptin(optin:Boolean):Void
	{
		this.optin = optin;
	}

	public function isOptin():Boolean
	{
		return this.optin;
	}

	public function setNewsletter(newsletter:Boolean):Void
	{
		this.newsletter = newsletter;
	}

	public function isNewsletter():Boolean
	{
		return this.newsletter;
	}

	public function setReceiveemail(receiveemail:Boolean):Void
	{
		this.receiveemail = receiveemail;
	}

	public function isReceiveemail():Boolean
	{
		return this.receiveemail;
	}

	public function setShowemail(showemail:Boolean):Void
	{
		this.showemail = showemail;
	}

	public function isShowemail():Boolean
	{
		return this.showemail;
	}
}