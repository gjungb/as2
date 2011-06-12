import flash.geom.Rectangle;
import flash.geom.Point;
import com.adgamewonderland.agw.util.ScrollbarUI;

/**
 * @author gerd
 */
class com.adgamewonderland.msh.flashpaper.ZoompagesUI extends MovieClip {

	private static var PAGEX:Number = -452.5;

	private static var PAGEY:Number = -320.0;

	private static var PAGEWIDTH:Number = 905.0;

	private static var PAGEHEIGHT:Number = 1280.0 / 2;

	private static var SCROLLHEIGHT:Number = 240;

	private static var SCROLLSPEED:Number = 8;

	private static var SCROLLDIR_UP:Number = -1;

	private static var SCROLLDIR_DOWN:Number = 1;

	private var scrolltop:Rectangle;

	private var scrollbottom:Rectangle;

	private var page_mc:MovieClip;

	private var scrollbar_mc:ScrollbarUI;

	function ZoompagesUI() {
		// scrollsensitive flaeche am oberen rand
		this.scrolltop = new Rectangle(PAGEX, PAGEY, PAGEWIDTH, SCROLLHEIGHT);
		// scrollsensitive flaeche am unteren rand
		this.scrollbottom = new Rectangle(PAGEX, PAGEY + PAGEHEIGHT - SCROLLHEIGHT, PAGEWIDTH, SCROLLHEIGHT);
	}

	public function showPage(aPage:Number ):Void
	{
		// hinspringen
		gotoAndStop("frPage" + aPage);
		// seite
		page_mc = this["pic" + (aPage < 10 ? "0" : "") + aPage + "_mc"];
		// scrollbar
		scrollbar_mc.setScrollTarget(page_mc);
		// scrollen verfolgen
		onEnterFrame = followMouse;
	}

	public function hidePage():Void
	{
		// ausblenden
		gotoAndStop(1);
		// scrollen verfolgen beenden
		delete(onEnterFrame);
	}

	private function followMouse():Void
	{
		// mausposition
		var mousepos:Point = new Point(_xmouse,_ymouse);
		// scrollrichtung
		var scrolldirection:Number = 0;
		// prozentuale scrollgeschwindigkeit je nach abstand vom rand
		var scrollpercent:Number = 0;
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
		// um wie viele pixel soll die seite verschoben werden
		var ydiff:Number = direction * percent / 100 * SCROLLSPEED;
		// neue position der seite
		var ypos:Number = page_mc._y + ydiff;
		// erlaubte grenzen testen
		if (ypos > PAGEY) {
			ypos = PAGEY;
		} else if (ypos < PAGEY + PAGEHEIGHT - Math.max(PAGEHEIGHT, page_mc._height)) {
			ypos = PAGEY - (Math.max(PAGEHEIGHT, page_mc._height) - PAGEHEIGHT);
		}
		// seite scrollen
		page_mc._y = Math.round(ypos);
		// scrollbar thumb positionieren
		scrollbar_mc.setThumbPosition(Math.abs(ypos - PAGEY) / PAGEHEIGHT * 100);
	}

}