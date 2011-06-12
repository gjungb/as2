/* Team
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */  

/*
klasse:			Team
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		21.04.2004
zuletzt bearbeitet:	23.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.*;

class com.adgamewonderland.eplus.soccer.game.Team {

	// Attributes
	
	private var myPlayers:Array;
	
	private var myXMLConnector:XMLConnector;
	
	// Operations
	
	public  function Team(xmlobj:XML )
	{
		// spieler
		myPlayers = [];
		// xml connector
		myXMLConnector = new XMLConnector(this, _global.scriptPath);
		// infos ueber players
		var players:Array = xmlobj.firstChild.childNodes;
		// schleife ueber alle players
		for (var i = 0; i < players.length; i++) {
			// in object umformen
			var player:Object = myXMLConnector.parseXMLNode(players[i]);
			// in array schreiben
			myPlayers[Number(player["playerid"])] = new Player(player);
		}
	}
	
	public  function getPlayersByPosition():Object
	{
		// object fuer arrays mit playern, aufgeteilt nach position
		var players:Object = {goal : [], defense : [], midfield : [], offense : []};
		// schleife ueber alle spieler
		for (var i in myPlayers) {
			// position
			var position:String = myPlayers[i].position;
			// ggf. neues array
			if (typeof players[position] == "undefined") players[position] = [];
			// spieler anhaengen
			players[position].push(myPlayers[i]);
		}
		// zurueck geben
		return (players);
	}

} /* end class Team */
