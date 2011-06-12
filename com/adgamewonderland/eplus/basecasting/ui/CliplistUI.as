import mx.utils.Collection;

import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.agw.util.ScrollbarUI;
import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl;
import com.adgamewonderland.eplus.basecasting.connectors.ClipConnector;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener;
import com.adgamewonderland.eplus.basecasting.interfaces.IClipConnectorListener;
import com.adgamewonderland.eplus.basecasting.ui.ClipselectorUI;

import flash.geom.Point;
import mx.transitions.easing.Strong;
import mx.utils.Delegate;
import flash.geom.Rectangle;
import com.adgamewonderland.eplus.basecasting.beans.impl.ClipImpl;
import com.adgamewonderland.eplus.basecasting.beans.Casting;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CliplistUI extends MovieClip implements ICityControllerListener, IClipConnectorListener {

	private static var LISTX:Number = 3;

	private static var LISTY:Number = 3;

	private static var LISTWIDTH:Number = 210;

	private static var LISTHEIGHT:Number = 250;

	private static var SELECTORXDIFF:Number = 0;

	private static var SELECTORYDIFF:Number = 3;

	private static var TWEENDELAY:Number = 50;

	private static var TWEENDURATION:Number = 0.5;

	private static var COUNT:Number = 10;

	private static var SCROLLHEIGHT:Number = 120;

	private static var SCROLLSPEED:Number = 8;

	private static var SCROLLDIR_UP:Number = -1;

	private static var SCROLLDIR_DOWN:Number = 1;

	private var clips:Collection;

	private var scrolltop:Rectangle;

	private var scrollbottom:Rectangle;

	private var page:Number;

	private var selectoruis:Array;

	private var list_mc:MovieClip;

	private var scrollbar_mc:ScrollbarUI;

	private var prev_btn:Button;

	private var next_btn:Button;

	private var mask_mc:MovieClip;

	public function CliplistUI() {
		// ausblenden
		_visible = false;
		// welche seite wird anzeigt
		this.page = 1;
		// scrollsensitive flaeche am oberen rand
		this.scrolltop = new Rectangle(LISTX, LISTY, LISTWIDTH, SCROLLHEIGHT);
		// scrollsensitive flaeche am unteren rand
		this.scrollbottom = new Rectangle(LISTX, LISTY + LISTHEIGHT - SCROLLHEIGHT, LISTWIDTH, SCROLLHEIGHT);
	}

	public function onLoad():Void
	{
		// als listener registrieren
		CityController.getInstance().addListener(this);
		// als listener registrieren
		ClipConnector.getInstance().addListener(this);
		// buttons zum wechsel zwischen den seiten
		prev_btn.onRelease = Delegate.create(this, doPrev);
		next_btn.onRelease = Delegate.create(this, doNext);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		CityController.getInstance().removeListener(this);
		// als listener deregistrieren
		ClipConnector.getInstance().removeListener(this);
	}

	public function onCityStateChanged(aState:String, aNewstate:String):Void
	{
		// welche seite wird anzeigt
		this.page = 1;
		// neue daten laden
		doLoad();
	}

	public function onCastingSelected(aCasting:Casting ):Void
	{
		// wenn ein gueltiges casting ausgewaehlt, castingtermine loeschen
		if (aCasting != null) {
			// welche seite wird anzeigt
			this.page = 1;
			// neue daten laden
			doLoad();
		}
	}

	public function onTopclipLoaded(aClip:VotableClipImpl ):Void
	{
	}

	public function onClipsByRankLoaded(aClips:Collection ):Void
	{
		// button zurueck, wenn nicht auf seite 1; button weiter, wenn liste laenger als angefordert
		showButtons(this.page > 1, aClips.getLength() > COUNT);
		// zehn je seite
		COUNT = 10;
		// anzeigen
		showClips(aClips);
	}

	public function onClipsByDateLoaded(aClips:Collection ):Void
	{
		// button zurueck, wenn nicht auf seite 1; button weiter, wenn weitere datums vorhanden
		showButtons(this.page > 1,  this.page < CitiesController.getInstance().getCurrentcity().getCastingDates(true).getLength());
		// zehn je seite
		COUNT = 10;
		// anzeigen
		showClips(aClips);
	}

	public function onClipsByCastingLoaded(aClips:Collection ):Void
	{
		// keine buttons
		showButtons(false, false);
		// alle je seite
		COUNT = aClips.getLength();
		// anzeigen
		showClips(aClips);
	}

	public function onClipLoaded(aClip:ClipImpl):Void
	{
	}

	private function doLoad():Void
	{
		// clips loeschen
		hideClips();
		// buttons ausblenden
		showButtons(false, false);
		// aktuelle stadt
		var city:CityImpl = CitiesController.getInstance().getCurrentcity();
		// aktueller state
		var state:String = CityController.getInstance().getState();
		// je nach state
		switch (state) {
			case CityController.STATE_LATEST :
				// datums, fuer die aktive castings vorliegen (neuestes datum zuerst)
				var dates:Collection = city.getCastingDates(true);
				// fuer welches datum sollen die clips geladen werden
				var date = dates.getItemAt(this.page - 1);
				// die clips eines datums laden
				ClipConnector.getInstance().loadClipsByDate(city.getID(), date);

				break;
			case CityController.STATE_HIGHSCORE :
				// welcher clip soll als erster in der stehen
				var startat:Number = (this.page - 1) * COUNT;
				// die am besten bewerteten clips laden
				ClipConnector.getInstance().loadClipsByRank(city.getID(), startat, COUNT);

				break;
			case CityController.STATE_ARCHIVE :
				// ausgeaehltes casting
				var casting:Casting = CityController.getInstance().getSelectedCasting();
				// die clips eines castings laden
				ClipConnector.getInstance().loadClipsByCasting(casting.getID());

				break;

			default :
		}

	}

	private function doPrev():Void
	{
		// vorherige seite
		this.page --;
		// neue daten laden
		doLoad();
	}

	private function doNext():Void
	{
		// naechste seite
		this.page ++;
		// neue daten laden
		doLoad();
	}

	private function showClips(aClips:Collection ):Void
	{
		// einblenden
		_visible = true;
		// clips
		this.clips = aClips;
		// liste aufbauen
		initList();
		// scrollen verfolgen
		onEnterFrame = followMouse;
	}

	private function hideClips():Void
	{
		// ausblenden
		_visible = false;
		// resetten
		reset();
		// scrollen verfolgen beenden
		delete(onEnterFrame);
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
		// aktueller clip
		var clip:Clip;
		// selector auf buehne
		var ui:ClipselectorUI;
		// position des selectors auf buehne
		var pos:Point = new Point(-LISTWIDTH, 0);
		// schleife ueber alle clips
		for (var i:Number = 0; i < Math.min(COUNT, this.clips.getLength()); i++) {
			// clip
			clip = Clip(this.clips.getItemAt(i));
			// auf buehne bringen
			ui = addSelector(clip, pos, i);
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
		// alle selectors von buehne loeschen
		for (var i:String in this.selectoruis) {
			// loeschen
			ClipselectorUI(this.selectoruis[i]).removeMovieClip();
		}
		// array mit selectors leeren
		this.selectoruis.splice();
		// liste loeschen
		list_mc.removeMovieClip();
		// maske loeschen
		mask_mc.removeMovieClip();
	}

	/**
	 * fuegt ein movieclip fuer ein selector hinzu
	 * @param selector selector, das auf der buehne angezeigt werden soll
	 */
	private function addSelector(clip:Clip, pos:Point, id:Number ):ClipselectorUI
	{
		// movieclip
		var ui:ClipselectorUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// clip
		constructor._clip = clip;
		// auf buehne
		ui = ClipselectorUI(list_mc.attachMovie("ClipselectorUI", "selector" + id + "_mc", list_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit selectors auf buehne
		this.selectoruis[id] = ui;
		// zurueck geben
		return ui;
	}

	private function showButtons(aPrev:Boolean, aNext:Boolean ):Void
	{
		// vorherige seite
		prev_btn._visible = aPrev;
		// naechste seite
		next_btn._visible = aNext;
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

}