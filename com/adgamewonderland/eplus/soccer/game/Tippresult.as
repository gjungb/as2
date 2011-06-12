/* Tippresult
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Tippresult
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		28.05.2004
zuletzt bearbeitet:	02.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.*;

class com.adgamewonderland.eplus.soccer.game.Tippresult extends MovieClip {

	// Attributes
	
	private var myUser:User;
	
	private var myMatch:Match;
	
	private var myXMLConnector:XMLConnector;
	
	private var myScore:Number, myResult:String;
	
	private var isActive:Boolean;
	
	private var myButtons:Array;
	
	private var teamlist1_mc:MovieClip, teamlist2_mc:MovieClip, matchlistitem_mc:MovieClip, back_mc:MovieClip, print_mc:MovieClip;
	
	private var score_txt:TextField, headline_txt:TextField, day_txt:TextField, date_txt:TextField, time_txt:TextField, city_txt:TextField;
	
	// Operations
	
	public function Tippresult()
	{
		// global ansprechbar
		_global.Tippresult = this;
		// user, der eingeloggt ist
		myUser = _global.Game.user;
		// match, fuer das der tipp angezeigt wird
		myMatch = _global.Game.match;
		// xml connector
		myXMLConnector = new XMLConnector(this, _global.scriptPath);
		// punktzahl des users fuer dieses match
		myScore = 0;
		// endergebnis fuer dieses match
		myResult = "";
		
		// buttons initialisieren
		initButtons();
		// headline ausblenden
// 		headline_txt._visible = false;
		// rechte teamliste ausblenden
		teamlist2_mc._visible = false;
		
		// warten, bis teamlists geladen
		this.onEnterFrame = function () {
			// testen, ob geladen
			if (teamlist1_mc.loaded == true && teamlist2_mc.loaded == true) {
				// verfolgen beenden
				delete(this.onEnterFrame);
				// tipp des users laden (sobald geladen, wird ergebnis des tatsaechlichen match geladen)
				loadPlayers("tipp");
			}
		}
	}
	
	private function initButtons():Void
	{
		// array mit buttons
		myButtons = [back_mc, print_mc];
		// callback bei klick auf "zurueck"
		back_mc.onRelease = function () {
			// tipp abbrechen
			this._parent.cancelTippresult();
		}
		// callback bei klick auf "drucken"
		print_mc.onRelease = function () {
			// tipp drucken
			this._parent.printTippresult();
		}
		// aktivieren
		active = true;
	}
	
	public function cancelTippresult():Void
	{
		// zum auswahlscreen
		_global.Game.jumpNavi("Main");
	}
	
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet umschalten
		isActive = bool;
		// buttons de- / aktivieren
		for (var i in myButtons) {
			myButtons[i].enabled = bool;
		}
	}
	
	private function loadPlayers(type:String ):Void
	{
		// je nach type
		switch (type) {
			// tipp des users
			case "tipp" :
				// obj
				var obj:String = "tippresultProcessor";
				// callback
				var callback:String = "onTippPlayersLoaded";
				// infos ueber user
				var node:XMLNode = myXMLConnector.getXMLNode("user", {userid : myUser.userid, matchid : myMatch.id});
				
				break;
			// tatsaechlich im match
			case "match" :
				// obj
				var obj:String = "gameresultProcessor";
				// callback
				var callback:String = "onMatchPlayersLoaded";
				// infos ueber match
				var node:XMLNode = myXMLConnector.getXMLNode("game", {matchid : myMatch.id});
			
				break;
		}
		// xml head
		var head:XML = myXMLConnector.getXMLHead("eplussoccer", {obj:obj});
		// einhaengen
		head.firstChild.appendChild(node);
		// senden und empfangen
		myXMLConnector.sendXML(head, callback);
	}
	
	public  function onTippPlayersLoaded(xmlobj:XML ):Void 
	{
		// punktzahl des users fuer dieses match
		myScore = xmlobj.firstChild.firstChild.attributes["score"];
		// schon punkte bekommen
		if (myScore > 0) {
			// anzeigen
			score_txt.autoSize = "center";
			score_txt.multiline = true;
			score_txt.html = true;
			score_txt.htmlText = "<P ALIGN=\"center\">Ihre Punktzahl<BR><B>" + myScore + "</B></P>";
		}
		
		// infos ueber players
		var players:Array = xmlobj.firstChild.firstChild.childNodes;
		// schleife ueber alle players
		for (var i = 0; i < players.length; i++) {
			// in object umformen
			var info:Object = myXMLConnector.parseXMLNode(players[i]);
			// playerid
			var playerid:Number = Number(info["playerid"]);
			// teamlistitem, das diesen spieler darstellt
			var item:MovieClip = teamlist1_mc.getItem(playerid);
			// ausgewaehlt
			item.selected = true;
			// topspieler
			item.showCross("top", info["top"] == "1");
			// bad guy
			item.showCross("bad", info["bad"] == "1");
			// einwechsler
			item.showCross("exchange", info["startplayer"] == "0");
		}
		// ergebnis des tatsaechlichen match laden
		loadPlayers("match");
	}
	
	public  function onMatchPlayersLoaded(xmlobj:XML ):Void 
	{
		// endergebnis fuer dieses match
		myResult = xmlobj.firstChild.firstChild.attributes["result"];
		// je nachdem, ob ergebnis fest steht
		switch (myResult != "0") {
			// ergebnis steht fest
			case true:
				// ergebnis anzeigen
				matchlistitem_mc.showResult(myResult);
				// rechte teamliste einblenden
				teamlist2_mc._visible = true;
				// infos ueber players
				var players:Array = xmlobj.firstChild.firstChild.childNodes;
				// schleife ueber alle players
				for (var i = 0; i < players.length; i++) {
					// in object umformen
					var info:Object = myXMLConnector.parseXMLNode(players[i]);
					// playerid
					var playerid:Number = Number(info["playerid"]);
					// teamlistitem, das diesen spieler darstellt
					var item:MovieClip = teamlist2_mc.getItem(playerid);
					// ausgewaehlt
					item.selected = true;
					// topspieler
					item.showCross("top", info["top"] == "1");
					// bad guy
					item.showCross("bad", info["bad"] == "1");
					// einwechsler
					item.showCross("exchange", info["startplayer"] == "0");
				}
			
				break;
				
			// ergebnis steht noch nicht fest
			case false:
				// headline einblenden
				headline_txt._visible = true;
				// infos ueber spiel
				var infos:Object = myMatch.getMatchinfos();
				// anzeigen
				for (var i in infos) {
					// aktuelle info
					var info:String = infos[i];
					// ausrichten
					this[i + "_txt"].autoSize = "left";
					// anzeigen
					this[i + "_txt"].text = info;
				}
				
				break;
		}
	}
	
	public function printTippresult():Void
	{
		// drucken
		print (this, "bmovie");
	}

} /* end class Tippresult */
