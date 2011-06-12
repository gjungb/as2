/* Box
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Box
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		04.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.Playground;

class com.adgamewonderland.eplus.soccer.microsite.Box extends MovieClip{

	// Attributes
	
	private var isActive:Boolean;
	
	private var myClassName:String= "Box";
	
	private var myPath:String = "";
	
	private var myButtons:Array;
	
	private var raute_mc:MovieClip, shadow_mc:MovieClip;
	
	// Operations
	
	public  function Box()
	{
		// klassenname
// 		myClassName = "Box";
		// aktivieren
// 		active = true;
		// registrieren
// 		Playground.registerBox(this);
	
	}
	
	// de- / aktivieren
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet umschalten
		isActive = bool;
		// buttons de- / aktivieren
		for (var i in myButtons) {
			myButtons[i].enabled = bool;
		}
		// schatten ein- / ausblenden
		shadow_mc._visible = !bool;
	}
	
	// aktivitatet
	public function get active():Boolean
	{
		// aktivitaet
		return (isActive);
	}
	
	// klassenname
	public function get classname():String
	{
		// klassenname
		return (myClassName);
	}
	
	// pfad setzen
	public function set path(ptstr:String ):Void
	{
		// pfad zu dieser box
		myPath = ptstr;
	}
	
	// pfad
	public function get path():String
	{
		// pfad zu dieser box
		return (myPath);
	}
	
	// abspielen verfolgen, bis uebergebener frame erreicht ist
	public function initBox(frame:Number, hotspots:Array ):Void
	{
		// abspielen verfolgen
		this.onEnterFrame = function () {
			// gewuenschter frame erreicht
			if (_currentframe == frame) {
				// stoppen
				stop();
				// buttons initialisieren
				initButtons();
				// loader initialisieren
				initLoader();
				// hotspots  initialisieren
				initHotspots(hotspots);
				// verfolgen beenden
				delete (this.onEnterFrame);
			}
		}
	}
	
	// hotspots als buttons bauen
	public function initHotspots(hotspots:Array ):Void
	{
		// schleife ueber uebergebene movieclip-strings
		for (var i in hotspots) {
			// aktueller hotspot
			var hotspot_mc:MovieClip = this[hotspots[i]];
			// neues movieclip ueber hotspot legen
			var hitarea_mc:MovieClip = this.createEmptyMovieClip("hitarea" + i + "_mc", i);
			// an linke obere ecke des hotspots
			hitarea_mc._x = hotspot_mc._x;
			hitarea_mc._y = hotspot_mc._y;
			// hitarea bauen
			hitarea_mc.beginFill(0xCCCCCC, 10);
			hitarea_mc.lineTo(hotspot_mc._width, 0);
			hitarea_mc.lineTo(hotspot_mc._width, hotspot_mc._height);
			hitarea_mc.lineTo(0, hotspot_mc._height);
			hitarea_mc.lineTo(0, 0);
			hitarea_mc.endFill();
			// callback
			hitarea_mc.onRollOver = hitarea_mc.onRollOut = function () {
				this._parent.onRollHotspot(this);
			}
			// callback
			hitarea_mc.onRelease = function () {
				this._parent.onPressHotspot();
			}
			// zu den buttons hinzufuegen
			myButtons.push(hitarea_mc);
		}
	}
	
	// buttons initialisieren
	public function initButtons():Void
	{
	
	}
	
	// loader initialisieren
	public function initLoader():Void
	{
	
	}
	
	// box schliessen
	public function closeBox():Void
	{
		// abspielen
		play();
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
	
	// callback beim rollover eines "hotspots"
	public function onRollHotspot(hotspot:MovieClip ):Void
	{
	
	}
	
	// callback beim druecken eines "hotspots"
	public function onPressHotspot():Void
	{
	
	}
	
	// callback beim druecken von "schliessen"
	public function onPressClose():Void
	{
	
	}
	
	// callback beim rollover von "mehr"
	public function onRollMore():Void
	{
		// schatten sichtbar / unsichtbar
		shadow_mc._visible = !shadow_mc._visible;
		// animation fuer raute
		var frame:String = (shadow_mc._visible ? "frOn" : "frOff");
		// abspielen
		raute_mc.gotoAndPlay(frame);
	}
	
	// callback beim druecken von "mehr"
	public function onPressMore():Void
	{
	
	}

} /* end class Box */
