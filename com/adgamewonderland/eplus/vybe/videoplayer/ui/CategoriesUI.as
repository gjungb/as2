import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.SelectorUI;

import flash.geom.Point;
import mx.transitions.easing.Strong;
import mx.transitions.Tween;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.ui.CategoriesUI extends MovieClip {

	private static var LISTX:Number = 18;

	private static var LISTY:Number = 22;

	private static var LISTWIDTH:Number = 210;

	private static var LISTHEIGHT:Number = 320;

	private static var SELECTORXDIFF:Number = 0;

	private static var SELECTORYDIFF:Number = 0;

	private static var TWEENDELAY:Number = 150;

	private static var TWEENDURATION:Number = 0.3;

	private var categories:Array;

	private var selectoruis:Array;

	private var list_mc:MovieClip;

	private var footer_mc:MovieClip;

	private var mask_mc:MovieClip;

	public function CategoriesUI() {
		// verfuegbare kategorien
		this.categories = new Array();
		// footer ausblenden
		footer_mc._visible = false;
		// ausblenden
		_visible = false;
	}

	public function showCategories(categories:Array ):Void
	{
		// einblenden
		_visible = true;
		// verfuegbare kategorien
		this.categories = categories;
		// liste aufbauen
		initList();
	}

	public function hideCategories():Void
	{
		// liste resetten
		reset();
		// ausblenden
		_visible = false;
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
		// aktuelle category
		var category:String;
		// selector auf buehne
		var ui:SelectorUI;
		// position des selectors auf buehne
		var pos:Point = new Point(-LISTWIDTH, 0);
		// schleife ueber alle categories
		for (var i:Number = 0; i < this.categories.length; i++) {
			// category
			category = categories[i];
			// auf buehne bringen
			ui = addSelector(category, pos, i);
			// tweenen
			ui.tweenInSelector(i * TWEENDELAY, Strong.easeOut, TWEENDURATION);
			// naechste position berechnen
			pos.offset(SELECTORXDIFF, ui._height + SELECTORYDIFF);
		}
		// maske fuer liste der selectors auf buehne
		var mask:Mask = new Mask(this, list_mc, new com.adgamewonderland.agw.math.Rectangle(LISTX, LISTY, LISTWIDTH, LISTHEIGHT));
		// maskieren
		mask.drawMask();
		// footer einblenden und positionieren
		var interval:Number;
		var doShow:Function = function(mc:MovieClip ):Void  {
			// interval loeschen
			clearInterval(interval);
			// einblenden
			mc._visible = true;
			// positionieren
			mc._y = pos.y;
			// was soll gewteent werden
			var prop:String = "_alpha";
			// startwert
			var begin:Number = 0;
			// endwert
			var finish:Number = 100;
			// neuer tween
			var tween:Tween = new Tween(mc, prop, Strong.easeOut, begin, finish, TWEENDURATION, true);
		};
		interval = setInterval(doShow, TWEENDURATION * 1000 + this.categories.length * TWEENDELAY, footer_mc);
	}

	private function reset():Void
	{
		// alle selectors von buehne loeschen
		for (var i:String in this.selectoruis) {
			// loeschen
			SelectorUI(this.selectoruis[i]).removeMovieClip();
		}
		// array mit selectors leeren
		this.selectoruis.splice();
		// liste loeschen
		list_mc.removeMovieClip();
		// maske loeschen
		mask_mc.removeMovieClip();
		// footer ausblenden
		footer_mc._visible = false;
	}

	/**
	 * fuegt ein movieclip fuer ein selector hinzu
	 * @param selector selector, das auf der buehne angezeigt werden soll
	 */
	private function addSelector(category:String, pos:Point, id:Number ):SelectorUI
	{
		// movieclip
		var ui:SelectorUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// category
		constructor._category = category;
		// auf buehne
		ui = SelectorUI(list_mc.attachMovie("SelectorUI", "selector" + id + "_mc", list_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit selectors auf buehne
		this.selectoruis[id] = ui;
		// zurueck geben
		return ui;
	}

	private function showFooter(ypos:Number ):Void
	{
	}

}