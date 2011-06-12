/* Handykarusell
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Handykarusell
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		17.05.2004 (fussball)
zuletzt bearbeitet:	09.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.cebit.ui.Handykarusell extends MovieClip {

	// Attributes
	
	private static var PMAX:Number = 2000;
	
	private static var NUMOBJECTS:Number = 5;
	
	private var myCenter:Object;
	
	private var myDirection:String;
	
	private var mySelected:Number;
	
	private var isMoving:Boolean;
	
	private var myInterval:Number;
	
	private var myLastframe:Number;
	
	// Operations
	
	public  function Handykarusell()
	{
		// position, an der die maus gemessen wird
		myCenter = {x : 200, xmin : 25, xmax : 375, ymin : 110, ymax : 320};
		// bewegungsrichtung
		direction = "";
		// erstes handy ausgeaehlt
		selected = 1;
		// wird die navigation bewegt
		setMoving(false);
	}
	
	// wird die navigation bewegt
	public function setMoving(bool:Boolean ):Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// wird die navigation bewegt
		isMoving = bool;
		// naechstes handy
		if (!isMoving) {
			// gleiche richtung
			switch (direction == getDirection()) {
				// 
				case true :
					// eins weiter
					selected = selected + 1;
					// wenn rechts raus, links wieder anfangen
					if (selected > NUMOBJECTS) selected = 1;
					break;
				// 
				case false :
					// neue richtung
					direction = getDirection();
					// umgekehrt
					selected = NUMOBJECTS + 1 - selected;
					break;
			}
		}
		// maus verfolgen
		onEnterFrame = followMouse;
	}
	
	// ausgewaehltes handy
	public function set selected(num:Number ):Void
	{
		// ausgewaehltes handy
		mySelected = num;
	}
	
	// ausgewaehltes handy
	public function get selected():Number
	{
		// ausgewaehltes handy
		return (mySelected);
	}
	
	// bewegungsrichtung
	public function set direction(name:String ):Void
	{
		// bewegungsrichtung
		myDirection = name;
	}
	
	// bewegungsrichtung
	public function get direction():String
	{
		// bewegungsrichtung
		return (myDirection);
	}
	
	public function getDirection():String
	{
		// abstand zwischen maus und mittelpunkt
		var xdiff:Number = _xmouse - myCenter["x"];
		// richtung
		var direction:String = (xdiff < 0 ? "r" : "l");
		// nur wenn ausserhalb
		if (Math.abs(xdiff) < 90) direction = "";
		// zurueck geben
		return direction;
	}
	
	// maus verfolgen
	public function followMouse()
	{
		// abbrechen, falls schon bewegt wird
		if (isMoving) {
			// stop erreicht
			if (_currentframe - myLastframe == 0) {
				// verfolgen beenden
				delete(onEnterFrame);
				// dauer der pause abhaengig vom x-abstand
				var pause:Number = PMAX - Math.abs(_xmouse - myCenter["x"]) * 10;
				// bewegung nach pause beendet
				myInterval = setInterval(this, "setMoving", pause, false);
			}
			// framenr merken
			myLastframe = _currentframe;
		// bewegen
		} else {
			// richtung
			direction = getDirection();
			// maus muss innerhalb erlaubtem bereich sein
			if (direction != "" && _xmouse > myCenter["xmin"] && _xmouse < myCenter["xmax"] && _ymouse > myCenter["ymin"] && _ymouse < myCenter["ymax"] ) {
				// frame
				var frame = "fr" + selected + direction;
				// abspielen
				gotoAndPlay(frame);
				// bewegung laeuft
				setMoving(true);
				// framenr merken
				myLastframe = _currentframe;
			}
		}
	}

} /* end class Handykarusell */
