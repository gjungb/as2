/* Match
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Match
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		23.05.2004
zuletzt bearbeitet:	29.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

class com.adgamewonderland.eplus.soccer.game.Match {

	// Attributes
	
	private var myId:Number;
	
	private var myOpponent:String;
	
	private var myDate:Date;
	
	private var myCity:String;
	
	private var myResult:String; // Matchresult
	
	private var myFirstTipp:Date;
	
	private var myLastTipp:Date;
	
	private var isActive:Boolean;
	
	private var isAllowed:Boolean;
	
	private var myTeam:Team;
	
	// Operations
	
	public  function Match(obj:Object )
	{
		// schleife ueber alle attribute
		for (var i in obj) {
			// speichern
			this[i] = obj[i];
		}
	}
	
	public function set matchid(num:Number ):Void
	{
		myId = Number(num);
	}
	
	public function get id():Number
	{
		return (myId);
	}
	
	public function set opponent(str:String ):Void
	{
		myOpponent = str;
	}
	
	public function get opponent():String
	{
		return (myOpponent);
	}
	
	public function set date(num:Number ):Void
	{
		myDate = new Date(Number(num) * 1000);
	}
	
	public function get date():Date
	{
		return (myDate);
	}
	
	public function set city(str:String ):Void
	{
		myCity = str;
	}
	
	public function get city():String
	{
		return (myCity);
	}
	
	public function set firsttipp(num:Number ):Void
	{
		myFirstTipp = new Date(Number(num) * 1000);
	}
	
	public function get firsttipp():Date
	{
		return (myFirstTipp);
	}
	
	public function set lasttipp(num:Number ):Void
	{
		myLastTipp = new Date(Number(num) * 1000);
	}
	
	public function get lasttipp():Date
	{
		return (myLastTipp);
	}
	
	public function set active(bool:Boolean ):Void
	{
		isActive = new Boolean(bool);
	}
	
	public function get active():Boolean
	{
		return (isActive);
	}
	
	public function set allowed(bool:Boolean ):Void
	{
		isAllowed = new Boolean(bool);
	}
	
	public function get allowed():Boolean
	{
		return (isAllowed);
	}
	
	public function set result(str:String ):Void
	{
		myResult = str;
	}
	
	public function get result():String
	{
		return (myResult);
	}
	
	public function set team(obj:Team ):Void
	{
		myTeam = obj;
	}
	
	public function get team():Team
	{
		return (myTeam);
	}
	
	public function getMatchinfos():Object
	{
		// rueckgabe object
		var infos:Object = {day : "", date : "", time : "", city : "", firsttipp : ""};
		// wochentage
		var weekdays:Array = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"];
		// tag
		infos.day = weekdays[date.getDay()];
		// datum anpfiff
		infos.date = leadingZero(date.getDate()) + "." + leadingZero(date.getMonth() + 1) + "." + date.getFullYear();
		// uhrzeit
		infos.time = leadingZero(date.getHours()) + ":" + leadingZero(date.getMinutes());
		// ort
		infos.city = city;
		// datum tippstart
		infos.firsttippdate = leadingZero(firsttipp.getDate()) + "." + leadingZero(firsttipp.getMonth() + 1) + "." + firsttipp.getFullYear();
		// uhrzeit tippende
		infos.firsttipptime = leadingZero(firsttipp.getHours()) + ":" + leadingZero(firsttipp.getMinutes());
		// zurueck geben
		return (infos);
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

} /* end class Match */
