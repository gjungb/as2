import mx.transitions.easing.Strong;

import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.agw.util.ScrollbarUI;
import com.adgamewonderland.eplus.basecasting.beans.Casting;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.CastinglistUI;
import com.adgamewonderland.eplus.basecasting.ui.CastingselectorUI;

import flash.geom.Point;
import flash.geom.Rectangle;
import mx.utils.Delegate;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.DatesUI extends CastinglistUI implements ICityControllerListener {

	private static var LISTX:Number = 3;

	private static var LISTY:Number = 3;

	private static var LISTWIDTH:Number = 420;

	private static var LISTHEIGHT:Number = 250;

	private static var SELECTORXDIFF:Number = 0;

	private static var SELECTORYDIFF:Number = 3;

	private static var TWEENDELAY:Number = 50;

	private static var TWEENDURATION:Number = 0.5;

	private static var SCROLLHEIGHT:Number = 120;

	private static var SCROLLSPEED:Number = 8;

	private static var SCROLLDIR_UP:Number = -1;

	private static var SCROLLDIR_DOWN:Number = 1;

	private var scrolltop:Rectangle;

	private var scrollbottom:Rectangle;

	private var scrollbar_mc:ScrollbarUI;

	private var mask_mc:MovieClip;

	private var archive_btn:Button;

	function DatesUI() {
		// ausblenden
		_visible = false;
		// scrollsensitive flaeche am oberen rand
		this.scrolltop = new Rectangle(LISTX, LISTY, LISTWIDTH, SCROLLHEIGHT);
		// scrollsensitive flaeche am unteren rand
		this.scrollbottom = new Rectangle(LISTX, LISTY + LISTHEIGHT - SCROLLHEIGHT, LISTWIDTH, SCROLLHEIGHT);
		// archiv termine button ausblenden
		archive_btn._visible = false;
	}

	public function onLoad():Void
	{
		// als listener registrieren
		CityController.getInstance().addListener(this);
		// archiv termine
		archive_btn.onRelease = Delegate.create(this, doArchive);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		CityController.getInstance().removeListener(this);
	}

	public function onCityStateChanged(aState:String, aNewstate:String):Void
	{
		// castingtermine loeschen
		hideDates();
		// archiv termine button ausblenden
		archive_btn._visible = false;
		// je nach state
		switch (aNewstate) {
			case CityController.STATE_DATES :
				// castingtermine ab dem aktuellsten anzeigen
				showDates(CitiesController.getInstance().getCurrentcity());
				// scrollen verfolgen
				onEnterFrame = followMouse;

				break;

			case CityController.STATE_ARCHIVE :
				// alle castingtermine anzeigen
				showArchive(CitiesController.getInstance().getCurrentcity());
				// scrollen verfolgen
				onEnterFrame = followMouse;
				// archiv termine button einblenden
				archive_btn._visible = true;
				// und deaktivieren
				archive_btn.enabled = false;
				// und abblenden
				archive_btn._alpha = 50;

				break;

			default :
				// castingtermine loeschen
				hideDates();
				// scrollen verfolgen beenden
				delete(onEnterFrame);
		}
	}

	public function onCastingSelected(aCasting:Casting ):Void
	{
		// wenn ein gueltiges casting ausgewaehlt
		if (aCasting != null) {
			// castingtermine loeschen
			hideDates();
			// und aktivieren
			archive_btn.enabled = true;
			// und sichtbar
			archive_btn._alpha = 100;
		}
	}

	private function showDates(aCity:CityImpl ):Void
	{
		// einblenden
		_visible = true;
		// verfuegbare castings
		this.castings = aCity.getCastingsFromLatestCasting();
		// liste aufbauen
		initList();
	}

	private function showArchive(aCity:CityImpl ):Void
	{
		// einblenden
		_visible = true;
		// alle castings
		this.castings = aCity.toCastingsArray();
		// liste aufbauen
		initList();
	}

	private function initList():Void
	{
		// liste mit selectors auf buehne
		list_mc = this.createEmptyMovieClip("list_mc", 1);
		// positionieren
		list_mc._x = LISTX;
		list_mc._y = LISTY;
		// array mit selectors auf buehne
		this.selectoruis = new Array();
		// aktuelles casting
		var casting:CastingImpl;
		// datum des castings
		var date:Date = new Date();
		// soll das datum angeigt werden
		var showdate:Boolean = true;
		// selector auf buehne
		var ui:CastingselectorUI;
		// position des selectors auf buehne
		var pos:Point = new Point(-LISTWIDTH / 2, 0);
		// schleife ueber alle castings
		for (var i:Number = 0; i < this.castings.length; i++) {
			// casting
			casting = castings[i];
			// pruefen, ob neues datum
			if (casting.getDate().getTime() != date.getTime()) {
				// datum des castings
				date = casting.getDate();
				// datum soll angezeigt werden
				showdate = true;
			} else {
				// datum soll nicht angezeigt werden
				showdate = false;
			}
			// auf buehne bringen
			ui = addSelector(casting, pos, i, showdate, true);
			// tweenen
			ui.tweenInSelector(i * TWEENDELAY, Strong.easeOut, TWEENDURATION);
			// naechste position berechnen
			pos.offset(SELECTORXDIFF, ui._height + SELECTORYDIFF);
		}
		// scrollbar initialisieren
		scrollbar_mc.setScrollTarget(list_mc);
		// maske fuer liste der selectors auf buehne
		var mask:Mask = new Mask(this, list_mc, new com.adgamewonderland.agw.math.Rectangle(LISTX, LISTY, LISTWIDTH, LISTHEIGHT));
		// maskieren
		mask.drawMask();
	}

	private function reset():Void
	{
		super.reset();
		// maske loeschen
		mask_mc.removeMovieClip();
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
		// um wie viele pixel soll die liste verschoben werden
		var ydiff:Number = direction * percent / 100 * SCROLLSPEED;
		// neue position der liste
		var ypos:Number = list_mc._y + ydiff;
		// erlaubte grenzen testen
		if (ypos > LISTY) {
			ypos = LISTY;
		} else if (ypos < LISTY + LISTHEIGHT - Math.max(LISTHEIGHT, list_mc._height)) {
			ypos = LISTY - (Math.max(LISTHEIGHT, list_mc._height) - LISTHEIGHT);
		}
		// liste scrollen
		list_mc._y = Math.round(ypos);
	}

	private function doArchive():Void
	{
		// zum archiv, damit alle casting-termine angezegt werden
		CityController.getInstance().changeState(CityController.STATE_ARCHIVE);
	}

}