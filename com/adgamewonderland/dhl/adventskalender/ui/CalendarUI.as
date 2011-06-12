/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventskalender.beans.*;

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.CalendarUI extends MovieClip {
	
	private static var DAYS_START:Array = [1, 5, 12, 19];
	
	/*
	1.-4. "Santa in Eile"
	5.-11. "Geschenkefänger"
	12.-18. "Snowmans Quiz"
	19.-24. "Crystal Drops"
	*/
	
	private var today:Number;
	
	private var week:Number;
	
	private var gid:Number;
	
	private var navigation_mc:NavigationUI;
	
	private var game_mc:GameUI;
	
	private var highscore_mc:HighscoreUI;
	
	private var win_mc:WinUI;
	
	private var tellafriend_mc:TellafriendUI;
	
	private var instructions_mc:InstructionsUI;
	
	private var requirements_mc:RequirementsUI;
	
	private var prices_mc:PricesUI;
	
	private var days_mc:DaysUI;
	
	public function CalendarUI() {
		// global bekannt machen
		_global.CalendarUI = this;
		
		// tag im dezember
		today = 0;
		// gid
		gid = 1;
		
		// aktuelles datum
		var now:Date = new Date();
		// von aussen uebergebene timestamp
		var timestamp:Number = _root.ts;
		// neues datum
		if (timestamp != undefined) {
			now.setTime(timestamp * 1000);
		}
		// tag im dezember
		setToday(now.getDate());
		// aktuelle woche
		setWeek(getWeekByDay(getToday()));
	}
	
	public function startGame(day:Number ):Void
	{
		// spiel der woche des uebergebenen tages
		setGid(getWeekByDay(day));
		// zum spiel
		showGame();
		// wochenpreis der aktuellen woche anzeigen
		prices_mc.showPrice(getWeek());
		// spiel der woche des uebergebenen tages anzeigen
		game_mc.showGame(getGid());
	}
	
	public function showCalendar():Void
	{
		// tuerchen aktivieren
		days_mc.setDaysEnabled(true);
		// navigation aktivieren
		navigation_mc.showNavigation(true);
		// wochenpreis ausblenden
		prices_mc.hidePrice();
		// zum kalender
		gotoAndStop("frCalendar");
	}
	
	public function showGame():Void
	{
		// tuerchen deaktivieren
		days_mc.setDaysEnabled(false);
		// navigation deaktivieren
		navigation_mc.showNavigation(false);
		// zum spiel
		gotoAndStop("frGame");
	}
	
	public function showHighscore(game:Game, points:Number ):Void
	{
		// tuerchen deaktivieren
		days_mc.setDaysEnabled(false);
		// navigation deaktivieren
		navigation_mc.showNavigation(false);
		// wochenpreis ausblenden
		prices_mc.hidePrice();
		// zum highscore
		gotoAndStop("frHighscore");
		// formular anzeigen lassen
		highscore_mc.showInput(game, points);
	}
	
	public function showWin():Void
	{
		// tuerchen deaktivieren
		days_mc.setDaysEnabled(false);
		// navigation deaktivieren
		navigation_mc.showNavigation(false);
		// wochenpreis ausblenden
		prices_mc.hidePrice();
		// zum gewinnformular
		gotoAndStop("frWin");
	}
	
	public function showInstructions():Void
	{
		// tuerchen deaktivieren
		days_mc.setDaysEnabled(false);
		// instructions anzeigen lassen
		instructions_mc.showInstructions();
	}
	
	public function showRequirements():Void
	{
		// tuerchen deaktivieren
		days_mc.setDaysEnabled(false);
		// teilnahmebedingungen anzeigen lassen
		requirements_mc.showRequirements();
	}
	
	public function showTellafriend():Void
	{
		gotoAndStop("frTellafriend");
	}
	
	public function getGid():Number {
		return gid;
	}

	public function setGid(gid:Number):Void {
		this.gid = gid;
	}

	public function getToday():Number {
		return today;
	}

	public function setToday(today:Number):Void {
		this.today = today;
	}

	public function getWeek():Number {
		return week;
	}

	public function setWeek(week:Number):Void {
		this.week = week;
	}
	
	private function getWeekByDay(day:Number ):Number
	{
		// gesuchte woche
		var week:Number = 0;
		// woche laut zuordnung (mail herr sebastian v. 28.11.)
		if (day >= DAYS_START[0]) {
			week = 1;
		}
		if (day >= DAYS_START[1]) {
			week = 2;
		}
		if (day >= DAYS_START[2]) {
			week = 3;
		}
		if (day >= DAYS_START[3]) {
			week = 4;
		}
		// zurueck geben
		return week;
	}

}