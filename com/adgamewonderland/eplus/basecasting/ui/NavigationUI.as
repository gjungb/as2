import mx.transitions.easing.Strong;
import mx.transitions.Tween;
import mx.utils.Collection;

import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.CityselectorUI;
import com.adgamewonderland.eplus.basecasting.ui.HeadlineUI;

import flash.geom.Point;
import mx.utils.Delegate;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.NavigationUI extends MovieClip implements IApplicationControllerListener {

	private static var LISTX:Number = 22;

	private static var LISTY:Number = 119;

	private static var LISTWIDTH:Number = 210;

	private static var LISTHEIGHT:Number = 320;

	private static var SELECTORXDIFF:Number = 0;

	private static var SELECTORYDIFF:Number = 5;

	public static var TWEENDELAY:Number = 100;

	public static var TWEENDURATION:Number = 0.2;

	private var cities:Collection;

	private var selectoruis:Array;

	private var list_mc:MovieClip;

	private var headline_mc:HeadlineUI;

	private var home_btn:Button;

	public function NavigationUI() {
		// ausblenden
		_visible = false;
	}

	public function onLoad():Void
	{
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);
		// home
		home_btn.onRelease = Delegate.create(this, doHome);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);
	}

	public function onStateChanged(aState:String, aNewstate:String ):Void
	{
		// einblenden
		_visible = true;
		// je nach neuem state
		switch (aNewstate) {
			// startseite
			case ApplicationController.STATE_START :
				// home ausblenden
				home_btn._visible = false;
				// headline anzeigen
				headline_mc.showHeadline(0);
				// staedte sortiert nach namen
				this.cities = CitiesController.getInstance().getSortedCities("name");
				// staedte navigation aufbauen
				initList();

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// liste resetten
				reset();
				// home einblenden
				home_btn._visible = true;
				// aktuelle stadt
				var city:CityImpl = CitiesController.getInstance().getCurrentcity();
				// headline anzeigen
				headline_mc.showHeadline(city.getID());

				break;
		}
	}

	public function onStateChangeInited(aState : String, aNewstate : String) : Void {
	}

	public function doHome():Void
	{
		// zur startseite
		ApplicationController.getInstance().selectCity(null);
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
		// aktuelle city
		var city:CityImpl;
		// selector auf buehne
		var ui:CityselectorUI;
		// position des selectors auf buehne
		var pos:Point = new Point(0, 0);
		// schleife ueber alle cities
		for (var i:Number = 0; i < this.cities.getLength(); i++) {
			// city
			city = CityImpl(this.cities.getItemAt(i));
			// auf buehne bringen
			ui = addSelector(city, pos, i);
			// tweenen
			ui.tweenInSelector(i * TWEENDELAY, Strong.easeOut, TWEENDURATION);
			// naechste position berechnen
			pos.offset(SELECTORXDIFF, Math.floor(ui._height + SELECTORYDIFF));
		}
	}

	private function reset():Void
	{
		// alle selectors von buehne loeschen
		for (var i:String in this.selectoruis) {
			// loeschen
			CityselectorUI(this.selectoruis[i]).removeMovieClip();
		}
		// array mit selectors leeren
		this.selectoruis.splice();
		// liste loeschen
		list_mc.removeMovieClip();
	}

	/**
	 * fuegt ein movieclip fuer ein selector hinzu
	 * @param selector selector, das auf der buehne angezeigt werden soll
	 */
	private function addSelector(city:CityImpl, pos:Point, id:Number ):CityselectorUI
	{
		// movieclip
		var ui:CityselectorUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// city
		constructor._city = city;
		// auf buehne
		ui = CityselectorUI(list_mc.attachMovie("CityselectorUI", "selector" + id + "_mc", list_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit selectors auf buehne
		this.selectoruis[id] = ui;
		// zurueck geben
		return ui;
	}

}