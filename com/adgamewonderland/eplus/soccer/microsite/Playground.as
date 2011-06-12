/* Playground
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Playground
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		05.05.2004
zuletzt bearbeitet:	09.06.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.eplus.soccer.microsite.Playground {

	// Attributes
	
	static private var myStage:MovieClip;
	
	static private var mySubpagepos:Object = {x: 0, y: 0};
	
	static private var myBoxes:Object = {};
	
	static private var mySubpage:MovieClip = null, myContent:MovieClip = null;
	
	static private var myContentDepth:Number = 2;
	
	static private var myDiscount:Object = {goals : 0, discount : 0};
	
	// Operations
	
	static public  function initPlayground(stage:MovieClip ):Void
	{
		// buehne auf der sich alles abspielt
		myStage = stage;
	}
	
	static public  function openLink(link:String ):Void
	{
		// abbrechen, wenn link nicht definiert
		if (typeof link == "undefined") return;
		// link auftrennen
		var parr:Array = link.split("_");
		// subpage?
		if (parr[0] == "sub") {
			// path
			var path:String = parr[1];
			// content
			var content:String = (parr.length == 3 ? parr[2] : "");
			// aufrufen
			showSubpage(myStage, path, content);
		}
	}
	
	static public  function registerBox(box:MovieClip ):Void
	{
		// testen, ob fuer diese klasse noch keine registrierungen vorliegen
		if (typeof myBoxes[box.classname] == "undefined") {
			// assoziatives array erweitern
			myBoxes[box.classname] = [];
		}
		// hinzufuegen
		myBoxes[box.classname].push(box);
	}
	
	static public  function unregisterBox(box:MovieClip ):Void
	{
		// schleife ueber alle registrierten boxen dieser klasse
		for (var i in myBoxes[box.classname]) {
			// testen, ob gefunden
			if (myBoxes[box.classname][i] == box) {
				// aus array loeschen
				myBoxes[box.classname].splice(i, 1);
				// abbrechen
				break;
			}
		}
	}
	
	static public  function setBoxesActive(classname:String, activity:Boolean ):Void
	{
		// schleife ueber alle registrierten boxen dieser klasse
		for (var i in myBoxes[classname]) {
			// de- / aktivieren
			myBoxes[classname][i].active = activity;
		}
	}
	
	static public  function setBoxesVisible(classname:String, visibility:Boolean ):Void
	{
		// schleife ueber alle registrierten boxen dieser klasse
		for (var i in myBoxes[classname]) {
			// ein- / ausblenden
			myBoxes[classname][i]._visible = visibility;
		}
	}
	
	static public  function showHomepage():Void
	{
		// aktuelle subpage ausblenden
		mySubpage.onPressClose();
	}
	
	static public  function showSubpage(box:MovieClip, path:String, content:String ):Void
	{
		// teaser ausblenden
		setBoxesVisible("teaser", false);
		// symbolnamen zusammen setzen
		var symbol:String = "sub_" + path;
		// abbrechen, falls diese subpage schon auf buehne liegt
		if (mySubpage._name == symbol) return;
		// aufrufende box deaktivieren
		box.active = false;
		// testen, ob subpage auf buehne liegt
		if (mySubpage != null) {
			// sobald ausgeblendet, neue subpage einblenden
			mySubpage.onUnload = function () {
				// gewuenschte subpage
				showSubpage(box, path, content);
			}
			// aktuelle subpage ausblenden
			mySubpage.closeBox();
		
		// einblenden
		} else {
			// tiefe
			var depth:Number = 1;
			// auf buehne bringen
			mySubpage = myStage.attachMovie(symbol, symbol + "_mc", depth, {_x : mySubpagepos.x, _y : mySubpagepos.y, _myFirstContent : content});
			// tracken
			trackUser(symbol);
		}
	}
	
	static public  function removeSubpage(box:MovieClip ):Void
	{
		// teaser einblenden
		setBoxesVisible("teaser", true);
		// teaser aktivieren
		setBoxesActive("teaser", true);
		// karten einblenden
		setBoxesVisible("card", true);
		// karten aktivieren
		setBoxesActive("card", true);
		// deregistrieren
		unregisterBox(box);
		// entladen
		box.removeMovieClip();
		// keine subpage
		mySubpage = null;
	}
	
	static public  function loadContent(loaderbox:MovieClip, path:String )
	{
		// symbolnamen zusammen setzen
		var symbol:String = "cont_" + path;
		// testen, ob dieser content schon geladen ist
		if (typeof myStage[symbol + "_mc"] == "movieclip") {
			// vorhandenen content uebergeben
			var content:MovieClip = myStage[symbol + "_mc"];
		} else {
			// tiefe hochzaehlen
			var depth = ++myContentDepth;
			// neues movieclip
			var content:MovieClip = myStage.createEmptyMovieClip(symbol + "_mc", depth);
			// erst mal unsichtbar
			content._visible = false;
			// ordner, in dem die swf liegt
			var folder:String = path.substring(0, path.indexOf("_"));
			// url der swf
			var url:String = folder + "/" + symbol + ".swf";
			// laden
			content.loadMovie(url);
		}
		// an loader uebergeben
		loaderbox.showLoader(content);
	}
	
	static public  function trackUser(path:String )
	{
		// datensender
		var sender:LoadVars = new LoadVars();
		// datenempfaenger
		var receiver:LoadVars = new LoadVars();
		// pfad
		sender.path = path;
		// senden
		sender.sendAndLoad("scripts/eplussoccer_tracking.php", receiver);
	}
	
	static public  function showKickem(mc:MovieClip, bool:Boolean )
	{
		// ggf. vor subpage legen
		if (bool && mySubpage != null) mc.swapDepths(mySubpage.getDepth() + 1);
		// tracken
		if (bool) trackUser("kickem");
	}
	
	static public  function setDiscount(goals, discount):Void
	{
		// anzahl tore
		myDiscount.goals = goals;
		// prozent rabatt
		myDiscount.discount = discount;
	}
	
	static public  function getDiscount():Object
	{
		// zurueck geben
		return myDiscount;
	}

} /* end class Playground */
