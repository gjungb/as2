/*
inhalt:			agw formProcessor objekt zur validierung von formularen
autor: 			gerd jungbluth, adgame-wonderland (gerd.jungbluth@adgame-wonderland.de)
kunde:
erstellung: 		12.12.2002
zuletzt bearbeitet:	22.06.2006
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.Formprocessor {

	// Attributes

	public static var TYPE_EMPTY:Number = 1;

	public static var TYPE_PLZ:Number = 2;

	public static var TYPE_EMAIL:Number = 3;

	public static var TYPE_DATE:Number = 4;

	public static var TYPE_TRUE:Number = 5;

	public static var TYPE_NUMBER:Number = 6;

	// Operations

	// methode "checkForm" ueberprueft uebergebenes textfeldArray und gibt fehlerArray zurueck
	public function checkForm(textfelder:Array ):Array
	{
		// array mit fehlerhaften feldern
		var fehlerArray:Array = new Array();
		// array uebernehmen (hat form: art der ueberpruefung, variablennname, variableninhalt aus textfeld)
		var textfeldArray:Array = textfelder;
		// schleife ueber array
		for (var i = 0; i < textfelder.length; i += 3) {
			// typ der gewuenschten ueberpruefung
			var typ:Number = textfelder[i];
			// variablnename
			var name:String = textfelder[i + 1];
			// variableninhalt
			var inhalt = textfelder[i + 2];
			// rueckgabe
			var korrekt:Boolean = false;

			// je nach typ verzweigen
			switch (typ) {
				case TYPE_EMPTY :
					// feld auf leer checken
					korrekt = checkEmpty(inhalt);

					break;

				case TYPE_PLZ :
					// feld auf fuenfstellige postleitzahl checken
					korrekt = checkNumber(inhalt, 5);

					break;

				case TYPE_EMAIL :
					// feld auf syntaktisch korrekte email checken
					korrekt = checkEmail(inhalt);

					break;

				case TYPE_DATE :
					// feld auf korrektes datum testen
					korrekt = checkDate(inhalt);

					break;

				case TYPE_TRUE :
					// feld auf wahrheit testen
					korrekt = inhalt;

					break;

				case TYPE_NUMBER :
					// feld auf gueltige zahl checken
					korrekt = checkNumber(inhalt, inhalt.length);

					break;
			}
			// wenn nicht korrekt, variablennamen in array schrieben
			if (!korrekt) var fehler = fehlerArray.push(name);
		}
		// fehlerArray zurueck geben
		return (fehlerArray);
	}

	// methode "checkEmpty" ueberprueft ob variable leer ist
	private function checkEmpty (wert ):Boolean
	{
		// checken und zurueck geben
		return(wert != "" && wert != undefined);
	}

	// methode "checkNumber" ueberprueft ob variable zahl mit uebergebener zahl an ziffern ist
	private function checkNumber (wert, stellen ):Boolean
	{
		// checken und zurueck geben
		return(!(wert.length != stellen || isNaN(wert)));
	}

	// methode "checkEmail" ueberprueft ob variable syntaktisch korrekte email ist
	private function checkEmail (wert ):Boolean
	{
		// testen, ob nicht leer
		var ok = checkEmpty(wert);
		if (!ok) return (false);
		// testen, ob leerzeichen drin
		if (wert.indexOf(" ") != -1) return(false);
		// testen, ob genau ein @ drin ist (erstes auftreten gleich letztem auftreten und nicht -1)
		var ok = (wert.indexOf("@") == wert.lastIndexOf("@") && wert.indexOf("@") != -1);
		if (!ok) return (false);
		// position des @
		var at = wert.indexOf("@");
		// links vom @
		var string1 = wert.substring(0, at);
		// rechts vom @
		var tmp = wert.substring(at+1, wert.length);
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

	// methode "checkDate" ueberprueft ob variable gueltiges datum im format ttmmjjjj ist
	private function checkDate (wert ):Boolean
	{
		// testen, ob 8-stellige zahl
		var ok = checkNumber(wert, 8);
		if (!ok) return (false);
		// tag sind erste zwei stellen
		var tag = Number(wert.substr(0, 2));
		// testen, ob zwischen 1 und 31
		var ok = (tag >= 1 && tag <= 31);
		if (!ok) return (false);
		// monat sind zweite zwei stellen
		var monat = Number(wert.substr(2, 2));
		// testen, ob zwischen 1 und 12
		var ok = (monat >= 1 && monat <= 12);
		if (!ok) return (false);

		// alles in ordnung
		return (true);
	}

}
