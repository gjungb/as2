/* Subpage
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Subpage
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		04.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*

class com.adgamewonderland.eplus.soccer.microsite.Subpage extends Box {

	// Attributes
	
	private var more_mc:MovieClip, close_mc:MovieClip, back_mc:MovieClip;
	
	private var logo_mc:MovieClip, teaser_txt:TextField, teaser_subtxt:TextField, blind_mc:MovieClip;
	
	private var myFirstContent:String, _myFirstContent:String;
	
	private var myContent:MovieClip;
	
	private var myStateBack:Boolean;
	
	private var myLoaderboxes:Array;
	
	private var myInterval:Number;
	
	// Operations
	
	public  function Subpage()
	{
		// klassenname
		myClassName = "Subpage";
		// registrieren
		Playground.registerBox(this);
		// content, der zuerst geladen werden woll (wird im initObject uebergeben)
		myFirstContent = _myFirstContent;
		// registrierte loaderboxen
		myLoaderboxes = [];
		// aktuell zu sehender content
		myContent = null;
		// hintergrund zugeklappt
		myStateBack = false;
	}
	
	// loaderbox registrieren
	public function registerLoaderbox(loaderbox:MovieClip ):Number
	{
		// in array schreiben
		var index:Number = myLoaderboxes.push(loaderbox) - 1;
		// index zurueck geben, damit loaderbox ihre position im array kennt
		return (index);
	}
	
	// buttons initialisieren
	public function initButtons():Void
	{
		// array mit buttons
		myButtons = [more_mc, close_mc];
		// callback beim druecken von "mehr"
		more_mc.onRelease = function () {
			this._parent.onPressMore();
		}
		// callback beim druecken von "schliessen"
		close_mc.onRelease = function () {
			this._parent.onPressClose();
		}

		// aktivieren
		active = true;
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
	}
	
	// naechstes laden veranlassen
	public function loadNext(index:Number ):Void
	{
		// naechste box ist eins weiter im array der registriereten loaderboxen
		var index:Number = index + 1;
		// wenn oben angekommen, unten weiter machen
		if (index == myLoaderboxes.length) index = 0;
		// wenn noch nicht geladen
		if (myLoaderboxes[index].loaded == false) {
			// laden starten
			myLoaderboxes[index].startLoading();
		}
	}
	
	// hintergrund auf- / zuklappen
	public function switchBack(box:MovieClip, state:Boolean, close:Boolean ):Void
	{
		// abbrechen, falls hintergrund schon in gewuenschter position ist
		if (myStateBack == state) return;
		
		// unterscheiden zwischen auf- / zuklappen
		switch (state) {
			// aufklappen
			case true:
				// logo ausblenden
				logo_mc._visible = false;
				// text ausblenden
				teaser_txt._visible = teaser_subtxt._visible = false;
				// mehr button ausblenden
				more_mc._visible = false;
				// karten deaktivieren
// 				Playground.setBoxesActive("card", false);
				
				// frame, in dem sich back_mc zuletzt befunden hat (um stop() zu bemerken)
				var lastframe:Number = 1;
				// abspielen verfolgen
				this.onEnterFrame = function () {
					// stop() erreicht
					if (back_mc._currentframe - lastframe == 0) {
						// verfolgen beenden
						delete (this.onEnterFrame);
						// content anzeigen
						showContent(box, myContent);
						// karten ausblenden
						Playground.setBoxesVisible("card", false);
					}
					// lastframe aktualisieren
					lastframe = back_mc._currentframe;
				}
				
				break;
			// zuklappen
			case false:
				// content ausblenden
				hideContent();
				// abspielen verfolgen
				this.onEnterFrame = function () {
					// letzter frame erreicht
					if (back_mc._currentframe == back_mc._totalframes) {
						// schliessen gewuenscht?
						if (close) {
							// schliessen
							closeBox();
						} else {
							// logo einblenden
							logo_mc._visible = true;
							// text einblenden
							teaser_txt._visible = teaser_subtxt._visible = true;
						}
						// verfolgen beenden
						delete (this.onEnterFrame);
					}
				}
			
				break;
		}
		// abspielen
		back_mc.play();
		// neuen status merken
		myStateBack = state;
	}
	
	// content anzeigen
	public  function showContent(box:MovieClip, content:MovieClip ):Void
	{
		// aufrufende box deaktivieren
		box.active = false;
		// bisherigen content ausblenden
		hideContent();
		// neuen content merken
		myContent = content;
		// unterscheiden, ob auf- oder zugeklappt
		switch (myStateBack) {
			// aufgeklappt
			case true:
				// neuen content sichtbar
				myContent._visible = true;
				// abspielen
				for (var i in myContent) if (typeof myContent[i] == "movieclip") myContent[i].gotoAndPlay(2);
				// tracken
				Playground.trackUser("cont_" + box.path);
			
				break;
			// zugeklappt
			case false:
				// aufklappen
				switchBack(box, true, false);
			
				break;
		}
	}
	
	// content ausblenden
	public  function hideContent():Void
	{
		// aktuellen content ausblenden
		myContent._visible = false;
		// sound stoppen
		stopAllSounds();
	}
	
	// blende zeigen
	public function showBlind(bool:Boolean, size:String, time:Number):Void
	{
		// ein- / ausblenden
		switch (bool) {
			// einblenden
			case true:
				// symbolname
				var symbol:String = "blind" + size;
				// auf buehne
				this.attachMovie(symbol, "blind_mc", 1, {_x : 25, _y : 50});
				// nach pause wieder ausblenden
				myInterval = setInterval(this, "showBlind", time, false, "", 0);
			
				break;
				
			// ausblenden
			case false:
				// interval loeschen
				clearInterval(myInterval);
				// blende loeschen
				blind_mc.removeMovieClip();
			
				break;
		}
	}
	
	// callback beim rollover eines "hotspots"
	public function onRollHotspot(hotspot:MovieClip ):Void
	{
		trace("roll: " + hotspot);
	
	}
	
	// callback beim druecken von "schliessen"
	public function onPressClose():Void
	{
		// unterscheiden zwischen auf- / zugeklappt
		switch (myStateBack) {
			// aufgeklappt
			case true:
				// grosse blende
				showBlind(true, "large", 2000);
				// zuklappen, dann schliessen
				switchBack(null, false, true);
			
				break;
			// zugeklappt
			case false:
				// kleine blende
				showBlind(true, "small", 2000);
				// schliessen
				closeBox();
			
				break;
		}
	}
	
	// callback beim druecken von "mehr"
	public function onPressMore():Void
	{
		// aufklappen
		switchBack(null, !myStateBack, false);
	}

} /* end class Subpage */
