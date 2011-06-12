/* Figure
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Figure
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		21.04.2004
zuletzt bearbeitet:	27.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

import com.adgamewonderland.agw.Point;

class com.adgamewonderland.eplus.soccer.game.Figure extends MovieClip {

	// Attributes
	
	private var myPlayer:Player;
	
	private var isActive:Boolean, isDragging:Boolean;
	
	private var myPlayerid:Number, isUsed:Boolean, isTop:Boolean, isBad:Boolean, isStartplayer:Boolean;
	
	private var myTeamlistitem:MovieClip;
	
	private var myCoords:Point;
	
	private var myButtons:Array;
	
	private var number_txt:TextField, name_txt:TextField;
	
	private var shirt_mc:MovieClip, name_mc:MovieClip, menu_mc:MovieClip;
	
	// Operations
	
	public  function Figure()
	{
		// figur dem player zuordnen (wird im constructor uebergeben)
		myPlayer.figure = this;
		// nicht am draggen
		dragging = false;
		// id des players
		playerid = myPlayer.playerid;
		// kein topspieler
		top = false;
		// kein boeser spieler
		bad = false;
		// als spieler aufgestellt
		used = true;
		// kein startspieler
		startplayer = false;

		// movieclip, das den spieler der figur in teamliste anzeigt
		myTeamlistitem = _parent.teamlist_mc.getItem(playerid);
		
		// koordinaten
		myCoords = new Point(0, 0);
		// spieler angezeigen
		showPlayer(myPlayer);
		// buttons initialisieren
		initButtons();
		
		// werte ueberwachen
		this.watch("top", onChangeAttribute);
		this.watch("bad", onChangeAttribute);
	}
	
	public function onUnload():Void
	{
		// beim loeschen wieder abmelden
		myPlayer.figure = null;
		// resetten (sprich alle kreuzchen loeschen)
		myTeamlistitem.resetItem();
	}
	
	private function showPlayer(player:Player ):Void
	{
		// rueckennummer
		number_txt.autoSize = "center";
		number_txt.text = player.number;
		// name
		name_txt.autoSize = "center";
		name_txt.text = player.lastname;
		name_txt._width = name_txt.textWidth * 1.1;
		// menu neben namen
		menu_mc._x = name_txt._x + name_txt._width + 2;
		// falls kein torwart, shirt stoppen
		if (player.position != "goal") shirt_mc.stop();
	}
	
	public function removeFigure():Void
	{
		// kein topspieler
		if (top) _parent.changeCount(this, "top", -1);
		// kein boeser spieler
		if (bad) _parent.changeCount(this, "bad", -1);
		// auswaehlen
		_parent.selectPlayer(player);
		// loeschen
		_parent.dropPlayer(new Point(0, 0));
	}
	
	private function initButtons():Void
	{
		// button auf name
		var name_mc:MovieClip = this.createEmptyMovieClip("name_mc", 1);
		// an linke obere ecke des namen
		name_mc._x = name_txt._x;
		name_mc._y = name_txt._y;
		// hitarea bauen
		name_mc.beginFill(0xCCCCCC, 0);
		name_mc.lineTo(name_txt._width, 0);
		name_mc.lineTo(name_txt._width, name_txt._height);
		name_mc.lineTo(0, name_txt._height);
		name_mc.lineTo(0, 0);
		name_mc.endFill();
		
		// array mit buttons
		myButtons = [name_mc, shirt_mc];
		// callback bei klick auf name
		name_mc.onPress = function () {
			// spieler auswaehlen, damit er ganz nach vorne kommt
			_global.Tipp.selectPlayer(this._parent.myPlayer);
		}
		// callback bei release auf name
		name_mc.onRelease = function () {
			// menu umschalten
			this._parent.swapMenu();
		}
		// callback bei klick auf figur
		shirt_mc.onPress = function () {
			// menu ausblenden
			this._parent.showMenu(false);
			// spieler zum tippen uebergeben
			_global.Tipp.selectPlayer(this._parent.myPlayer);
		}
	}
	
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet umschalten
		isActive = bool;
		// buttons de- / aktivieren
		for (var i in myButtons) {
			myButtons[i].enabled = bool;
		}
		// menu de- / aktivieren
		menu_mc.active = bool;
	}
	
	public function onMouseUp():Void
	{
		// draggen beenden
		if (dragging) _parent.dropPlayer(new Point(_x, _y));
	}
	
	public function swapMenu():Void
	{
		// ein- / ausblenden
		menu_mc.open = !menu_mc.open;
	}
	
	public function showMenu(bool:Boolean ):Void
	{
		// ein- / ausblenden
		menu_mc.open = bool;
	}
	
	public function changeShirt(type:String ):Void
	{
		// frame
		var frame:String = "fr" + type;
		// hinspringen
		shirt_mc.gotoAndStop(frame);
	}
	
	public function onChangeAttribute(prop, oldval, newval)
	{
		// testen, ob dieses umschalten erlaubt
		var allowed:Boolean = (_parent.changeCount(this, prop, (newval ? 1 : -1)));
		// attribut einschalten, wenn gewuenscht und erlaubt 
		return (allowed && newval);
	}
	
	public function set playerid(num:Number ):Void
	{
		myPlayerid = num;
	}
	
	public function get playerid():Number
	{
		return (myPlayerid);
	}
	
	public function set top(bool:Boolean ):Void
	{
		isTop = bool;
		// anzeige aendern
		myTeamlistitem.showCross("top", bool);
		// menuicon aendern
		menu_mc.highlightIcon("top", bool);
	}
	
	public function get top():Boolean
	{
		return (isTop);
	}
	
	public function set bad(bool:Boolean ):Void
	{
		isBad = bool;
		// anzeige aendern
		myTeamlistitem.showCross("bad", bool);
		// menuicon aendern
		menu_mc.highlightIcon("bad", bool);
	}
	
	public function get bad():Boolean 
	{
		return (isBad);
	}
	
	public function set used(bool:Boolean ):Void
	{
		isUsed = bool;
		// loeschen
		if (bool == false) removeFigure();
	}
	
	public function get used():Boolean 
	{
		return (isUsed);
	}
	
	public function set startplayer(bool:Boolean ):Void
	{
		isStartplayer = bool;
		// anzeige aendern
		myTeamlistitem.showCross("exchange", !bool);
	}
	
	public function get startplayer():Boolean 
	{
		return (isStartplayer);
	}
	
	public function get player():Player 
	{
		return (myPlayer);
	}
	
	public function set coords(point:Point ):Void
	{
		myCoords = point;
	}
	
	public function get coords():Point 
	{
		return (myCoords);
	}
	
	public function set dragging(bool:Boolean ):Void
	{
		isDragging = bool;
	}
	
	public function get dragging():Boolean 
	{
		return (isDragging);
	}

} /* end class Figure */
