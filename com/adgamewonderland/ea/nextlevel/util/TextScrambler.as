/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.util.TextScrambler {

	private var field:TextField;

	private var text:String;

	private var loops:Number = 10;

	private var delay:Number = 20;

	private var randomstrings:Array;

	private var counter:Number;

	private var interval:Number;

	public function TextScrambler(field:TextField, text:String ) {
		// textfeld
		this.field = field;
		// anzuzeigender text
		this.text = text;
		// zufaellige strings fuer jedes einzelne zeichen
		this.randomstrings = new Array();
		// zaehler fuer schrittweise anzeige der zufaelligen strings
		this.counter = 0;
	}

	/**
	 * schreibt den text stueck fuer stueck in das textfeld
	 * @param loops anzahl der schleifen, bis ein zeichen final angezeigt wird
	 * @param delay pause [ms] zwischen zwei schleifen
	 */
	public function showScrambledText(loops:Number, delay:Number ):Void
	{
		// anzahl der schleifen
		if (loops != undefined) this.loops = loops;
		// pause zwischen zwei schleifen
		if (delay != undefined) this.delay = delay;
		// zufaellige strings fuer die einzelnen zeichen erzeugen
		createRandomStrings();
		// schrittweise zufaellige strings anzeigen
		this.interval = setInterval(this, "showNextRandomstring", getDelay());
	}

	private function getField():TextField
	{
		return this.field;
	}

	private function getText():String
	{
		return this.text;
	}

	private function getLoops():Number
	{
		return this.loops;
	}

	private function getDelay():Number
	{
		return this.delay;
	}

	private function getCounter():Number
	{
		return this.counter;
	}

	/**
	 * stellt die zufaelligen strings fuer jedes einzelne zeichen als array zusammen
	 */
	private function createRandomStrings():Void
	{
		// zufaellige strings fuer jedes einzelne zeichen
		var strings:Array = new Array(getText().length);
		// text fuers durchschleifen in array splitten
		var tarr:Array = getText().split("");
		// aktuelles zeichen
		var letter:String;
		// schleife ueber alle zeichen
		for (var i : Number = 0; i < tarr.length; i++) {
			// aktuelles zeichen
			letter = tarr[i];
			// zufaelliger string fuer dieses zeichen
			var randomstring:String = getRandomString(letter, i);
			// zum array aller strings hinzufuegen
			strings[i] = randomstring;
		}
		// zeilen und spalten vertauschen
		for (var j : Number = 0; j < randomstring.length; j++) {
			// neue leere zeile
			this.randomstrings[j] = "";
			// schleife ueber alle zufaelligen strings
			for (var k : Number = 0; k < strings.length; k++) {
				// zeichen aus spalte
				letter = String(strings[k]).substr(j, 1);
				// an zeile anfuegen
				this.randomstrings[j] += letter;
			}
		}
	}

	/**
	 * erzeugt einen zufaelligen string zzgl. fuehrender leerzeichen
	 * @param letter letztlich anzuzeigender buchstabe
	 * @param spaces anzahl fuehrender leerzeichen
	 * @return String der zufaellige string
	 */
	private function getRandomString(letter:String, spaces:Number ):String
	{
		// zufaelliger string
		var randomstring:String = "";
		// 1. fuehrende leerzeichen
		for (var i : Number = 0; i < spaces; i++) {
			randomstring += " ";
		}
		// 2. zufaellige zeichen je nach anzahl schleifen
		for (var j : Number = 0; j < getLoops() - 1; j++) {
			// zufallscode (zwischen [space] und ~)
			var rand:Number = " ".charCodeAt(0) + Math.floor(Math.random() * ("~".charCodeAt(0) - " ".charCodeAt(0)));
			randomstring += String.fromCharCode(rand);
		}
		// 3. mit letzlich anzuzeigendem buchstaben auffuellen
		var fill:Number = getText().length + getLoops() - 1 - randomstring.length;
		for (var k : Number = 0; k < fill; k++) {
			randomstring += letter;
		}
		// zurueck geben
		return randomstring;
	}

	/**
	 * zeigt den naechst folgenden zufaelligen text im textfeld an
	 */
	private function showNextRandomstring():Void
	{
		// anzuzeigender zufaelliger string
		var randomstring:String = this.randomstrings[getCounter()];
		// anzeigen
		if (randomstring != undefined) getField().text = randomstring;
		// hochzaehlen und ggf. beenden
		if (++this.counter == this.randomstrings.length) {
			// interval loeschen
			clearInterval(this.interval);
		}
	}


}