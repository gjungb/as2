import mx.transitions.easing.Strong;
import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.ui.presentation.BorderUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.LogoUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationVideocontrollerUI;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationControllerUI extends MovieClip implements IPresentationControllerListener {

	private static var MODE_INACTIVE:Number = 1;

	private static var MODE_SHORT:Number = 2;

	private static var MODE_LONG:Number = 3;

	private static var STATE_HIDDEN:Number = 1;

	private static var STATE_VISIBLE:Number = 2;

	private static var DIRECTION_IN:Number = 1;

	private static var DIRECTION_OUT:Number = -1;

	private static var TWEENWIDTH_SHORT:Number = 200;

	private static var TWEENWIDTH_LONG:Number = 420;

	private static var TOGGLE_DELAY:Number = 5000;

	private static var KEY_CANCEL:Number = Key.ESCAPE;

	private static var KEY_UP:Number = Key.UP;

	private static var KEY_FULLSCREEN:Number = "F".charCodeAt(0);

	private static var KEY_NEXT:Number = Key.SPACE;

	private var logo_mc:LogoUI;

	private var up_btn:Button;

	private var fullscreen_btn:Button;

	private var videocontroller_mc:PresentationVideocontrollerUI;

	private var border_mc:BorderUI;

	private var elements:Array;

	private var mode:Number;

	private var state:Number;

	private var changing:Boolean;

	private var interval:Number;

	public function PresentationControllerUI() {
		// elemente, die rein- / rausgefahren werden können
		this.elements = new Array();
		// je mach modus
		this.elements[MODE_INACTIVE] = [];
		this.elements[MODE_SHORT] = [up_btn, border_mc, fullscreen_btn];
		this.elements[MODE_LONG] = [up_btn, videocontroller_mc, border_mc, fullscreen_btn];
		// aktueller modus (inaktiv, kurz, lang)
		this.mode = MODE_INACTIVE;
		// aktueller zustand (ein- / ausgeblendet)
		this.state = STATE_HIDDEN;
		// wird gerade rein- / rausgefahren
		this.changing = false;
	}

	public function onLoad():Void
	{
		// beim presentationcontroller als listener registrieren
		PresentationController.getInstance().addListener(this);
		// als key listener registrieren
		Key.addListener(this);
		// rein- / rausfahren bei klick auf logo
		logo_mc.onRelease = Delegate.create(this, doToggle);
		// klick deaktivieren
		logo_mc.setEnabled(false);
		// button eine ebene hoeher
		up_btn.onRelease = Delegate.create(this, doUp);
		// fullscreen umschalten
		fullscreen_btn.onRelease = Delegate.create(this, doFullscreen);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		PresentationController.getInstance().removeListener(this);
		// als key listener deregistrieren
		Key.removeListener(this);
	}

	/**
	 * callback nach mausklick
	 */
	public function onMouseUp():Void
	{
		// zum naechsten state
		doNextstate();
	}

	/**
	 * callback nach tastendruck
	 */
	public function onKeyDown():Void
	{
		// zuletzt gedrueckte taste
		var code:Number = Key.getCode();
		// je nach taste
		switch (code) {
			// cancel
			case KEY_CANCEL :
				// presentation beenden
				PresentationController.getInstance().stopPresentation();

				break;
			// up
			case KEY_UP :
				doUp();

				break;
			// fullscreen
			case KEY_FULLSCREEN :
				doFullscreen();

				break;
			// start
			case KEY_NEXT :
				// zum naechsten state
				doNextstate();

				break;
		}
	}

	/**
	 * schaltet das rein- /rausfahren um
	 */
	public function doToggle():Void
	{
		// interval loeschen
		clearInterval(this.interval);
		// abbrechen, wenn inaktiv
		if (getMode() == MODE_INACTIVE) return;
		// abbrechen, wenn in bewegung
		if (isChanging()) return;
		// glow um logo anzeigen
		logo_mc.showGlow();
		// je nach aktuellem status
		switch (getState()) {
			// ausgeblendet
			case STATE_HIDDEN :
				// reinfahren
				tweenElements(DIRECTION_IN);
				// nach pause rausfahren
				this.interval = setInterval(this, "doToggle", TOGGLE_DELAY, this);

				break;
			// eingeblendet
			case STATE_VISIBLE :
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
		// ggf. ausblenden
		if (getState() == STATE_VISIBLE) {
			doToggle();
		}
		// je nach neuem state
		switch (newstate) {
			// warteloop
			case PresentationState.STATE_WAITING :
				// modus inaktiv
				setMode(MODE_INACTIVE);

				break;

			// modus kurz
			case PresentationState.STATE_TRAILER :
			case PresentationState.STATE_TRAILERLOOP :
			case PresentationState.STATE_TRANSITION :
			case PresentationState.STATE_MENUCREATE :
			case PresentationState.STATE_MENUDESTROY :
			case PresentationState.STATE_FINISHED :
				// logo klickbar
				logo_mc.setEnabled(true);
				// modus kurz
				setMode(MODE_SHORT);

				break;

			// modus lang
			default :
				// logo klickbar
				logo_mc.setEnabled(true);
				// modus lang
				setMode(MODE_LONG);
		}
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
	}

	public function onToggleFullscreen(bool:Boolean ):Void
	{
		// bei fullscreen ausblenden
		if (bool) {
			// ausblenden
			_visible = false;

		} else {
			// einblenden
			_visible = true;
		}
	}

	public function setMode(mode:Number ):Void
	{
		// videocontroller je nach modus de- / aktivieren
		videocontroller_mc.setActive(mode == MODE_LONG);

		this.mode = mode;
	}

	public function getMode():Number
	{
		return this.mode;
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
	 * zu tweenende elemente je nach modus
	 */
	private function getElements():Array
	{
		// elemente des aktuellen modus
		return this.elements[getMode()];
	}

	/**
	 * tweenbreite je nach aktuellem modus
	 */
	private function getTweenwidth():Number
	{
		//je nach modus
		switch (getMode()) {
			case MODE_INACTIVE :
				return 0;
			case MODE_SHORT :
				return TWEENWIDTH_SHORT;
			case MODE_LONG :
				return TWEENWIDTH_LONG;
		}
	}

	/**
	 * alle elemente bis auf das logo rein- / rausfahren
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

				// je nach modus elemente auf buehne positionieren
				if (getMode() == MODE_LONG) {
					// up ganz nach links
					up_btn._x = videocontroller_mc._x - 50;
				}
				if (getMode() == MODE_SHORT) {
					// up ganz nach rechts
					up_btn._x = fullscreen_btn._x - 70;
				}

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
		for (var i:Number = 0; i < getElements().length; i++) {
			// aktuelles element
			var mc:MovieClip = getElements()[i];
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
		var prop:String = "_x";
		// wie soll gewteent werden
		var func:Function = Strong.easeOut;
		// startwert
		var begin:Number = mc._x;
		// endwert
		var finish:Number = mc._x + getTweenwidth();
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		if (index == getElements().length - 1) {
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
		var prop:String = "_x";
		// wie soll gewteent werden
		var func:Function = Strong.easeIn;
		// startwert
		var begin:Number = mc._x;
		// endwert
		var finish:Number = mc._x - getTweenwidth();
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		if (index == getElements().length - 1) {
			tween.onMotionFinished = Delegate.create(this, toggleState);
		}
	}

	/**
	 * fullscreen umschalten
	 */
	private function doFullscreen():Void
	{
		// nicht im menu
		if (PresentationState.STATE_MENUCREATE.equals(PresentationController.getInstance().getCurrentstate())) {
			// abbrechen
			return;
		}
		// umschalten
		PresentationController.getInstance().setFullscreen(PresentationController.getInstance().isFullscreen() == false);
	}

	/**
	 * presentation in den naechsten state schalten
	 * abhaengig vom aktuellen state
	 */
	private function doNextstate():Void
	{
		// je nach aktuellem state
		switch (PresentationController.getInstance().getCurrentstate()) {
			// bestimmte states sind erlaubt
			case PresentationState.STATE_WAITING :
			case PresentationState.STATE_TRAILER :
			case PresentationState.STATE_TRAILERLOOP :
				// zum naechsten state
				PresentationController.getInstance().nextState();

			break;
		}
	}

	/**
	 * aktuellen zweig der presentation anhalten
	 */
	private function doUp():Void
	{
		// aktuellen zweig anhalten
		PresentationController.getInstance().stopBranch();
	}

}