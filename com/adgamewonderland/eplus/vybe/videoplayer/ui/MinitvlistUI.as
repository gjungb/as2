import mx.utils.Collection;
import mx.utils.Iterator;

import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.AssetUI;

import flash.geom.Point;
import flash.geom.Rectangle;
import mx.transitions.easing.Strong;
import mx.transitions.Tween;

class com.adgamewonderland.eplus.vybe.videoplayer.ui.MinitvlistUI extends MovieClip
{
	private static var LISTX:Number = 16;

	private static var LISTY:Number = 27;

	private static var LISTWIDTH:Number = 200;

	private static var LISTHEIGHT:Number = 320;

	private static var ASSETXDIFF:Number = 0;

	private static var ASSETYDIFF:Number = 0;

	private static var SCROLLHEIGHT:Number = 120;

	private static var SCROLLSPEED:Number = 8;

	private static var SCROLLDIR_UP:Number = -1;

	private static var SCROLLDIR_DOWN:Number = 1;

	private static var TWEENDURATION:Number = 3;

	private var minitvlist:MinitvlistImpl;

	private var assetuis:Array;

	private var scrolltop:Rectangle;

	private var scrollbottom:Rectangle;

	private var list_mc:MovieClip;

	private var fade_mc:MovieClip;

	private var mask_mc:MovieClip;

	private var name_txt:TextField;

	public function MinitvlistUI()
	{
		// anzuzeigende minitvlist
		this.minitvlist = null;
		// ausblenden
		_visible = false;
		// scrollsensitive flaeche am oberen rand
		this.scrolltop = new Rectangle(LISTX, LISTY, LISTWIDTH, SCROLLHEIGHT);
		// scrollsensitive flaeche am unteren rand
		this.scrollbottom = new Rectangle(LISTX, LISTY + LISTHEIGHT - SCROLLHEIGHT, LISTWIDTH, SCROLLHEIGHT);
	}

	public function showMinitvlist(minitvlist:MinitvlistImpl ):Void
	{
		// einblenden
		_visible = true;
		// anzuzeigende minitvlist
		this.minitvlist = minitvlist;
		// liste aufbauen
		initList();
		// scrollen verfolgen
		onEnterFrame = followMouse;
	}

	public function hideMinitvlist():Void
	{
		// liste resetten
		reset();
		// ausblenden
		_visible = false;
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

	private function initList():Void
	{
		// name
		name_txt.text = this.minitvlist.getName() + " (" + this.minitvlist.getAssetsCount() + ")";
		// liste mit assets auf buehne
		list_mc = this.createEmptyMovieClip("list_mc", getNextHighestDepth());
		// positionieren
		list_mc._x = LISTX;
		list_mc._y = LISTY;
		// array mit assets auf buehne
		this.assetuis = new Array();
		// alle assets aus repository
		var assets:Collection = this.minitvlist.getAssets();
		// aktuelles asset
		var asset:AssetImpl;
		// asset auf buehne
		var ui:AssetUI;
		// position des assets auf buehne
		var pos:Point = new Point(0, 0);
		// counter
		var id:Number = 0;
		// schleife ueber alle assets
		var iterator:Iterator = assets.getIterator();
		while (iterator.hasNext()) {
			// asset
			asset = AssetImpl(iterator.next());
			// auf buehne bringen
			ui = addAsset(asset, pos, ++id);
			// naechste position berechnen
			pos.offset(ASSETXDIFF, ui._height + ASSETYDIFF);
		}
		// maske fuer liste der assets auf buehne
		var mask:Mask = new Mask(this, list_mc, new com.adgamewonderland.agw.math.Rectangle(LISTX, LISTY, LISTWIDTH, LISTHEIGHT));
		// maskieren
		mask.drawMask();
		// fader einblenden
		// vor die liste positionieren
		fade_mc.swapDepths(list_mc.getDepth() + 1);
		// was soll gewteent werden
		var prop:String = "_alpha";
		// startwert
		var begin:Number = 100;
		// endwert
		var finish:Number = 0;
		// neuer tween
		var tween:Tween = new Tween(fade_mc, prop, Strong.easeOut, begin, finish, TWEENDURATION, true);
	}

	private function reset():Void
	{
		// alle assets von buehne loeschen
		for (var i:String in this.assetuis) {
			// loeschen
			AssetUI(this.assetuis[i]).removeMovieClip();
		}
		// array mit assets leeren
		this.assetuis.splice();
		// liste loeschen
		list_mc.removeMovieClip();
		// maske loeschen
		mask_mc.removeMovieClip();
	}

	/**
	 * fuegt ein movieclip fuer ein asset hinzu
	 * @param asset asset, das auf der buehne angezeigt werden soll
	 */
	private function addAsset(asset:AssetImpl, pos:Point, id:Number ):AssetUI
	{
		// movieclip
		var ui:AssetUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// asset
		constructor._asset = asset;
		// auf buehne
		ui = AssetUI(list_mc.attachMovie("AssetUI", "asset" + id + "_mc", list_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit assets auf buehne
		this.assetuis[id] = ui;
		// zurueck geben
		return ui;
	}

}