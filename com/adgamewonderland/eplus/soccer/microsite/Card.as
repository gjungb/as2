/* Card
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Card
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		04.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*;

class com.adgamewonderland.eplus.soccer.microsite.Card extends Box {

	// Attributes
	
	private var more_mc:MovieClip;
	
	// Operations
	
	public  function Card()
	{
		// klassenname
		myClassName = "Card";
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
		// entsprechende subpage ohne content anzeigen lassen
		Playground.showSubpage(this, path, "");
	}

} /* end class Card */
