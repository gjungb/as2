/* Subfanpa
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Subfanpa
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		17.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*

class com.adgamewonderland.eplus.soccer.microsite.Subfanpa extends Subpage {

	// Attributes
	
	private var text1_txt:TextField, text2_txt:TextField, text3_txt:TextField, text4_txt:TextField;
	
	private var navigation_mc:MovieClip;
	
	// Operations
	
	public  function Subfanpa()
	{
		// klassenname
		myClassName = "Subfanpa";
		// registrieren
		Playground.registerBox(this);
	}
	
	// loader initialisieren
	public function initLoader():Void
	{
		// schleife ueber alle registrierten loader, um index der box zu bekommen, die zuerst geladen werden soll
		for (var index in myLoaderboxes) {
			// testen, ob dieser content gewuenscht
			if (myLoaderboxes[index].path == (path + "_" + myFirstContent)) break;
		}
		// laden starten (nach laden direkt anzeigen oder nicht)
		myLoaderboxes[index].startLoading(myFirstContent != "");
		// texte ausblenden
		for (var i:Number = 1; i <= myLoaderboxes.length; i ++) {
			// textfeld
			this["text" + i + "_txt"]._visible = false;
		}
		// navigation ausblenden
		navigation_mc._visible = false;
	}
	
	// naechstes laden veranlassen
	public function loadNext(index:Number ):Void
	{
		// aufrufende loaderbox deaktivieren
		myLoaderboxes[index].active = false;
		// more button deaktivieren
		myLoaderboxes[index].more_mc.enabled = false;
		// aufrufende loaderbox abfaden
		myLoaderboxes[index]._alpha = 50;
		// naechste box ist eins weiter im array der registriereten loaderboxen
		var index:Number = index + 1;
		// textfeld sichtbar
		this["text" + index + "_txt"]._visible = true;
		// textfeld abfaden
		this["text" + index + "_txt"]._alpha = 50;
		// wenn noch nicht geladen
		if (myLoaderboxes[index].loaded == false) {
			// laden starten
			myLoaderboxes[index].startLoading();
		}
		// wenn alle fertig, aktivieren
		if (index == myLoaderboxes.length) onContentLoaded();
	}
	
// 	// content anzeigen
// 	public  function showContent(box:MovieClip, content:MovieClip ):Void
// 	{
// 		// aufrufende box deaktivieren
// 		box.active = false;
// 		// bisherigen content ausblenden
// 		hideContent();
// 		// neuen content merken
// 		myContent = content;
// 		// unterscheiden, ob auf- oder zugeklappt
// 		switch (myStateBack) {
// 			// aufgeklappt
// 			case true:
// 				// neuen content sichtbar
// 				myContent._visible = true;
// 			
// 				break;
// 			// zugeklappt
// 			case false:
// 				// aufklappen
// 				switchBack(box, true, false);
// 			
// 				break;
// 		}
// 	}
	
	// alle inhalte geladen
	public function onContentLoaded():Void
	{
		// schleife ueber loaderboxen
		for (var index in myLoaderboxes) {
			// einfaden
			myLoaderboxes[index]._alpha = 100;
			// more button aktivieren
			myLoaderboxes[index].more_mc.enabled = true;
			// textfeld einfaden
			this["text" + (Number(index) + 1) + "_txt"]._alpha = 100;
		}
		// navigation einblenden
		navigation_mc._visible = true;
	}
	
	// navigation zum ersten mal genutzt
	public function onInitNavi(content:String ):Void
	{
		// schleife ueber loaderboxen
		for (var index in myLoaderboxes) {
			// ausblenden
			myLoaderboxes[index]._visible = false;
			// textfeld ausblenden
			this["text" + (Number(index) + 1) + "_txt"]._visible = false;
		}
		// content laden
		onPressNavi(content);
	}
	
	// content laden lassen (pfad wird aus fanpaketnavi uebergeben)
	public function onPressNavi(content:String ):Void
	{
		// schleife ueber alle registrierten loader, um index der box mit dem content zu bekommen
		for (var index in myLoaderboxes) {
			// testen, ob dieser content gewuenscht
			if (myLoaderboxes[index].path == (path + "_" + content)) break;
		}
		// content anzeigen
		myLoaderboxes[index].onPressBack();
	}

} /* end class Subfanpa */
