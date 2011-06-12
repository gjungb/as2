import mx.transitions.easing.Strong;
import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.interfaces.IChapterMenuListener;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuUI;
import com.adgamewonderland.agw.util.ScrollbarUI;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuSmallUI extends ChapterMenuUI implements IPresentationControllerListener, IChapterMenuListener {

	private static var STATES_VISIBLE:Array = [PresentationState.STATE_PLAYLIST];

	private static var STATE_HIDDEN:Number = 1;

	private static var STATE_VISIBLE:Number = 2;

	private static var DIRECTION_IN:Number = 1;

	private static var DIRECTION_OUT:Number = -1;

	private static var TOGGLE_DELAY:Number = 2000;

	private var menu:Array;

	private var elements:Array;

	private var state:Number;

	private var changing:Boolean;

	private var interval:Number;

	private var back_mc:MovieClip;

	private var border_mc:MovieClip;

	private var toggle_btn:Button;

	private var scrollbar_mc:ScrollbarUI;

	public function ChapterMenuSmallUI() {
		// aktuelles menu <String>
		this.menu = new Array();
		// aktueller zustand (ein- / ausgeblendet)
		this.state = STATE_HIDDEN;
		// elemente, die rein- / rausgefahren werden können
		this.elements = new Array();
		// aktueller zustand (ein- / ausgeblendet)
		this.state = STATE_HIDDEN;
		// wird gerade rein- / rausgefahren
		this.changing = false;
		// button ein- / ausblenden
		toggle_btn.onRelease = Delegate.create(this, doToggle);
		// ausblenden
		_visible = false;
	}

	public function onLoad():Void
	{
		// maske aufbauen
		super.onLoad();
		// maske nach oben umdrehen
		mask_mc._y = -mask_mc._height;
//		// rand vor die liste (maskierung geht kaputt)
//		border_mc.swapDepths(list_mc.getDepth() + 1);
		// elemente, die rein- / rausgefahren werden können
		this.elements = new Array(back_mc, border_mc, mask_mc);
		// scrollbar ausblenden
		scrollbar_mc._visible = false;
	}

	/**
	 * schaltet das rein- /rausfahren um
	 */
	public function doToggle():Void
	{
		// interval loeschen
		clearInterval(this.interval);
		// mausbewegung verfolgen beenden
		delete(onEnterFrame);
		// abbrechen, wenn in bewegung
		if (isChanging()) return;
		// je nach aktuellem status
		switch (getState()) {
			// ausgeblendet
			case STATE_HIDDEN :
				// aktuelles video anhalten
				VideoController.getInstance().stopVideo();
				// menitems einblenden
				showMenuitems(getMenu());
				// reinfahren
				tweenElements(DIRECTION_IN);
				// mausbewegung verfolgen
				onEnterFrame = followMouse;

				break;
			// eingeblendet
			case STATE_VISIBLE :
				// items rausfahren und von buehne loeschen
				resetMenuitems();
				// array mit menuitems leeren
				this.menuitemuis = new Array();
				// rausfahren
				tweenElements(DIRECTION_OUT);

				break;
		}
	}

	/**
	 * schaltet den status nach erfolgtem tween um
	 */
	public function toggleState():Void
	{
		// nicht in bewegung
		setChanging(false);
		// umschalten
		if (getState() == STATE_HIDDEN)  {
			setState(STATE_VISIBLE);
		} else if (getState() == STATE_VISIBLE) {
			setState(STATE_HIDDEN);
		}
	}

	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
		// sichtbarkeit umschalten
		setVisibility(newstate);
		// playlist
		if (newstate.equals(PresentationState.STATE_PLAYLIST)) {
			// menuitems <String>
			setMenu(data.toMenueArray());
		} else {
			// leer
			setMenu(new Array());
		}
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
	}

	/**
	 * callback nach klick auf ein menuitem
	 */
	public function onChapterMenuItemSelected(index:Number ):Void
	{
		// ausblenden
		doToggle();
		// entsprechendes item abspielen
		VideoController.getInstance().gotoItem(index);
	}

	/**
	 * callback nach abbau des menu
	 */
	public function onChapterMenuDestroyed(doswitch:Boolean ):Void
	{
	}

	public function setMenu(menu:Array ):Void
	{
		this.menu = menu;
	}

	public function getMenu():Array
	{
		return this.menu;
	}

	public function setState(state:Number ):Void
	{
		this.state = state;
	}

	public function getState():Number
	{
		return this.state;
	}

	public function setChanging(changing:Boolean ):Void
	{
		this.changing = changing;
	}

	public function isChanging():Boolean
	{
		return this.changing;
	}

	/**
	 * menuitems auf buehne bringen
	 */
	private function showMenuitems(menuitems:Array ):Void
	{
		super.showMenuitems(menuitems);
		// scrollbar aktivieren
		scrollbar_mc.setScrollTarget(list_mc);
	}

	/**
	 * menuitems rausfahren und von buehne loeschen
	 */
	private function resetMenuitems():Void
	{
		super.resetMenuitems();
		// scrollbar ausblenden
		scrollbar_mc._visible = false;
	}

	/**
	 * setzt die sichtbarkeit je nach state der presentation
	 * @param state aktueller state der presentation
	 */
	private function setVisibility(state:PresentationState ):Void
	{
		// schleife ueber states, bei denen sichtbarkeit true sein soll
		for (var i:String in STATES_VISIBLE) {
			// testen, ob state in array
			if (state.equals(STATES_VISIBLE[i])) {
				// einblenden
				_visible = true;
				// abbrechen
				return;
			}
		}
		// ausblenden
		_visible = false;
	}

	/**
	 * tweenhoehe abhaengig von anzahl der menuitems
	 */
	private function getTweenheight():Number
	{
		// bis unterkante der liste
		return _listposy + Math.min(_listheight, list_mc._height); // list_mc._y + list_mc._height;
	}

	/**
	 * maske und hintergrund rein- / rausfahren
	 * @param direction richtung (siehe DIRECTION_)
	 */
	private function tweenElements(direction:Number ):Void
	{
		// auszufuehrende methode
		var method:Function;
		// je nach richtung
		switch (direction) {
			// rein
			case DIRECTION_IN :
				method = tweenIn;
				break;
			// raus
			case DIRECTION_OUT :
				method = tweenOut;
				break;
			// unbekannt
			default :
				// abbrechen
				return;
		}
		// in bewegung
		setChanging(true);
		// schleife ueber elemente des aktuellen modus
		for (var i:Number = 0; i < this.elements.length; i++) {
			// aktuelles element
			var mc:MovieClip = this.elements[i];
			// tweenen
			method.apply(this, [mc, i]);
		}
	}

	/**
	 * ein movieclip reinfahren
	 * (hier bitte parameter anpassen)
	 * @param mc
	 * @param index
	 */
	private function tweenIn(mc:MovieClip, index:Number ):Void
	{
		// was soll gewteent werden
		var prop:String = "_y";
		// wie soll gewteent werden
		var func:Function = Strong.easeOut;
		// startwert
		var begin:Number = mc._y;
		// endwert
		var finish:Number = mc._y + getTweenheight();
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		if (index == this.elements.length - 1) {
			tween.onMotionFinished = Delegate.create(this, toggleState);
		}
	}

	/**
	 * ein movieclip rausfahren
	 * (hier bitte parameter anpassen)
	 * @param mc
	 * @param index
	 */
	private function tweenOut(mc:MovieClip, index:Number ):Void
	{
		// was soll gewteent werden
		var prop:String = "_y";
		// wie soll gewteent werden
		var func:Function = Strong.easeIn;
		// startwert
		var begin:Number = mc._y;
		// endwert
		var finish:Number = mc._y - getTweenheight();
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		if (index == this.elements.length - 1) {
			tween.onMotionFinished = Delegate.create(this, toggleState);
		}
	}

	/**
	 * mausbewegung verfolgen und ggf. menu einklappen
	 */
	private function followMouse():Void
	{
		// mausposition
		var mousepos:Point = new Point(_xmouse, _ymouse);
		// menuflaeche
		var hitarea:Rectangle = new Rectangle(0, 0, _width, (_listposy + _listheight) * 1.2);
		// testen, ob maus in hitarea
		if (hitarea.containsPoint(mousepos)) {
			// interval loeschen
			clearInterval(this.interval);

		} else {
			// mausbewegung verfolgen beenden
			delete(onEnterFrame);
			// nach pause rausfahren
			this.interval = setInterval(this, "doToggle", TOGGLE_DELAY, this);
		}
	}

}