/*
klasse:			SoundPlayer
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		02.03.2005
zuletzt bearbeitet:	03.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.util.SoundPlayer {

	private var mySound:Sound;

	private var myFrequency:Number;

	private var myInterval:Number;

	private var myPauses:Array;

	private var myCounter:Number;

	public function SoundPlayer(snd:String, freq:Number )
	{
		// sound object
		mySound = new Sound();
		// sound attachen
		mySound.attachSound(snd);
		// frequenz [1 / min], mit der der sound abgespielt werden soll
		myFrequency = freq;
		// alle pausen zwischen den einzelnen sounds innerhalb einer minute
		myPauses = [];
		// zaehler fuer einzelne sounds innerhalb einer minute
		myCounter = myFrequency;
	}

	public function startSound():Void
	{
		// frequenz 0 bedeutet, sound loopen
		if (myFrequency == 0) {
			// loopen
			mySound.start(0, 9999);
			// abbrechen
			return;
		}
		// pausen berechnen
		myPauses = calculatePauses();
		// zaehler fuer einzelne sounds innerhalb einer minute
		myCounter = myFrequency;
		// nach pause abspielen
		myInterval = setInterval(this, "playSound", myPauses[--myCounter], 1);
	}

	public function stopSound():Void
	{
		// sound stoppen
		mySound.setPosition(0);
		mySound.stop();
		// interval loeschen
		clearInterval(myInterval);
	}

	private function calculatePauses():Array
	{
		// summe aller pausen mussen 60 (eine minute) ergeben
		var sum:Number = 60;
		// alle pausen zwischen den einzelnen sounds innerhalb einer minute
		var pauses:Array = [];
		// aktuelle pause
		var pause:Number;
		// schleife ueber anzahl sounds je minute
		for (var i:Number = 0; i < myFrequency; i++) {
			// pause bis zum naechsten abspielen
			pause = 60 / myFrequency;
			// zufaellig verkuerzen / verlaengern
			pause *= (1 + Math.random() / 2);
			// speichern
			pauses[i] = pause * 1000;
			// summe vermindern
			sum -= pause;
		}
		// ueber / unterschuss, so dass als summe 60 rauskommt
		var pdiff:Number = sum / pauses.length;
		// alle pausen korrigieren
		for (var j:String in pauses) pauses[j] += pdiff * 1000;
		// zurueck geben
		return pauses;
	}

	private function playSound(count:Number ):Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// abspielen
		mySound.start(0, count);
		// wenn alle sounds einer minute durch, neu starten
		if (myCounter <= 0) {
			// neu starten
			startSound();
		} else {
			// pause
			var pause:Number = myPauses[--myCounter];
			// nach pause wieder abspielen
			myInterval = setInterval(this, "playSound", pause, 1);
		}
	}
}