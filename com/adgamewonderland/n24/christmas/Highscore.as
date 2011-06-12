/* Highscore
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Highscore
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			n24
erstellung: 		21.04.2004 (e-plus)
zuletzt bearbeitet:	25.11.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.*;

class com.adgamewonderland.n24.christmas.Highscore extends MovieClip {

	// Attributes
	
	private var _myFile:String; // konfigurationsdatei
	
	private var myXMLConnector:XMLConnector;
	
	private var myPeriod:Object; // periode, innerhalb der die spiele online sind (gamestart, gameend, daynow, daystart, dayend)
	
	private var myMode:String; // modus, in dem die liste angezeigt wird (day, week, total, winner)
	
	private var myHeadlines:Object; // ueberschriften
	
	private var myPosition:Object; // angezeigte positionen (start, count, end)
	
	private var myButtons:Array;
	
	private var list_mc:MovieClip, dropdown_mc:MovieClip;
	
	private var day_btn:Button, week_btn:Button, total_btn:Button, winner_btn:Button, prev_btn:Button, next_btn:Button;
	
	private var headline_txt:TextField, position_txt:TextField;
	
	// Operations
	
	public  function Highscore()
	{
		// konfigurationsdatei
		_myFile = "n24_christmas_xmlconnector.php";
		// zum testen pfad angeben
		if (_url.indexOf("http://") == -1) _myFile = "http://192.168.0.27/kunden/n24/weihnachtsspiel/game/" +  _myFile;
		// xml connector
		myXMLConnector = new XMLConnector(this, _myFile);
		// periode, innerhalb der die spiele online sind (gamestart, gameend, daystart, dayend, daynow)
		myPeriod = {gamestart : new Date(2005, 11, 1), gameend : new Date(2005, 11, 24), daynow : new Date(), daystart : new Date(), dayend : new Date()};
		// modus, in dem die liste angezeigt wird (day, week, total, winner)
		myMode = "";
		// ueberschriften
		myHeadlines = {day : "Tages-Highscore", week : "Wochen-Highscore", total : "Gesamt-Highscore", winner : "Die Gewinner"};
		// angezeigte positionen (start, count)
		myPosition = {start : 1, count : 15, end : 15};
		// buttons
		myButtons = [day_btn, week_btn, total_btn, winner_btn, prev_btn, next_btn];
		// buttons initialisieren
		initButtons();
	}
	
	public  function set mode(str:String ):Void
	{
		// mode
		myMode = str;
		// ueberschrift anzeigen
		headline_txt.autoSize = "left";
		headline_txt.text = myHeadlines[str];
	}
	
	public  function get mode():String
	{
		// mode
		return (myMode);
	}
	
	public  function set period(obj:Object ):Void
	{
		// period
		myPeriod = obj;
	}
	
	public  function get period():Object
	{
		// period
		return (myPeriod);
	}
	
	public  function set position(obj:Object ):Void
	{
		// position
		myPosition = obj;
	}
	
	public  function get position():Object
	{
		// position
		return (myPosition);
	}
	
	public function initHighscore(gamestart:Number, gameend:Number, daynow:Number ):Void
	{
		// testen, ob gueltige werte
		if (typeof gamestart == "number" && typeof gameend == "number" && typeof daynow == "number") {
			// erster tag der schaltung der spiele
			period.gamestart = new Date(gamestart * 1000);
			// letzter tag der schaltung der spiele
			period.gameend = new Date(gameend * 1000);
			// heuiger tag
			period.daynow = new Date(daynow * 1000);
		}
		// modus aktualisieren, liste laden
		changeMode("day");
	}
	
	public function changeMode(modestr:String ):Void
	{
		// abbrechen, wenn nicht veraendert
		if (modestr == mode) return;
		// neuen wert speichern
		mode = modestr;
		// anzeigeperiode aktualisieren
		changePeriod(period.daynow);
		// dropdown aktualisieren
		changeDropdown(modestr);
	}
	
	public function changePeriod(day:Date ):Void
	{
		// erster / letzter tag in liste als datum
		var liststart:Date, listend:Date;
		// erster / letzter tag in liste als string
		var daystart:String, dayend:String;
		// millisekunden je tag
		var ms:Number = 24 * 60 * 60 * 1000;
	
		// je nach aktuellem modus
		switch (mode) {
			// tag
			case "day" :
				// erster tag in liste (heute)
				liststart = day; 
				// letzter tag in liste (morgen)
				listend = new Date(day.getTime() + 1 * ms);
			
				break;
			// woche
			case "week" :
				// wochentag des uebergebenen tages
				var weekday:Number = day.getDay();
				// wie viele tage seit anfang der woche
				var daysgone:Number = (weekday == 0 ? 6 : weekday - 1);
				// wie viele tage noch bis ende der woche
				var daysleft:Number = (weekday == 0 ? 0 : 7 - weekday);
				// erster tag in liste (am anfang der woche)
				liststart = new Date(day.getTime() - daysgone * ms);
				// letzter tag in liste (am ende der woche)
				listend = new Date(day.getTime() + daysleft * ms);
			
				break;
// 			// total
// 			case "total" :
// 				// erster spieltag
// 				liststart = period.gamestart;
// 				// letzter spieltag
// 				listend = period.gameend;
// 			
// 				break;
			// total oder winner
			default :
				// erster spieltag
				liststart = period.gamestart;
				// letzter spieltag
				listend = period.gameend;
		}
		// in strings umwandeln und speichern
		period.daystart = liststart.getFullYear() + "-" + (liststart.getMonth() + 1) + "-" + liststart.getDate();
		period.dayend = listend.getFullYear() + "-" + (listend.getMonth() + 1) + "-" + listend.getDate();
		// ganz nach links
		changePosition(0);
	}
	
	public function changePosition(dir:Number ):Void
	{
		// je nach richtung
		switch (dir) {
			// ganz nach links
			case 0 :
				// start auf 1
				position.start = 1;
				// ende auf count
				position.end = position.count;
			
				break;
			// nach links
			case -1 :
				// testen, ob erlaubt
				if (position.start - position.count > 0) position.start -= position.count;
			
				break;
			// nach rechts
			case 1 : 
				// testen, ob erlaubt
				if (position.start + position.count <= position.end) position.start += position.count;
			
				break;
		}
		// liste loeschen
		clearList();
		// je nach modus
		switch (mode) {
			// winner
			case "winner" :
				// liste laden
				loadWinner();
				
				break;
			// day, week, total
			default :
				// liste laden
				loadHighscore();
		}
	}
	
	private function changeDropdown(modestr:String ):Void
	{
		// dropdown einklappen
		dropdown_mc.showItems(false);
		// callback
		var callback:String = "changePeriod";
		// ydiff
		var ydiff:Number = -18;
		// millisekunden je tag
		var ms:Number = 24 * 60 * 60 * 1000;
		// je nach modus
		switch (mode) {
			// day
			case "day" :
				// name des dropdown
				var name:String = "Tag";
				// sichtbare items im dropdown
				var items:Array = [];
				// unsichtbare werte im dropdown
				var values:Array = [];
				// tag des spielstarts
				var day:Date = new Date(period.gamestart.getTime());
				// tage seit start des spiels bis heute hochzaehlen
				for (var days:Number = 0; day.getTime() < period.daynow.getTime() - ms; days++) {
					// neuer tag
					day = new Date(period.gamestart.getTime() + days * ms);
					// datum des tages als string
					items.push(day.getDate() + "." + (day.getMonth() + 1) + ".");
					// datum des tages als date
					values.push(day);
				}
				// dropdown aufbauen
				dropdown_mc.initDropdown(name, items, values, callback, ydiff);
				// einblenden
				dropdown_mc._visible = true;
				
				break;
			// week
			case "week" :
				// name des dropdown
				var name:String = "Woche";
				// sichtbare items im dropdown
				var items:Array = [];
				// unsichtbare werte im dropdown
				var values:Array = [];
				// tag des spielstarts
				var day:Date = new Date(period.gamestart.getTime());
				// tage seit start des spiels bis heute hochzaehlen
				for (var days:Number = 0; day.getTime() < period.daynow.getTime() - ms; days+=7) {
					// neuer tag
					day = new Date(period.gamestart.getTime() + days * ms);
					// nummer der als string
					items.push(days / 7 + 1 + ". Woche");
					// datum des ersten wochentages als date
					values.push(day);
				}
				// dropdown aufbauen
				dropdown_mc.initDropdown(name, items, values, callback, ydiff);
			
				// ausblenden
				dropdown_mc._visible = true;
				
				break;
			// total, winner
			default :
				// ausblenden
				dropdown_mc._visible = false;
		}
	}
	
	private function loadHighscore():Void
	{
		// xml head
		var head:XML = myXMLConnector.getXMLHead("n24_christmas", {obj:"highscoreProcessor"});
		// infos ueber 
		var node:XMLNode = myXMLConnector.getXMLNode("highscore", {daystart : period.daystart, dayend : period.dayend, positionstart : position.start, positioncount : position.count});
		// einhaengen
		head.firstChild.appendChild(node);
		// senden und empfangen
		myXMLConnector.sendXML(head, "onHighscoreLoaded");
	}
	
	public  function onHighscoreLoaded(xmlobj:XML ):Void
	{
		// array, das highscoredaten der user aufnimmt
		var highscore:Array = [];
		// maximale anzahl in dieser liste
		position.end = xmlobj.firstChild.firstChild.attributes["end"];
		// navi updaten
		updateNavi();
		// positionen anzeige updaten
		updatePosition();
		// infos ueber users
		var users:Array = xmlobj.firstChild.firstChild.childNodes;
		// schleife ueber alle user
		for (var i in users) {
			// in object umformen
			var user:Object = myXMLConnector.parseXMLNode(users[i]);
			// in array schreiben
			highscore.push(user);
		}
		// rumdrehen
		highscore.reverse();
		// anzeigen
		showHighscore(highscore);
	}
	
	private function showHighscore(highscore:Array ):Void
	{
		// dummy
		var dummy:MovieClip = list_mc.dummy_mc;
		// hoehe des dummy
		var ydiff = dummy._height - 1;
		// schleife ueber alle user
		for (var i = 1; i <= highscore.length; i ++) {
			// aktueller user
			var user:Object = highscore[i - 1];
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy._y + (i - 1) * ydiff;
			// dummy duplizieren
			var pos:MovieClip = dummy.duplicateMovieclip("pos" + i + "_mc", i + 1, constructor);
			// position
			pos.position_txt.autoSize = "right";
			pos.position_txt.text = user.rank + ".";
			// nickname
			pos.nickname_txt.autoSize = "left";
			pos.nickname_txt.text = user.nickname;
			// score
			pos.score_txt.autoSize = "right";
			pos.score_txt.text = user.score;
		}
		// dummy unsichtbar
		dummy._visible = false;
		// werbung neu laden
		showAd("highscore/" + mode, "");
	}
	
	private function loadWinner():Void
	{
		// xml head
		var head:XML = myXMLConnector.getXMLHead("n24_christmas", {obj:"winnerProcessor"});
		// infos ueber 
		var node:XMLNode = myXMLConnector.getXMLNode("winner", {positionstart : position.start, positioncount : position.count});
		// einhaengen
		head.firstChild.appendChild(node);
		// senden und empfangen
		myXMLConnector.sendXML(head, "onWinnerLoaded");
	}
	
	public  function onWinnerLoaded(xmlobj:XML ):Void
	{
		// array, das winnerdaten der user aufnimmt
		var winner:Array = [];
		// maximale anzahl in dieser liste
		position.end = xmlobj.firstChild.firstChild.attributes["end"];
		// navi updaten
		updateNavi();
		// positionen anzeige updaten
		updatePosition();
		// infos ueber users
		var users:Array = xmlobj.firstChild.firstChild.childNodes;
		// schleife ueber alle user
		for (var i in users) {
			// in object umformen
			var user:Object = myXMLConnector.parseXMLNode(users[i]);
			// in array schreiben
			winner.push(user);
		}
		// rumdrehen
		winner.reverse();
		// anzeigen
		showWinner(winner);
	}
	
	private function showWinner(winner:Array ):Void
	{
		// dummy
		var dummy:MovieClip = list_mc.dummy_mc;
		// hoehe des dummy
		var ydiff = dummy._height - 1;
		// schleife ueber alle user
		for (var i = 1; i <= winner.length; i ++) {
			// aktueller user
			var user:Object = winner[i - 1];
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy._y + (i - 1) * ydiff;
			// dummy duplizieren
			var pos:MovieClip = dummy.duplicateMovieclip("pos" + i + "_mc", i + 1, constructor);
			// position
			pos.position_txt.autoSize = "right";
			pos.position_txt.text = user.day;
			// nickname
			pos.nickname_txt.autoSize = "left";
			pos.nickname_txt.text = user.nickname;
			// score
			pos.score_txt.autoSize = "right";
			pos.score_txt.text = user.score + " Punkte";
		}
		// dummy unsichtbar
		dummy._visible = false;
		// werbung neu laden
		showAd("highscore/" + mode, "");
	}
	
	private function clearList():Void
	{
		// zaehler
		var i = 0;
		// schleife ueber alle angezeigten user
		while (list_mc["pos" + (++i) + "_mc"] instanceof MovieClip) list_mc["pos" + i + "_mc"].removeMovieClip();
		// position loeschen
		position_txt.text = "";
	}
	
	private function updateNavi():Void
	{
		// nach links button
		prev_btn._visible = (position.start - position.count > 0);
		// nach rechts button
		next_btn._visible = (position.start + position.count <= position.end);
	}
	
	private function updatePosition():Void
	{
		// position anzeigen
		position_txt.autoSize = "left";
		position_txt.text = "Platz " + position.start + " - " + (position.start + position.count - 1);
	}
	
	private function initButtons():Void
	{
		// tageshighscore button
		day_btn.onRelease = function () {
			this._parent.changeMode("day");
		};
		// wochenhighscore button
		week_btn.onRelease = function () {
			this._parent.changeMode("week");
		};
		// gesamthighscore button
		total_btn.onRelease = function () {
			this._parent.changeMode("total");
		};
		// gewinner button
		winner_btn.onRelease = function () {
			this._parent.changeMode("winner");
		};
		// nach links button
		prev_btn.onRelease = function () {
			this._parent.changePosition(-1);
		};
		// nach rechts button
		next_btn.onRelease = function () {
			this._parent.changePosition(1);
		};
	}
	
	private  function showButtons(bool:Boolean ):Void
	{
		// schleife ueber alle buttons
		for (var i:String in myButtons) myButtons[i].enabled = bool;
	}
	
	// werbung neu laden
	private function showAd(context:String, agof:String):Void
	{
		// abbrechen, wenn nicht online
		if (_url.indexOf("http://") == -1) return;
		// banner an javascript uebergeben
		getUrl("javascript:showContent('banner', '" + context + "', '" + agof + "')", "");
		// skyscraper an javascript uebergeben
// 		getUrl("javascript:showContent('skyscraper', '', '')", "");
	}

} /* end class Highscore */
