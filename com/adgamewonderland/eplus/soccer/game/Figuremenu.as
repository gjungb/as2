/* Figuremenu
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Figuremenu
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		21.04.2004
zuletzt bearbeitet:	28.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.Point;

class com.adgamewonderland.eplus.soccer.game.Figuremenu extends MovieClip {

	// Attributes
	
	private var isActive:Boolean, isOpen:Boolean;
	
	private var myInterval:Number;
	
	private var myButtons:Array, myIcons:Array;
	
	private var myXMin:Number, myXDiff:Number;
	
	private var open_mc:MovieClip, top_mc:MovieClip, bad_mc:MovieClip, used_mc:MovieClip;
	
	// Operations
	
	public  function Figuremenu()
	{
		// linke position der icons
		myXMin = 13;
		// abstand der icons
		myXDiff = 16;
		// buttons initialisieren
		initButtons();
	}
	
	private function initButtons():Void
	{
		// array mit buttons
		myButtons = [open_mc, top_mc, bad_mc, used_mc];
		// array mit icons, die gehighlighted werden koennen
		myIcons = [top_mc, bad_mc, used_mc];
		// callback bei klick auf pfeil
		open_mc.onRelease = function () {
			// menu umschalten
			this._parent.open = !this._parent.open;
		}
		// callback bei release auf topspieler
		top_mc.onRelease = function () {
			this._parent.selectIcon("top");
		}
		// callback bei klick auf bad guy
		bad_mc.onRelease = function () {
			this._parent.selectIcon("bad");
		}
		// callback bei klick auf loeschen
		used_mc.onRelease = function () {
			this._parent.selectIcon("used");
		}
		// top highlight ausblenden
		highlightIcon("top", false);
		// top highlight ausblenden
		highlightIcon("bad", false);
		// top highlight ausblenden
		highlightIcon("used", false);
		// schliessen
		open = false;
	}
	
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet umschalten
		isOpen = bool;
		// buttons de- / aktivieren
		for (var i in myButtons) {
			myButtons[i].enabled = bool;
		}
	}
	
	public function get active():Boolean
	{
		// aktivitaet
		return (isActive);
	}
	
	public function set open(bool:Boolean ):Void
	{
		// umschalten
		isOpen = bool;
		// schleife ueber alle icons
		for (var i in myIcons) {
			// ein- / ausblenden
			myIcons[i]._visible = (bool || myIcons[i].glow_mc._visible == true);
		}
		// pfeil umdrehen
		open_mc._rotation = (bool ? 180 : 0);
		// icons positionieren
		setIconPositions();
	}
	
	public function get open():Boolean
	{
		// geoeffnet
		return (isOpen);
	}
	
	public function selectIcon(type:String ):Void
	{
		// umschalten
		_parent[type] = !_parent[type];
	}
	
	public function highlightIcon(type:String, bool:Boolean ):Void
	{
		// icon ein- / ausblenden
		this[type + "_mc"]._visible = (bool || open);
		// glow ein- / ausblenden
		this[type + "_mc"].glow_mc._visible = bool;
		// icons positionieren
		setIconPositions();
	}
	
	private function setIconPositions():Void
	{
		// zaehler fuer anzahl icons, die positioniert werden
		var counter:Number = -1;
		// schleife ueber alle icons
		for (var i = 0; i < myIcons.length; i ++) {
			// aktuelles icon
			var icon:MovieClip = myIcons[i];
			// menue geoeffnet => alle icons positionieren
			if (open == true) {
				// hochzaehlen
				counter ++;
			// menu geschlossen => icon nur positionieren, wenn gehighlighted
			} else {
				// weiter, wenn nicht gehighlighted
				if (icon.glow_mc._visible == false) continue;
				// hochzaehlen
				counter ++;
			}
			// x-position
			var xpos:Number = myXMin + counter * myXDiff;
			// positionieren
			icon._x = xpos;
		}
	}

} /* end class Figuremenu */
