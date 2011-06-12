/* Teamlistitem 
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Teamlistitem 
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		24.05.2004
zuletzt bearbeitet:	27.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

class com.adgamewonderland.eplus.soccer.game.Teamlistitem  extends MovieClip {

	// Attributes
	
	private var myPlayer:Player;
	
	private var isActive:Boolean, isSelected:Boolean,  isEven:Boolean;
	
	private var select_mc:MovieClip, top_mc:MovieClip, exchange_mc:MovieClip, bad_mc:MovieClip, bar_mc:MovieClip;
	
	private var number_txt:TextField, name_txt:TextField, matches_txt:TextField, goals_txt:TextField, gelb_txt:TextField, rot_txt:TextField;
	
	// Operations
	
	public  function Teamlistitem ()
	{
		// spieler, der angezeigt wird (wird im constructor uebergeben)
		showPlayer(myPlayer);
		// button initialisieren
		initButtons();
	}
	
	private function showPlayer(player:Player ):Void
	{
		// rueckennummer
		number_txt.autoSize = "right";
		number_txt.text = leadingZero(Number(player.number));
		// name
		name_txt.autoSize = "left";
		name_txt.text = player.firstname + " " + player.lastname;
		// tore
		goals_txt.autoSize = "center";
		goals_txt.text = (player.goals == 0 ? "" : player.goals);
		// gelbe karten
		gelb_txt.autoSize = "center";
		gelb_txt.text = (player.gelb == 0 ? "" : player.gelb);
		// rote karten
		rot_txt.autoSize = "center";
		rot_txt.text = (player.rot == 0 ? "" : player.rot);
		// resetten
		resetItem();
		// stoppen, wenn gerade zeile (wird im constructor uebergeben)
		if (isEven) bar_mc.stop();
	}
	
	private function initButtons():Void
	{
		// callback bei klick auf spieler
		select_mc.onPress = function () {
			// spieler zum tippen uebergeben
			_global.Tipp.selectPlayer(this._parent.myPlayer);
			// deaktivieren
			this._parent.active = false;
			// auswaehlen
			this._parent.selected = true;
		}
		// callback bei release auf topspieler
		top_mc.onRelease = function () {
			this._parent.selectIcon("top");
		}
		// callback bei klick auf bad guy
		bad_mc.onRelease = function () {
			this._parent.selectIcon("bad");
		}
	}
	
	public function showCross(type:String, bool:Boolean ):Void
	{
		// kreuz ein- / ausblenden
		this[type + "_mc"].cross_mc._visible = bool;
	}
	
	public function resetItem():Void
	{
		// kreuze ausblenden
		showCross("top", false);
		showCross("exchange", false);
		showCross("bad", false);
		// aktivieren
		active = true;
		// nicht auswaehlen
		selected = false;
	}
	
	public function selectIcon(type:String ):Void
	{
		// umschalten
		myPlayer.figure[type] = !myPlayer.figure[type];
	}
	
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet merken
		isActive = bool;
		// button de- / aktivieren
		select_mc.enabled = bool;
		// topspieler de- / aktivieren
		top_mc.enabled = !bool;
		// bad guy de- / aktivieren
		bad_mc.enabled = !bool;
	}
	
	public function set selected(bool:Boolean ):Void
	{
		// merken, ob ausgewaehlt
		isSelected = bool;
		// aussehen button umschalten
		select_mc.gotoAndStop(bool ? "_over" : "_up");
	}
	
	public function set selectable(bool:Boolean ):Void
	{
		// button de- / aktivieren
		select_mc.enabled = bool;
		// topspieler de- / aktivieren
		top_mc.enabled = bool;
		// bad guy de- / aktivieren
		bad_mc.enabled = bool;
	}
	
	private function leadingZero(num:Number ):String
	{
		// in string umwandeln
		var str:String = num.toString();
		// falls kuerzer als zwei zeichen
		if (str.length < 2) {
			// nullen vorne dran
			str = "0" + str;
		}
		// zurueck geben
		return (str);
	}

} /* end class Teamlistitem  */
