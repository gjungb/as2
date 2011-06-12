import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.ui.CastingselectorUI;

import flash.geom.Point;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CastinglistUI extends MovieClip {

	private var castings:Array;

	private var selectoruis:Array;

	private var list_mc:MovieClip;

	function CastinglistUI() {
		super();
	}

	private function showDates(aCity:CityImpl ):Void
	{
		// einblenden
		_visible = true;
		// verfuegbare castings
		this.castings = aCity.toCastingsArray();
		// liste aufbauen
		initList();
	}

	private function hideDates():Void
	{
//		// ausblenden
//		_visible = false;
		// resetten
		reset();
	}

	private function initList():Void
	{
	}

	private function reset():Void
	{
		// alle selectors von buehne loeschen
		for (var i:String in this.selectoruis) {
			// loeschen
			CastingselectorUI(this.selectoruis[i]).removeMovieClip();
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
	private function addSelector(casting:CastingImpl, pos:Point, id:Number, showdate:Boolean, hideinactive:Boolean ):CastingselectorUI
	{
		// movieclip
		var ui:CastingselectorUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// casting
		constructor._casting = casting;
		// soll das datum angezeigt werden
		constructor._showdate = showdate;
		// soll inaktives casting deaktiviert werden
		constructor._hideinactive = hideinactive;
		// auf buehne
		ui = CastingselectorUI(list_mc.attachMovie("CastingselectorUI", "selector" + id + "_mc", 16384 - id, constructor)); // list_mc.getNextHighestDepth()
		// hinzufuegen zu array mit selectors auf buehne
		this.selectoruis[id] = ui;
		// zurueck geben
		return ui;
	}

}