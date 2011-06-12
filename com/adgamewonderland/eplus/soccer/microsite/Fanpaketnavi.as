/* Fanpaketnavi
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Fanpaketnavi
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		17.05.2004
zuletzt bearbeitet:	18.05.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.eplus.soccer.microsite.Fanpaketnavi extends MovieClip {

	// Attributes
	
	private var myCenter:Object;
	
	private var mySelected:String;
	
	private var isMoving:Boolean, isLocked:Boolean, myInterval:Number;
	
	private var myLastframe:Number;
	
	private var ngage_mc:MovieClip, n6230_mc:MovieClip, n6220_mc:MovieClip, sim55_mc:MovieClip;
	
	// Operations
	
	public  function Fanpaketnavi()
	{
		// position, an der die maus gemessen wird
		myCenter = {x : 407, ymin : 80, ymax : 200};
		// wird die navigation bewegt
		setMoving(false);
		// ist gerade pause bis zur weiteren bewegung
		isLocked = false;
		
		// buttons zum initialisieren
		ngage_mc.onRelease = function () {
			this._parent.initNavi("ngage");
		}
		n6230_mc.onRelease = function () {
			this._parent.initNavi("n6230");
		}
		n6220_mc.onRelease = function () {
			this._parent.initNavi("n6220");
		}
		sim55_mc.onRelease = function () {
			this._parent.initNavi("sim55");
		}
	}
	
	
	// wird die navigation bewegt
	public function setMoving(bool:Boolean ):Void
	{
		// wird die navigation bewegt
		isMoving = bool;
		// ist gerade pause bis zur weiteren bewegung
		isLocked = false;
		// interval loeschen
		clearInterval(myInterval);
	}
	
	// ausgewaehltes handy
	public function set selected(name:String ):Void
	{
		// ausgewaehltes handy
		mySelected = name;
		// dazu gehoeriges movieclip
		var mc = this[name + "_mc"];
		// button aktivieren
		mc.onRelease = function () {
			this._parent.onSelectItem(name);
		}
	}
	
	// ausgewaehltes handy
	public function get selected():String
	{
		// ausgewaehltes handy
		return (mySelected);
	}
	
	public  function initNavi(name:String ):Void
	{
		// frame
		var frame:String = "fr" + name;
		// abspielen
		gotoAndPlay(frame);
		// merken
		selected = name;
		// bewegung laeuft
		setMoving(true);
		// bewegung nach pause beendet
		myInterval = setInterval(this, "setMoving", 4000, false);
		// loader etc. ausblenden und content aufrufen
		_parent.onInitNavi(name);
	}
	
	// maus verfolgen
	public function onEnterFrame()
	{
		// abstand zwischen maus und mittelpunkt
		var xdiff:Number = _xmouse - myCenter["x"];
		// abbrechen, falls schon bewegt wird
		if (isMoving) {
			// stop erreicht
			if (_currentframe - myLastframe == 0 && !isLocked) {
				// dauer der pause abhaengig vom x-abstand
				var pause:Number = 1200 - Math.abs(xdiff) * 10;
				// bewegung nach pause beendet
				myInterval = setInterval(this, "setMoving", pause, false);
				// sperren bis pause um
				isLocked = true;
			}
			// framenr merken
			myLastframe = _currentframe;
		// bewegen, falls grenze ueberschritten
		} else if (Math.abs(xdiff) > 60 && _ymouse > myCenter["ymin"] && _ymouse < myCenter["ymax"] ) {
			// frame
			var frame = "fr" + selected + (xdiff > 0 ? "r" : "l");
			// abspielen
			gotoAndPlay(frame);
			// bewegung laeuft
			setMoving(true);
			// framenr merken
			myLastframe = _currentframe;
		}
	}
	
	// callback beim druecken eines items
	public function onSelectItem(name:String ):Void
	{
		// content aufrufen
		_parent.onPressNavi(name);
		// button deaktivieren
		this[name + "_mc"].enabled = false;
	}

} /* end class Fanpaketnavi */
