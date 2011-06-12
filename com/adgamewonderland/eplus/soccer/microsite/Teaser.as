/* Teaser
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Teaser
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		04.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*;

class com.adgamewonderland.eplus.soccer.microsite.Teaser extends Box {

	// Attributes
	
	private var more_mc:MovieClip;
	
	// Operations
	
	public  function Teaser()
	{
		// klassenname
		myClassName = "Teaser";
		// registrieren
		Playground.registerBox(this);
	}
	
	// buttons initialisieren
	public function initButtons():Void
	{
		// array mit buttons
		myButtons = [more_mc];
		// callback beim rollover von "mehr"
		more_mc.onRollOver = more_mc.onRollOut = function () {
			this._parent.onRollMore();
		}
		// callback beim druecken von "mehr"
		more_mc.onRelease = function () {
			this._parent.onPressMore();
		}
		// aktivieren
		active = true;
	}
	
	// callback beim rollover eines "hotspots"
	public function onRollHotspot(hotspot:MovieClip ):Void
	{
		// wie beim rollover von "mehr"
		onRollMore();
	}
	
	// callback beim druecken eines "hotspots"
	public function onPressHotspot():Void
	{
		// wie beim druecken von "mehr"
		onPressMore();
	}
	
	// callback beim druecken von "mehr"
	public function onPressMore():Void
	{
		// pfad in array umwandeln, um an deeplink ran zu kommen
		var parr:Array = path.split("_");
		// wenn zwei elemente, dann deeplink
		var content:String = (parr.length == 2 ? parr[1] : "");
		// entsprechende subpage mit / ohne content anzeigen lassen
		Playground.showSubpage(this, parr[0], content);
	}

} /* end class Teaser */
