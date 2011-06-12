/* Clock
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Clock
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			n24
erstellung: 		23.05.2004
zuletzt bearbeitet:	24.11.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.n24.christmas.*;

class com.adgamewonderland.n24.christmas.Clock extends MovieClip {

	// Attributes
	
	private var myDate:Date, myWeekdays:Array, myTime:Number, myStartTime:Number;
	
	private var myRound:Object;
	
	private var day_txt:TextField, date_txt:TextField, time_txt:TextField, round_txt:TextField;
	
	// Operations
	
	public  function Clock()
	{
		// aktuelles datum
		myDate = new Date();
		// zeit
		myTime = myStartTime = myDate.getTime();
		// wochentage
		myWeekdays = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"];
		
		// runde (aktuell, maximal, timestamp ende)
		myRound = {act : 0, max : 0, end : 0};
		// initialisieren
// 		initClock(_global.myPlayground.user.timestamp);
	}
	
	public function get time():Number
	{
		// aktuelle zeit zurueck geben
		return(myDate.getTime());
	}
	
	public function get date():Date
	{
		// aktuelles datum zurueck geben
		return(myDate);
	}
	
	public  function set round(obj:Object ):Void
	{
		// round
		myRound = obj;
	}
	
	public  function get round():Object
	{
		// round
		return (myRound);
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
	
	public function initRound(actround:Number, maxround:Number, endround:Number ):Void
	{
		// aktuelle runde
		myRound.act = actround;
		// maximale runde
		myRound.max = maxround;
		// timestamp ende der runde (server sendet sekunden, flash arbeitet mit millisekunden)
		myRound.end = endround * 1000;
		// regelmaessig anzeigen
		setInterval(this, "showRound", 500);
	}
	
	private function showClock():Void
	{
		// zeit aktualisieren
		myDate.setTime(myTime + (getTimer() - myStartTime));
		// tag
		day_txt.autoSize = "right";
		day_txt.text = myWeekdays[myDate.getDay()];
		// datum
		date_txt.autoSize = "left";
		date_txt.text = leadingZero(myDate.getDate()) + "." + leadingZero(myDate.getMonth() + 1) + "." + myDate.getFullYear();
		// uhrzeit
		time_txt.autoSize = "left";
		time_txt.text = leadingZero(myDate.getHours()) + ":" + leadingZero(myDate.getMinutes()) + ":"  + leadingZero(myDate.getSeconds());
	}
	
	private function showRound():Void
	{
		// zeit bis zum rundenende
		var timetoend:Number = myRound.end - time;
		//  umrechnen in stunden und minuten
		var formattedtime:Object = getFormattedTime(timetoend);
		// rundenanzeige zusammen setzen
		round_txt.autoSize = "left";
		round_txt.text = "Runde " + myRound.act + " / " + myRound.max + " (noch " + formattedtime.hours + ":" + formattedtime.minutes + ")";
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
	
	private function getFormattedTime(seconds:Number ):Object
	{
		// millisekunden in stunden
		var hours:Number = seconds / 1000 / 3600;
		// dezimale minuten in minuten
		var minutes:Number = Math.ceil((hours - Math.floor(hours)) * 60);
		// bei 60 minuten korrigieren
		if (minutes == 60) {
			// minuten auf 0
			minutes = 0;
			// stunden eine mehr
			hours += 1;
		}
		// als object zurueck geben
		return ({hours : leadingZero(Math.floor(hours)), minutes : leadingZero(minutes)});
	}

} /* end class Clock */
