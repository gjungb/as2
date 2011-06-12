/* Photoclick
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Photoclick
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			n24
erstellung: 		16.09.2004
zuletzt bearbeitet:	22.11.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.XMLConnector

import com.adgamewonderland.n24.photoclick.*

class com.adgamewonderland.n24.photoclick.Photoclick extends MovieClip {

	// Attributes
	
	private var _myFile:String; // konfigurationsdatei
	
	private var myNumMotives:Object; // anzahl motive (act, max, random)
	
	private var myTime:Object; // zeit (start, motiv, act, total)
	
	private var myGameinfos:Object // spielinformationen (week, weekday, round)
	
	private var myMotives:Array; // informationen ueber motive und aufgaben (als xml)
	
	private var myAgof:String; // agof string fuer ivw-zaehlung
	
	private var myNumSegments:Number; // anzahl der segmente in der maske
	
	private var myXMLConnector:XMLConnector; // xml connector
	
	private var myScore:Object; // punktzahlen (act, max, total)
	
	private var myInterval:Number; // interval id
	
	private var mask_mc:Mask, motiv_mc:MovieClip, task_mc:Task, loader_mc:MovieClip;
	
	private var counter_txt:TextField, time_txt:TextField, score_txt:TextField, copyright_txt:TextField;
	
	private var next_btn:Button;
	
	// Operations
	
	// rechteck mit linker oberer ecke, breite und hoehe
	public  function Photoclick(xpos:Number, ypos:Number, width:Number , height:Number )
	{
		// anzahl motive
		myNumMotives = {act : 0, max : 0, random : []};
		// zeit
		myTime = {start : 0, motiv : 0, act : 0, total : 0};
		// spielinformationen
		myGameinfos = {week : 0, weekday : 0, round : 0};
		// informationen ueber motive und aufgaben (als xml)
		myMotives = [];
		// agof string fuer ivw-zaehlung
		myAgof = "";
		// anzahl der segmente in der maske
		myNumSegments = 0;
		// zum testen pfad angeben
		if (_url.indexOf("http://") == -1) _myFile = "http://192.168.0.27/kunden/n24/weihnachtsspiel/game/" +  _myFile;
		// xml connector
		myXMLConnector = new XMLConnector(this, _myFile);
		// punktzahlen
		myScore = {act : 0, max : 100, total : 0};
		// interval id
		myInterval = 0;
		// weiter button ausblenden
		next_btn._visible = false;
		
		// xml head
		var head:XML = myXMLConnector.getXMLHead("n24_christmas", {obj:"gameProcessor"});
		// infos ueber game
		var node:XMLNode = myXMLConnector.getXMLNode("game", {game : "photoclick"});
		// einhaengen
		head.firstChild.appendChild(node);
		// xml laden
		myXMLConnector.sendXML(head, "parseMotives");
	}
	
	// xml parsen
	public function parseMotives(xmlobj:XML ):Void
	{
		// informationen ueber photoclick
		var photoclick:XMLNode = xmlobj.firstChild.firstChild;
		// anzahl motive
		myNumMotives.max = Number(photoclick.attributes.motives);
		// zeit je motiv
		myTime.total = Number(photoclick.attributes.time) * 1000;
		// woche
		myGameinfos.week = Number(photoclick.attributes.week);
		// wochentag
		myGameinfos.weekday = Number(photoclick.attributes.weekday);
		// runde
		myGameinfos.round = Number(photoclick.attributes.round);
		
		// informationen ueber motive und aufgaben (als xml)
		myMotives = photoclick.childNodes;
		// anzahl motive deckeln
		if (myNumMotives.max > myMotives.length) myNumMotives.max = myMotives.length;
		// zufaellige motive, die waehrend des spiels angezeigt werden
		myNumMotives.random = getRandomNumArray(myNumMotives.max, 0, myMotives.length - 1, 1);
		
		// werbung neu laden
		_global.myPlayground.showAd("photoclick/start", "");
	}
	
	// aufgabe starten
	public function startTask():Void
	{
		// weiter button ausblenden
		next_btn._visible = false;
		// anzahl motive hochzaehlen
		if (++myNumMotives.act > myNumMotives.max) {
			// beenden
			stopGame();
			// abbrechen
			return;
		}
		// informationen ueber motiv und aufgaben (als xml)
		var motiv:XMLNode = myMotives[myNumMotives.random[myNumMotives.act - 1]];
		// jpeg, das angezeigt wird
		var file:String = motiv.firstChild.firstChild.nodeValue;
		// copyright
		var copyright:String = motiv.firstChild.attributes["copyright"];
		copyright_txt.autoSize = "right";
		copyright_txt.text = "� " + copyright;
		// aufgabe
		var task:XMLNode = motiv.firstChild.nextSibling;
		// agof string fuer ivw-zaehlung
		myAgof = motiv.attributes["agof"];

		// jpeg laden
		loadImage(file, task);
	}
	
	// jpeg laden
	private function loadImage(file:String, task:XMLNode ):Void
	{
		// in platzhalter laden
		motiv_mc.loadMovie(file);
		// maske initialisieren
		mask_mc.initMask();
		// maske einblenden
		mask_mc._visible = true;
		
		// laden verfolgen
		onEnterFrame = function () {
			// prozent geladen
			var percent:Number = Math.round(motiv_mc.getBytesLoaded() / motiv_mc.getBytesTotal()) * 100;
			// loader einblenden
			loader_mc._visible = true;
			// loader skalieren
// 			loader_mc._xscale = percent;
			// wenn geladen
			if (percent == 100) {
				// verfolgen beenden
				delete(onEnterFrame);
				// loader ausblenden
				loader_mc._visible = false;
				
				// aufgabe anzeigen
				task_mc.showTask(task);
				// counter anzeigen
				counter_txt.autoSize = "left";
				counter_txt.text = myNumMotives.act + "/" + myNumMotives.max;
				// anzahl der segmente in der maske
				myNumSegments = mask_mc.getNumSegments();
				// zeit je segment berechnen
				myTime.motiv = myTime.total / myNumSegments;
				// punktzahl, wenn jetzt geantwortet wird
				myScore.act = myScore.max;
				// maximale punkte anzeigen
				time_txt.autoSize = "center";
				time_txt.text = myScore.max;
				// bild aufdecken
				myInterval = setInterval(this, "uncoverMask", myTime.motiv, true);
			}
		}
	}
	
	// zeit zaehlen
	private function countTime():Void
	{
		// bisher vergangene zeit
		myTime.act = getTimer() - myTime.start;
		// anteil vergangene zeit an gesamtzeit
		var factor:Number = 1 - myTime.act / myTime.total;
		// punktzahl, wenn jetzt geantwortet wird
		myScore.act = Math.round(myScore.max * factor);
		// nicht kleiner als 0
		if (myScore.act < 0) myScore.act = 0;
		// anzeigen
		time_txt.autoSize = "center";
		time_txt.text = myScore.act;
	}
	
	// bild aufdecken
	private function uncoverMask():Void
	{
		// maske aufdecken, anzahl der noch uebrigen segmente kommt zurueck
		var segments:Number = mask_mc.clearSegment();
		// nach erstem segement zeitanzeige starten
		if (segments == myNumSegments - 1) {
			// startzeit
			myTime.start = getTimer();
			// zeit zaehlen
			onEnterFrame = countTime;
		}
		// beenden, wenn keine segmente uebrig
		if (segments == 0) solveTask(false);
	}
	
	// aufgabe loesen
	public function solveTask(correct:Boolean ):Void
	{
		// buttons in aufgabe ausblenden
		task_mc.setActive(false);
		// zaehlen der zeit beenden
		delete(onEnterFrame);
		// aufdecken beenden
		clearInterval(myInterval);
		
		// korrekt / nicht korrekt
		switch(correct) {
			// korrekt
			case true :
				// maske ausblenden
				mask_mc._visible = false;
				// punkte zaehlen
				myScore.total += myScore.act;
				// anzeigen
				score_txt.autoSize = "center";
				score_txt.text = myScore.total;
				
				break;
			// nicht korrekt
			case false :
				
				break;
		}
		// weiter button einblenden
		next_btn._visible = true;
		// werbung neu laden
		_global.myPlayground.showAd("photoclick/runde" + myNumMotives.act, myAgof);
	}
	
	// spiel beenden
	private function stopGame():Void
	{
		// bonuspunkte, wenn maximale punktzahl erreicht
		if (myScore.total == myNumMotives.max * myScore.max) myScore.total += Math.round(myScore.max * Math.random());
		// punktzahl an highscoreliste weiter reichen
		_root.gameover_mc.showGameover(myScore.total);
		// weiter auf hauptzeitleiste
		_root.gotoAndStop("frGameover");
		// werbung neu laden
		_global.myPlayground.showAd("photoclick/ende", "");
	}
	
	// methode "getRandomNumArray" gibt array mit zufallszahlen gemaess uebergebenen parametern zurueck
	public function getRandomNumArray(length:Number, min:Number, max:Number, freq:Number):Array
	{
		// haeufigkeiten der erlaubten zahlen setzen
		var nums:Array = new Array(max - min + 1);
		// schleife ueber gesamten erlaubten bereich
		var i:Number = 0;
		while (i < (max - min + 1)) {
			// erlaubte zahl setzen
			nums[i] = freq;
			// und weiter
			i ++;
		}
		
		// array fuer die zufallszahlen
		var tmp:Array = new Array(length);
		// schleife ueber alle elemente
		for (var i = 0; i < length; i ++) {
			// keine passende zahl gefunden
			var found:Boolean = false;
			// zufallszahl erzeugen
			do {
				// zufallszahl >=min && <=max
				var rand:Number = Math.floor(min + Math.random() * (max - min + 1));
				// diese zahl darf genommen werden, wenn noch nicht alle instanzen verbraucht
				if (--nums[rand - min] >= 0) found = true;
			} while (found == false);
			// zufallszahl speichern
			tmp[i] = rand;
		}
		
		// zurueck geben
		return (tmp);
	}
	
} /* end class Photoclick */
