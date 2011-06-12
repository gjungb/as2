/* Topteam
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Topteam
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		02.06.2004
zuletzt bearbeitet:	03.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.*;

class com.adgamewonderland.eplus.soccer.game.Topteam extends MovieClip {

	// Attributes
	
	private var myXMLConnector:XMLConnector;
	
	private var isActive:Boolean;
	
	private var myButtons:Array;
	
	private var teamlist_mc:MovieClip, print_mc:MovieClip;
	
	// Operations
	
	public function Topteam()
	{
		// xml connector
		myXMLConnector = new XMLConnector(this, _global.scriptPath);
		
		// buttons initialisieren
		initButtons();
	}
	
	private function initButtons():Void
	{
		// array mit buttons
		myButtons = [print_mc];
		// callback bei klick auf "drucken"
		print_mc.onRelease = function () {
			// topteam drucken
			this._parent.printTopteam();
		}
		// aktivieren
		active = true;
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
	
	public  function showTopteam():Void
	{
		// warten, bis teamlist geladen
		this.onEnterFrame = function () {
			// testen, ob geladen
			if (teamlist_mc.loaded == true) {
				// verfolgen beenden
				delete(this.onEnterFrame);
				// teamlist darf nicht auswaehlbar sein
				teamlist_mc.selectable = false;
				// topteam laden
				loadTopteam();
			}
		}
	}
	
	private function loadTopteam():Void
	{
		// callback
		var callback:String = "onTopteamLoaded";
		// xml head
		var head:XML = myXMLConnector.getXMLHead("eplussoccer", {obj : "topteamProcessor"});
		// senden und empfangen
		myXMLConnector.sendXML(head, callback);
	}
	
	public  function onTopteamLoaded(xmlobj:XML ):Void 
	{
		// array zur aufnahme der spielerinfos (als objects)
		var players:Array = [];
		// infos ueber players
		var nodes:Array = xmlobj.firstChild.firstChild.childNodes;
		// schleife ueber alle players
		for (var i = 0; i < nodes.length; i++) {
			// in object umformen
			var info:Object = myXMLConnector.parseXMLNode(nodes[i]);
			// in zahlen konvertieren
			for (var j in info) info[j] = Number(info[j]);
			// in array schreiben
			players.push(info);
		}
		
		// array fuer 14 spieler, die in startaufstellung oder einwechsler sind
		var team:Array = [];
		
		// torhueter, der am haeufgisten in startelf steht, sowie feldspieler in der reihenfolge der haeufigkeit ihrer nominierung fuer die startelf
		for (var i:Number = 0; i < 11; i ++) {
			// aktueller spieler
			var player:Object = players[i];
			// auswaehlen
			selectPlayer(player);
			// ins team aufnehmen
			team.push(player);
		}
		
		// einwechselspieler (alle, die nicht zur startaufstellung gehoeren)
		var exchangers:Array = players.slice(11);
		// nach haeufigkeit ihrer einwechslung sortieren
		exchangers.sort(sortExchange);
		// die ersten drei
		for (var i:Number = 0; i < 3; i ++) {
			// aktueller spieler
			var player:Object = exchangers[i];
			// auswaehlen
			selectPlayer(player);
			// ankreuzen als einwechsler
			highlightPlayer(player, "exchange");
			// ins team aufnehmen
			team.push(player);
		}
		
		// team nach haeufigkeit der nominierung als topspieler sortieren
		team.sort(sortTop);
		// die ersten drei
		for (var i:Number = 0; i < 3; i ++) {
			// aktueller spieler
			var player:Object = team[i];
			// auswaehlen
			selectPlayer(player);
			// ankreuzen als topspieler
			highlightPlayer(player, "top");
		}
		
		// team nach haeufigkeit der nominierung als bad guy sortieren
		team.sort(sortBad);
		// der erste
		for (var i:Number = 0; i < 1; i ++) {
			// aktueller spieler
			var player:Object = team[i];
			// auswaehlen
			selectPlayer(player);
			// ankreuzen als topspieler
			highlightPlayer(player, "bad");
		}
	}
	
	private function sortExchange(element1, element2):Number
	{
		return(element2["exchange"] - element1["exchange"]);
	}
	
	private function sortTop(element1, element2):Number
	{
		return(element2["top"] - element1["top"]);
	}
	
	private function sortBad(element1, element2):Number
	{
		return(element2["bad"] - element1["bad"]);
	}
	
	private function selectPlayer(player:Object ):Void
	{
		// playerid
		var playerid:Number = Number(player["playerid"]);
		// teamlistitem, das diesen spieler darstellt
		var item:MovieClip = teamlist_mc.getItem(playerid);
		// ausgewaehlt
		item.selected = true;
	}
	
	private function highlightPlayer(player:Object, attr:String ):Void
	{
		// playerid
		var playerid:Number = Number(player["playerid"]);
		// teamlistitem, das diesen spieler darstellt
		var item:MovieClip = teamlist_mc.getItem(playerid);
		// ankreuzen
		item.showCross(attr, true);
	}
	
	public function printTopteam():Void
	{
		// drucken
		print (this, "bmovie");
	}

} /* end class Topteam */
