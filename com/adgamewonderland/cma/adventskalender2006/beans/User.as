/**
 * ein Teilnehmer */
class com.adgamewonderland.cma.adventskalender2006.beans.User 
{
	private var type:String = "GSE";
	private var vname:String;
	private var name:String;
	private var email:String;
	private var strasse:String;
	private var plz:String;
	private var ort:String;
	private var teilnahme:Boolean = false;
	private var datenschutz:Boolean = false;
	private var newsletter:Boolean = false;

	public function User()
	{
		this.vname = "";
		this.name = "";
		this.email = "";
		this.strasse = "";
		this.plz = "";
		this.ort = "";
	}
	
	/**
	 * Ermittelt, ob die Userdaten vollständig und korrekt sind
	 * @return sind Userdaten vollständig und korrekt	 */
	public function isValid():Boolean
	{
		// korrekt oder nicht
		var valid:Boolean = true;
		// pflichtfelder
		if (getVname().length == 0)
			return false;
		if (getName().length == 0)
			return false;
		if (checkEmail(getEmail()) == false)
			return false;
		if (getStrasse().length == 0)
			return false;
		if (getPlz().length != 5)
			return false;
		if (getOrt().length == 0)
			return false;
		// checkboxen
		if (isTeilnahme() == false)
			return false;
		if (isDatenschutz() == false)
			return false;
		
		// zurueck geben
		return valid;
	}

	public function setVname(vname:String):Void
	{
		this.vname = vname;
	}

	public function getVname():String
	{
		return this.vname;
	}

	public function setName(name:String):Void
	{
		this.name = name;
	}

	public function getName():String
	{
		return this.name;
	}

	public function setEmail(email:String):Void
	{
		this.email = email;
	}

	public function getEmail():String
	{
		return this.email;
	}

	public function setStrasse(strasse:String):Void
	{
		this.strasse = strasse;
	}

	public function getStrasse():String
	{
		return this.strasse;
	}

	public function setPlz(plz:String):Void
	{
		this.plz = plz;
	}

	public function getPlz():String
	{
		return this.plz;
	}

	public function setOrt(ort:String):Void
	{
		this.ort = ort;
	}

	public function getOrt():String
	{
		return this.ort;
	}

	public function setTeilnahme(teilnahme:Boolean):Void
	{
		this.teilnahme = teilnahme;
	}

	public function isTeilnahme():Boolean
	{
		return this.teilnahme;
	}

	public function setDatenschutz(datenschutz:Boolean):Void
	{
		this.datenschutz = datenschutz;
	}

	public function isDatenschutz():Boolean
	{
		return this.datenschutz;
	}

	public function setNewsletter(newsletter:Boolean):Void
	{
		this.newsletter = newsletter;
	}

	public function isNewsletter():Boolean
	{
		return this.newsletter;
	}
	
	public function toString():String {
		return "User: " + getVname() + " " + getName();
	}
	
	/**
	 * prüft ob Variable syntaktisch korrekte E-Mail Adresse ist
	 * @param email zu prüfende E-Mail Adresse
	 * @return handelt es sich um eine syntaktisch korrekte E-Mail Adresse	 */
	private function checkEmail(email:String):Boolean
	{
		// testen, ob leer
		if (email.length == 0) return(false);
		// testen, ob leerzeichen drin
		if (email.indexOf(" ") != -1) return(false);
		// testen, ob genau ein @ drin ist (erstes auftreten gleich letztem auftreten und nicht -1)
		var ok = (email.indexOf("@") == email.lastIndexOf("@") && email.indexOf("@") != -1);
		if (!ok) return (false);
		// position des @
		var at = email.indexOf("@");
		// links vom @
		var string1 = email.substring(0, at);
		// rechts vom @
		var tmp = email.substring(at+1, email.length);
		// position des ersten . rechts vom @
		var punkt = tmp.indexOf(".");
		var string2 = tmp.substring(0, punkt);
		var string3 = tmp.substring(punkt+1, tmp.length);
	
		// test der laenge der strings
		var ok = !(string1.length < 1 || string2.length < 1 || string3.length < 2);
		if (!ok) return (false);
	
		// test, ob zeichen in string1 ok ("A"-"Z", "a"-"z", "0"-"9", "_", ".", "-")
		for (var i=0; i < string1.length; i++) {
			var ascii = string1.charCodeAt(i);
			var ok =  ((ascii>=65 && ascii<=90) || (ascii>=97 && ascii<=122) || (ascii>=48 && ascii<=57) || ascii==95 || ascii==45 || ascii==46);
			if (!ok) return (false);
		}
	
		// test, ob zeichen in string2 ok (alles erlaubt ausser ".")
		var ok = (string2.indexOf(".") == -1);
		if (!ok) return (false);
	
		// test, ob zeichen in string3 ok ("A"-"Z", "a"-"z", ".", "-")
		for (var i=0; i < string3.length; i++) {
			var ascii = string3.charCodeAt(i);
			var ok = ((ascii>=65 && ascii<=90) || (ascii>=97 && ascii<=122) || ascii==45 || ascii==46);
			if (!ok) return (false);
		}
	
		// alles in ordnung
		return (true);
	}
}