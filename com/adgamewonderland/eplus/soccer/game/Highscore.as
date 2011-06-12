/* Highscore
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Highscore
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		29.05.2004
zuletzt bearbeitet:	02.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.*;

class com.adgamewonderland.eplus.soccer.game.Highscore extends MovieClip {

	// Attributes
	
	private var list_mc:MovieClip;
	
	private var myMatchid:Number;
	
	private var myXMLConnector:XMLConnector;
	
	private var loader_txt:TextField, scroller_mc:MovieClip;
	
	// Operations
	
	public  function Highscore()
	{
		// _isTotal: handelt es sich um die gesamthighscoreliste (komponentenparameter)
		
		// xml connector
		myXMLConnector = new XMLConnector(this, _global.scriptPath);
	}
	
	public  function set matchid(id:Number ):Void
	{
		// matchid
		myMatchid = id;
	}
	
	public  function get matchid():Number
	{
		// matchid
		return (myMatchid);
	}
	
	private function loadHighscore():Void
	{
		// loader
		loader_txt.autoSize = "center";
		loader_txt.text = "Daten werden geladen...";
		// xml head
		var head:XML = myXMLConnector.getXMLHead("eplussoccer", {obj:"highscoreProcessor"});
		// infos ueber match (bei matchid 0 kommt gesamthighscoreliste, bei matchid != 0 match highscoreliste)
		var node:XMLNode = myXMLConnector.getXMLNode("match", {matchid : matchid});
		// einhaengen
		head.firstChild.appendChild(node);
		// senden und empfangen
		myXMLConnector.sendXML(head, "onHighscoreLoaded");
	}
	
	public  function onHighscoreLoaded(xmlobj:XML ):Void
	{
		// array, das highscoredaten der user aufnimmt
		var highscore:Array = [];
		// infos ueber users
		var users:Array = xmlobj.firstChild.childNodes;
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
		var ydiff = dummy._height;
		// schleife ueber alle user
		for (var i = 1; i < highscore.length; i ++) {
			// aktueller user
			var user:Object = highscore[i - 1];
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy._y + (i - 1) * ydiff;
			// dummy duplizieren
			var pos:MovieClip = dummy.duplicateMovieclip("pos" + i + "_mc", i + 1, constructor);
			// position
			pos.position_txt.text = i;
			// nickname
			pos.nickname_txt.text = user.nickname;
			// score
			pos.score_txt.text = user.score;
		}
		// dummy unsichtbar
		dummy._visible = false;
		// scrollbar initialisieren
		scroller_mc.setScrollTarget(list_mc);
		// loader
		loader_txt.text = "";
	}

} /* end class Highscore */
