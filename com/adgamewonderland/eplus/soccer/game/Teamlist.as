/* Team
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */  

/*
klasse:			Team
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		24.04.2004
zuletzt bearbeitet:	28.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.*;

class com.adgamewonderland.eplus.soccer.game.Teamlist extends MovieClip {

	// Attributes
	
	private var myXMLConnector:XMLConnector;
	
	private var isLoaded:Boolean, isSelectable:Boolean;
	
	private var myXPos:Number, myYPos:Number, myYDiff:Object, myHeadlines:Object;
	
	private var myItems:Array;
	
	private var helpplayer_mc:MovieClip, helpstatistics_mc:MovieClip, helptipp_mc:MovieClip;
	
	// Operations
	
	public  function Teamlist()
	{
		// xml connector
		myXMLConnector = new XMLConnector(this, _global.scriptPath);
		// x-position der liste
		myXPos = 30;
		// y-position der ersten headline
		myYPos = 116;
		// y-abstand der items
		myYDiff = {headline : 25, item : 15};
		// headline texte
		myHeadlines = {goal : "Tor", defense : "Abwehr", midfield : "Mittelfeld", offense : "Angriff"};
		// items auf der buehne (position im array entspricht playerid)
		myItems = [];
		// noch nicht geladen
		loaded = false;
		
		// team, das im game gespeichert wird
		if (_global.Game.team == null) {
			// infos ueber team laden
			loadTeam();
		} else {
			// anzeigen
			showTeam();
		}
	}
	
	private function loadTeam():Void
	{
		// xml head
		var head:XML = myXMLConnector.getXMLHead("eplussoccer", {obj:"teamProcessor"});
		// senden und empfangen
		myXMLConnector.sendXML(head, "onTeamLoaded");
	}
	
	public  function onTeamLoaded(xmlobj:XML ):Void 
	{
		// neues team erstellen und in game speichern
		_global.Game.onTeamlistLoaded(new Team(xmlobj));
		// anzeigen
		showTeam();
	}
	
	private function showTeam():Void 
	{
		// team aufgeteilt nach positionen (goal, defense, midfield, offense)
		var positions:Object = _global.Game.team.getPlayersByPosition();
		// tiefe fuer attachen
		var depth:Number = 0;
		// y-position
		var ypos:Number = myYPos;
		// schleife ueber alle positionen
		for (var i in positions) {
			// neue headline
			var headline:MovieClip = this.attachMovie("teamlistheadline", "headline_" + i + "_mc", ++depth, {_x : myXPos, _y : ypos, myHeadline : myHeadlines[i]});
			// weiter nach unten
			ypos += myYDiff.headline;
			// spieler auf dieser position
			var players:Array = positions[i];
			// zeilenzaehler
			var line:Number = 0;
			// schleife ueber alle spieler
			for (var j in players) {
				// weiter, falls spieler nicht aktiv
				if (players[j].active == false) continue;
				// playerid
				var id:Number = players[j].playerid;
				// hochzaehlen
				line ++;
				// neues item (uebergeben wird player und ob die zeilenummer gerade oder ungerade ist (fuer hintergrundbalken)))
				var item:MovieClip = this.attachMovie("teamlistitem", "item" + id + "_mc", ++depth, {_x : myXPos, _y : ypos, myPlayer : players[j], isEven : line % 2 == 0});
				// weiter nach unten
				ypos += myYDiff.item;
				// item in array schreiben
				myItems[id] = item;
			}
		}
		// je nach spielmodus auswaehlbar oder nicht
		selectable = (_global.Game.mode == "w");
		// geladen
		loaded = true;
	}
	
	public function set loaded(bool:Boolean ):Void
	{
		// geladen
		isLoaded = bool;;
	}
	
	public function get loaded():Boolean
	{
		// geladen
		return (isLoaded);
	}
	
	public function getItem(playerid:Number ):MovieClip
	{
		// zurueck geben
		return (myItems[playerid]);
	}
	
	public function set selectable(bool:Boolean ):Void
	{
		// merken
		isSelectable = bool;
		// schleife ueber alle items
		for (var i in myItems) {
			// de- / aktivieren
			myItems[i].selectable = bool;
		}
	}
	
	public function showTipp(infos:Array ):Void
	{
		// schleife ueber alle infos
		for (var i in infos) {
			// aktuelle info
			var info:Object = infos[i];
			
			trace(info.playerid + ": " + info.startplayer);
		
		}
	
	}

} /* end class Teamlist */
