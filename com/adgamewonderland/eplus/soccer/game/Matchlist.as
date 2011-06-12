/* Matchlist
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Matchlist
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		23.05.2004
zuletzt bearbeitet:	24.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.*;

class com.adgamewonderland.eplus.soccer.game.Matchlist extends MovieClip {

	// Attributes
	
	private var myMatches:Array;
	
	private var myXMLConnector:XMLConnector;
	
	private var item1_mc:MovieClip, item2_mc:MovieClip, item3_mc:MovieClip;
	
	// Operations
	
	public  function Matchlist()
	{
		// array mit matches
		myMatches = [];
		// xml connector
		myXMLConnector = new XMLConnector(this, _global.scriptPath);
		// infos ueber matches laden
		loadMatches();
	
	}
	
	private function loadMatches():Void
	{
		// xml head
		var head:XML = myXMLConnector.getXMLHead("eplussoccer", {obj:"matchesProcessor"});
		// infos ueber user (fuer info, ob der user fuer das jeweilige spiel noch tippen darf)
		var node:XMLNode = myXMLConnector.getXMLNode("user", {userid : _global.Game.user.userid});
		// einhaengen
		head.firstChild.appendChild(node);
		// senden und empfangen
		myXMLConnector.sendXML(head, "onMatchesLoaded");
	}
	
	public  function onMatchesLoaded(xmlobj:XML ):Void
	{
		// infos ueber matches
		var matches:Array = xmlobj.firstChild.childNodes;
		// schleife ueber alle matches
		for (var i in matches) {
			// in object umformen
			var match:Object = myXMLConnector.parseXMLNode(matches[i]);
			// in array schreiben
			myMatches[Number(match["matchid"])] = new Match(match);
		}
		// anzeigen
		showMatches();
		// im game dauerhaft speichern
		_global.Game.onMatchlistLoaded(myMatches);
	}
	
	private function showMatches():Void
	{
		// counter fuer drei matches
		var counter:Number = 0;
		// schleife ueber alle matches
		for (var i = 0; i < myMatches.length; i ++) {
			// aktuelles match
			var match:Match = myMatches[i];
			// weiterschleifen, wenn nicht aktiv
			if (match.active != true) continue;
			// abbrechen, wenn drei matches durch
			if (++counter > 3) break;
			// anzeigen lassen
			this["item" + counter + "_mc"].showMatch(match, true);
		}
	}

} /* end class Matchlist */
