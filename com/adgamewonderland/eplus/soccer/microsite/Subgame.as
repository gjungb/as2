/* Subgame
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Subgame
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		30.05.2004
zuletzt bearbeitet:	08.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*

class com.adgamewonderland.eplus.soccer.microsite.Subgame extends Subpage {

	// Attributes
	
	private var game_mc:MovieClip, loader_txt:TextField, start_mc:MovieClip, kicker_mc:MovieClip;
	
	private var myInterval:Number;
	
	// Operations
	
	public  function Subgame()
	{
		// klassenname
		myClassName = "Subgame";
		// registrieren
		Playground.registerBox(this);
		// global ansprechbar
		_global.Subgame = this;
	}
	
	private function loadGame():Void
	{
		// neues movieclip fuer game
		this.createEmptyMovieClip("game_mc", 1);
		// cachekiller
		var cachekiller:Number = Math.round(Math.random() * 1e12);
		// laden
		game_mc.loadMovie("eplussoccer_game.swf?cachekiller=" + cachekiller);
		// laden verfolgen
		onGameLoading();
	}
	
	private function onGameLoading():Void
	{
		// verfolgen
		this.onEnterFrame = function () {
			// prozent geladen
			var percent:Number = Math.floor(game_mc.getBytesLoaded() / game_mc.getBytesTotal() * 100);
			// text zentriert
			loader_txt.autoSize = "left";
			// anzeigen
			if (!isNaN(percent)) loader_txt.text = "Lade Rudis Aufstellungspoker " + percent + " %";
			// fertig geladen
			if (percent == 100) {
				// verfolgen beenden
				delete (this.onEnterFrame);
				// callback
				myInterval = setInterval(this, "onGameLoaded", 2000);
			}
		}
	}
	
	private function onGameLoaded():Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// kicker anhalten
		kicker_mc.gotoAndStop("frStop");
		// text aendern
		loader_txt.text = "Spiel jetzt starten";
		// button aktivieren
		start_mc.onRelease = function () {
			this._parent.startGame();
		}
		// button aktivieren
		start_mc.enabled = true;
	}
	
	public function startGame():Void
	{
		// button deaktivieren
// 		start_mc.enabled = false;
		// tracken
		Playground.trackUser("sub_game_login");
		// abspielen
		game_mc.gotoAndStop("frGame");
	}
	
	// box schliessen
	public function closeBox():Void
	{
		// abspielen
		gotoAndPlay("frClose");
		// abspielen verfolgen
		this.onEnterFrame = function () {
			// letzter frame erreicht
			if (_currentframe == _totalframes) {
				// stoppen
				stop();
				// entfernen
				Playground.removeSubpage(this);
			}
		}
	}

} /* end class Subgame */
