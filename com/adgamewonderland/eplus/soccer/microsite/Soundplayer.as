/* Soundplayer
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Soundplayer
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		18.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.eplus.soccer.microsite.Soundplayer extends MovieClip {

	// Attributes
	
	private var _myFile:String, _myPath:String, myUrl:String;
	
	private var mySound:Sound;
	
	private var myTime:Number, myPercent:Number;
	
	private var isPlaying:Boolean;
	
	private var rewind_mc:MovieClip, play_mc:MovieClip, stop_mc:MovieClip, close_mc:MovieClip, bar_mc:MovieClip;
	
	// Operations
	
	public  function Soundplayer()
	{
		// url
		myUrl = _myPath + "/" + _myFile;
		// sound objekt
		mySound = new Sound(this);
		// zeit, seit der der sound laeuft
		myTime = 0;
		// prozent des sounds, die abgespielt sind
		myPercent = 0;
		// registrieren
		_parent.registerSoundplayer(this);
	}
	
	public  function initPlayer():Void
	{
		// alle anderen ausblenden
		_parent.resetSoundplayers(this);
		// prozent updaten
		updatePercent(0);
		// laeuft der sound
		isPlaying = false;
		// play button aktivieren
		play_mc.onRelease = function () {
			this._parent.controlSound("play");
		}
		// stop button aktivieren
		stop_mc.onRelease = function () {
			this._parent.controlSound("stop");
		}
		// stop button ausblenden
		stop_mc._visible = false;
		// rewind button aktivieren
		rewind_mc.onRelease = function () {
			this._parent.controlSound("rewind");
		}
		// close button aktivieren
		close_mc.onRelease = function () {
			this._parent.controlSound("close");
		}
		// autostart
		controlSound("play");
	}
	
	public  function controlSound(mode:String ):Void 
	{
		// modus
		switch (mode) {
			// abspielen
			case "play" :
				// testen, ob komplett geladen
				if (typeof mySound.getBytesTotal() != "undefined" && mySound.getBytesLoaded() == mySound.getBytesTotal()) {
					// abspielen
					mySound.start(myTime / 1000);
				
				} else {
					// laden und abspielen
					mySound.loadSound(myUrl, true);
				}
				// play button ausblenden
				play_mc._visible = false;
				// stop button einblenden
				stop_mc._visible = true;
				// laeuft der sound
				isPlaying = true;
				
				break;
			
			// stoppen
			case "stop" :
			
				// stoppen
				mySound.stop();
				// play button einblenden
				play_mc._visible = true;
				// stop button ausblenden
				stop_mc._visible = false;
				// laeuft der sound
				isPlaying = false;
				
				break;
			
			// zurueckspulen
			case "rewind" :
			
				// stoppen
				controlSound("stop");
				// prozent updaten
				updatePercent(0);
				
				break;
			
			// schliessen
			case "close" :
			
				// abbrechen, falls im 1. frame
				if (_currentframe == 1) return;
				// zurueckspuelen
				controlSound("rewind");
				// ausblenden
				gotoAndStop(1);
				
				break;
		}
	}
	
	public function updatePercent(time:Number ):Void
	{
		// zeit merken
		myTime = time;
		// prozent abgespielt
		myPercent = Math.round(myTime / mySound.duration * 100);
		// am anfang auf 0
		if (isNaN(myPercent)) myPercent = 0;
		// balken skalieren
		bar_mc._xscale = myPercent;
		// am ende stoppen
		if (myPercent > 0 && myTime == mySound.duration) controlSound("rewind");
	}
	
	// abspielen verfolgen
	public function onEnterFrame():Void
	{
		// abbrechen, wenn sound nicht laeuft
		if (!isPlaying) return;
		// prozent updaten
		updatePercent(mySound.position);
	}

} /* end class Soundplayer */
