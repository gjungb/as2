/* Clock
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Clock
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		23.05.2004
zuletzt bearbeitet:	01.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

class com.adgamewonderland.eplus.soccer.game.Clock extends MovieClip {

	// Attributes
	
	private var myDate:Date, myWeekdays:Array, myTime:Number, myStartTime:Number;
	
	private var day_txt:TextField, date_txt:TextField, time_txt:TextField;
	
	// Operations
	
	public  function Clock()
	{
		// aktuelles datum
		myDate = new Date();
		// zeit
		myTime = myStartTime = myDate.getTime();
		// wochentage
		myWeekdays = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"];
		// initialisieren
		initClock(_global.Game.user.timestamp);
	}
	
	public function initClock(time:Number ):Void
	{
		// uebergebene timestamp als startzeit merken (server sendet sekunden, flash arbeitet mit millisekunden)
		myTime = time * 1000;
		// flash interne startzeit
		myStartTime = getTimer();
		// auf uebergebene zeit setzen
		myDate.setTime(myTime);
		// regelmaessig anzeigen
		setInterval(this, "showClock", 500);
	}
	
	private function showClock():Void
	{
		// zeit aktualisieren
		myDate.setTime(myTime + (getTimer() - myStartTime));
		// tag
		day_txt.autoSize = "left";
		day_txt.text = myWeekdays[myDate.getDay()];
		// datum
		date_txt.autoSize = "left";
		date_txt.text = leadingZero(myDate.getDate()) + "." + leadingZero(myDate.getMonth() + 1) + "." + myDate.getFullYear();
		// uhrzeit
		time_txt.autoSize = "left";
		time_txt.text = leadingZero(myDate.getHours()) + ":" + leadingZero(myDate.getMinutes()) + ":"  + leadingZero(myDate.getSeconds());
	}
	
	public function get time():Number
	{
		// aktuelle zeit zurueck geben
		return(myDate.getTime());
	}
	
	private function leadingZero(num:Number ):String
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

} /* end class Clock */
