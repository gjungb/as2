import flash.geom.Rectangle;
import flash.geom.Point;

class com.adgamewonderland.eplus.basegold.pressestimmen.PressestimmenUI extends MovieClip {
	
	private static var LISTX:Number = 2;

	private static var LISTY:Number = 58;

	private static var LISTWIDTH:Number = 368;

	private static var LISTHEIGHT:Number = 189;

	private static var SCROLLHEIGHT:Number = 70;

	private static var SCROLLSPEED:Number = 8;

	private static var SCROLLDIR_UP:Number = -1;

	private static var SCROLLDIR_DOWN:Number = 1;

	private static var SCROLLPERCENT:Number = 10;

	private var buttons : Array;	

	private var scrolltop:Rectangle;

	private var scrollbottom:Rectangle;
	
	public function PressestimmenUI() {
		// buttons, die gescrollt werden sollen
		this.buttons = new Array();
		// alle buttons suchen
		for (var i : String in this) {
			if (this[i] instanceof Button) {
				var button : Button = Button(this[i]);
				// speichern
				this.buttons.push(button);
			}
		}
		// scrollsensitive flaeche am oberen rand
		this.scrolltop = new Rectangle(LISTX, LISTY, LISTWIDTH, SCROLLHEIGHT);
		// scrollsensitive flaeche am unteren rand
		this.scrollbottom = new Rectangle(LISTX, LISTY + LISTHEIGHT - SCROLLHEIGHT, LISTWIDTH, SCROLLHEIGHT);
		
		// interval
		var interval : Number;
		// nach pause text und infos initialisieren
		var doInit : Function = function(mc : PressestimmenUI ) : Void {
			// scrollen verfolgen
			mc.onEnterFrame = mc.followMouse;
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause initialisieren
		interval = setInterval(doInit, 5000, this);
	}

	private function followMouse():Void
	{
		// mausposition
		var mousepos:Point = new Point(_xmouse,_ymouse);
		// scrollrichtung
		var scrolldirection:Number = SCROLLDIR_UP;
		// prozentuale scrollgeschwindigkeit je nach abstand vom rand
		var scrollpercent:Number = SCROLLPERCENT;
		// testen, ob maus in oberer scrollsensitiver flaeche
		if (this.scrolltop.containsPoint(mousepos)) {
			// scrollrichtung nach unten
			scrolldirection = SCROLLDIR_DOWN;
			// scrollgeschwindigkeit steigt mit sinkendem abstand vom oberen rand
			scrollpercent = 100 - Math.round((mousepos.y - this.scrolltop.y) / this.scrolltop.height * 100);
		}
		// testen, ob maus in unterer scrollsensitiver flaeche
		if (this.scrollbottom.containsPoint(mousepos)) {
			// scrollrichtung nach oben
			scrolldirection = SCROLLDIR_UP;
			// scrollgeschwindigkeit steigt mit sinkendem abstand vom unteren rand
			scrollpercent = Math.round((mousepos.y - this.scrollbottom.y) / this.scrollbottom.height * 100);
		}
		// scrollen
		scrollList(scrolldirection, scrollpercent);
	}

	private function scrollList(direction:Number, percent:Number ):Void
	{
		// abbrechen, wenn nichts zu scrollen
		if (direction == 0 || percent == 0) return;
		// um wie viele pixel soll die liste verschoben werden
		var ydiff:Number = direction * percent / 100 * SCROLLSPEED;
		// aktueller button
		var button : Button;
		// schleife ueber alle buttons
		for (var i : Number = 0; i < this.buttons.length; i++) {
			// aktueller button
			button = this.buttons[i];
			// verschieben
			button._y += ydiff;
		}
		// oberer button
		var bmin : Button = getButtonMin();
		// unterer button
		var bmax  : Button = getButtonMax();
		// testen, ob oben oder unten raus
		if (direction == SCROLLDIR_UP) {
			// testen, ob oben raus
			if (bmin._y < LISTY - bmin._height)
				bmin._y = bmax._y + bmax._height;
				
		} else if (direction == SCROLLDIR_DOWN) {
			// testen, ob unten raus
			if (bmax._y > LISTY + LISTHEIGHT)
				bmax._y = bmin._y - bmax._height;
		}
	}
	
	private function getButtonMin() : Button {
		// button, der am weitesten oben ist
		var ret : Button;
		// minimalwert
		var ymin : Number = Number.MAX_VALUE;
		// aktueller button
		var button : Button;
		// schleife ueber alle buttons
		for (var i : Number = 0; i < this.buttons.length; i++) {
			// aktueller button
			button = this.buttons[i];
			// testen, ob weiter oben
			if (button._y < ymin) {
				// merken
				ret = button;
				// minimalwert
				ymin = button._y;
			}
		}
		// zurueck geben
		return ret;
	}
	
	private function getButtonMax() : Button {
		// button, der am weitesten unten ist
		var ret : Button;
		// maximalwert
		var ymax : Number = Number.MIN_VALUE;
		// aktueller button
		var button : Button;
		// schleife ueber alle buttons
		for (var i : Number = 0; i < this.buttons.length; i++) {
			// aktueller button
			button = this.buttons[i];
			// testen, ob weiter oben
			if (button._y > ymax) {
				// merken
				ret = button;
				// maximalwert
				ymax = button._y;
			}
		}
		// zurueck geben
		return ret;
	}
}
