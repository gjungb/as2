import mx.transitions.easing.Strong;

import com.adgamewonderland.agw.math.Rectangle;
import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IChapterMenuListener;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuItemUI;

import flash.geom.Point;
/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuUI extends MovieClip implements IPresentationControllerListener, IChapterMenuListener {

	private static var TWEENDELAY:Number = 100;

	private static var TWEENDURATION:Number = 0.25;

	private var _listposx:Number;

	private var _listposy:Number;

	private var _listwidth:Number;

	private var _listheight:Number;

	private var _indexpos:Number;

	private var _titlepos:Number;

	private var _titlewidth:Number;

	private var _scale:Number;

	private var menuitemuis:Array = new Array();

	private var list_mc:MovieClip;

	private var mask_mc:MovieClip;

	private var mask:Mask;

	private var selectedindex:Number;

	private var interval:Number;

	/**
	 * abstrakter konstruktor
	 */
	private function ChapterMenuUI() {

	}

	public function onLoad():Void
	{
		// beim presentationcontroller als listener registrieren
		PresentationController.getInstance().addListener(this);
		// liste auf buehne
		list_mc = this.createEmptyMovieClip("list_mc", getNextHighestDepth());
		// liste positionieren
		list_mc._x = _listposx;
		list_mc._y = _listposy;
		// maske fuer liste
		this.mask = new Mask(this, list_mc, new Rectangle(_listposx, _listposy, _listwidth, _listheight));
		// maskieren
		this.mask.drawMask();
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		PresentationController.getInstance().removeListener(this);
	}

	/**
	 * abstraktes callback nach jeder aenderung des states der presentation
	 */
	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
	}

	/**
	 * abstraktes callback nach uebergabe eines items an den player
	 */
	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
	}

	public function onToggleFullscreen(bool:Boolean ):Void
	{
	}

	/**
	 * callback nach klick auf ein menuitem
	 */
	public function onChapterMenuItemSelected(index:Number ):Void
	{
	}

	/**
	 * callback nach abbau des menu
	 */
	public function onChapterMenuDestroyed(doswitch:Boolean ):Void
	{
	}

	public function setSelectedindex(selectedindex:Number ):Void
	{
		this.selectedindex = selectedindex;
	}

	public function getSelectedindex():Number
	{
		return this.selectedindex;
	}

	/**
	 * menuitems auf buehne bringen
	 */
	private function showMenuitems(menuitems:Array ):Void
	{
		// liste auf ausgangsposition
		list_mc._x = _listposx;
		list_mc._y = _listposy;
		// array mit menuitems auf buehne
		this.menuitemuis = new Array();
		// aktuelles menuitem
		var menuitem:String;
		// menuitem auf buehne
		var ui:ChapterMenuItemUI;
		// position des menuitems auf buehne
		var pos:Point = new Point(-_listwidth, 0);
		// schleife ueber alle menuitems
		for (var i:Number = 0; i < menuitems.length; i++) {
			// menuitem
			menuitem = menuitems[i];
			// auf buehne bringen
			ui = addMenuitem(i, menuitem, pos);
			// tweenen
			ui.tweenInMenuitem(i * TWEENDELAY, Strong.easeOut, TWEENDURATION);
			// nach unten
			pos.offset(0, ui._height);
		}
	}

	/**
	 * menuitems rausfahren und von buehne loeschen
	 */
	private function resetMenuitems():Void
	{
		// menuitem auf buehne
		var ui:ChapterMenuItemUI;
		// schleife ueber alle menuitems
		for (var i:Number = this.menuitemuis.length - 1; i >= 0 ; i--) {
			// menuitem auf buehne
			ui = this.menuitemuis[i];
			// rausfahren und loeschen
			ui.tweenOutMenuitem(Strong.easeIn, i * TWEENDELAY, TWEENDURATION);
		}
	}

	/**
	 * fuegt ein movieclip fuer ein menuitem hinzu
	 * @param index index des items in der liste der items
	 * @param title anzuzeigender text
	 * @param pos position auf der buehne
	 * @return menuitem menuitem, das auf der buehne angezeigt werden soll
	 */
	private function addMenuitem(index:Number, title:String, pos:Point ):ChapterMenuItemUI
	{
		// movieclip
		var ui:ChapterMenuItemUI;
		// konstruktor
		var constructor:Object = getItemConstructor(index, title, pos);
		// auf buehne
		ui = ChapterMenuItemUI(list_mc.attachMovie("ChapterMenuItemUI", "menuitem" + index + "_mc", list_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit menuitems auf buehne
		this.menuitemuis[index] = ui;
		// zurueck geben
		return ui;
	}

	/**
	 * erstellt einen constructor mit den passenden parametern fuer ein menuitem
	 * @param index index des items in der liste der items
	 * @param title anzuzeigender text
	 * @param pos position auf der buehne
	 * @return object
	 */
	private function getItemConstructor(index:Number, title:String, pos:Point ):Object
	{
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// listner
		constructor._listener = this;
		// index
		constructor._index = index;
		// title
		constructor._title = title;
		// indexpos
		constructor._indexpos = _indexpos;
		// titlepos
		constructor._titlepos = _titlepos;
		// titlewidth
		constructor._titlewidth = _titlewidth;
		// scale
		constructor._scale = _scale;
		// showback bei jedem 2.ten
		constructor._showback = index % 2 == 1;
		// zurueck geben
		return constructor;

	}

}