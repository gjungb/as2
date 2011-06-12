/*
 * Generated by ASDT
*/

import com.adgamewonderland.agw.interfaces.*;

class com.adgamewonderland.agw.util.Timer {

	private static var INTERVAL:Number = 100;

	private var myTimeStart:Number;

	private var myTimeAct:Number;

	private var myTimeEnd:Number;

	private var myTimeUpdate:Number;

	private var myStatus:Boolean;

	private var myConsumers:Array;

	private var myUIs:Array;

	private var myInterval:Number;

	// konstruktor
	public function Timer()
	{
		// startzeit, aktuelle zeit, endzeit
		myTimeStart = myTimeAct = myTimeEnd = 0;
		// zeit des letzten updates
		myTimeUpdate = 0;
		// status (an / aus)
		myStatus = false;
		// registrierte consumer
		myConsumers = [];
		// registrierte user interfaces
		myUIs = [];
	}

	public function set status(bool:Boolean ):Void
	{
		// status (an / aus)
		myStatus = bool;
	}

	public function get status():Boolean
	{
		// status (an / aus)
		return(myStatus);
	}

	public function getPercent():Number
	{
		// prozent vergangene zeit
		return ((myTimeAct - myTimeStart) / (myTimeEnd - myTimeStart) * 100);
	}

	public function getSeconds():Object
	{
		// sekunden (gesamt, vergangen, verbleibend)
		var seconds:Object = {total : 0, gone : 0, left : 0};
		// gesamt
		seconds.total = Math.round((myTimeEnd - myTimeStart) / 1000);
		// vergangen
		seconds.gone =  Math.round((myTimeAct - myTimeStart) / 1000);
		// verbleibend
		seconds.left =  Math.round((myTimeEnd - myTimeAct) / 1000);
		// zurueck geben
		return (seconds);
	}

	public function addConsumer(con:ITimeConsumer ):Void
	{
		// nur eine registrierung
		for (var i:Number = 0; i < myConsumers.length; i++) {
			if (myConsumers[i] == con) return;
		}
		// neuer consumer
		myConsumers.push(con);
	}

	public function addUI(ui:ITimeUI ):Void
	{
		// nur eine registrierung
		for (var i:Number = 0; i < myUIs.length; i++) {
			if (myUIs[i] == ui) return;
		}
		// neues user interface
		myUIs.push(ui);
	}

	public function startTime(duration:Number ):Void
	{
		// startzeit
		myTimeStart = getTimer();
		// endzeit
		myTimeEnd = myTimeStart + duration * 1000;
		// aktuelle zeit
		myTimeAct = myTimeStart;
		// zeit des letzten updates
		myTimeUpdate = getTimer();
		// regelmaessig updaten
		myInterval = setInterval(this, "updateTime", INTERVAL);
	}

	public function addTime(duration:Number ):Void
	{
		// aktuelle zeit  aendern
		myTimeAct += duration * 1000;
		// grenzen testen
		if (myTimeAct < myTimeStart) myTimeAct = myTimeStart;
		if (myTimeAct > myTimeEnd) myTimeAct = myTimeEnd;
	}

	public function stopTime():Void
	{
		// zaehlen beenden
		clearInterval(myInterval);
	}

	public static function getFormattedTime(snum:Number, separator:String ):String
	{
		// sekunden in stunden
		var hours:Number = snum / 3600;
		// dezimale minuten in minuten
		var minutes:Number = Math.floor((hours - Math.floor(hours)) * 60);
		// bei 60 minuten korrigieren
		if (minutes == 60) {
			// minuten auf 0
			minutes = 0;
			// stunden eine mehr
			hours += 1;
		}
		// stunden abrunden
		hours = Math.floor(hours);
		// verbleibende sekunden
		var seconds:Number = snum - (hours * 3600 + minutes * 60);
		// als string mit fuehrenden nullen zurueck geben
		return (leadingZero(hours) + separator + leadingZero(minutes) + separator + leadingZero(seconds));
	}

	private function updateTime():Void
	{
		// zeit seit start swf
		var now:Number = getTimer();
		// vergangene zeit seit letztem update
		var interval:Number = now - myTimeUpdate;
		// zeit des letzten updates
		myTimeUpdate = now;

		// je nach status
		switch (status) {
			// zeit laueft nicht
			case false :
				// startzeit verschieben
				myTimeStart += interval;
				// endzeit verschieben
				myTimeEnd += interval;

				break;
			// zeit laueft
			case true :

				break;
		}
		// aktuelle zeit verschieben
		myTimeAct += interval;
		// user interfaces updaten
		for (var i:Number = 0; i < myUIs.length; i++) {
			myUIs[i].showTime(this);
		}
		// testen, ob zeit abgelaufen
		if (myTimeAct >= myTimeEnd) {
			// zaehlen beenden
			stopTime();
			// consumer benachrichtigen
			for (var j:String in myConsumers) myConsumers[j].onTimeEnded();
		}
	}

	private static function leadingZero(num:Number ):String
	{
		// in string umwandeln
		var str:String = num.toString();
		// falls kuerzer als zwei zeichen
		if (str.length < 2) {
			// nullen vorne dran
			str = "0" + str;
		}
		// zurueck geben
		return (str);
	}


}