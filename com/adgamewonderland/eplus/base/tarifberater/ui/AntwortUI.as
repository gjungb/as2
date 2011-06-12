/**
 * @author gerd
 */
import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.ui.AntworttextUI;

class com.adgamewonderland.eplus.base.tarifberater.ui.AntwortUI extends MovieClip {
	
	private var _antwort : Antwort;

	private var produkt : IProdukt;

	private var auswaehlen_btn : Button;
	
	private var infos_btn : Button;
	
	private var text_mc : AntworttextUI;
	
	private var back_mc : MovieClip;

	public function AntwortUI() {
		// ausblenden
		this._alpha = 0;
	}

	public function onLoad() : Void {
		// zugeordnetes produkt anhand komponentenparameter
		this.produkt = ApplicationController.getInstance().getTarifberater().getProdukt(_antwort.getTyp(), _antwort.getName());
		// TODO: errorhandling
		if (this.produkt == null)
			trace("AntwortUI >>> onLoad: Kein Produkt zugeordnet zu " + this);
			
		// auswaehlen button
		auswaehlen_btn.onRelease = Delegate.create(this, onAuswaehlen);
		// de- / aktivieren
		auswaehlen_btn._visible = ApplicationController.getInstance().getAutomat().produktWaehlenMoeglich(this.produkt);
 
		// infos button
		infos_btn._visible = false;
		infos_btn.onRelease = Delegate.create(this, onInfos);
		
		// interval
		var interval : Number;
		// nach pause text und infos initialisieren
		var doInit : Function = function(mc : AntworttextUI, antwort : Antwort, btn : Button, vis : Boolean ) : Void {
			// text anzeigen
			mc.zeigeText(antwort);
			// button einblenden
			btn._visible = vis;
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause initialisieren
		interval = setInterval(doInit, back_mc._totalframes / 25 * 1000, text_mc, _antwort, infos_btn, this.produkt.getInfos());
	}

	/**
	 * reinfahren
	 * @param delay verzoegerung [ms] bis zum start des tweens
	 * @param func function des tweens @see mx.transitions.easing.*
	 * @param duration dauer des tweens [s]
	 */
	public function tweenInAntwort(delay:Number, func:Function, duration:Number ):Void
	{
		// interval
		var interval:Number;
		// nach pause reinfahren
		var doTween:Function = function(func:Function, mc : AntwortUI, duration:Number ):Void {
			// reinfahren
			mc.tweenIn(func, mc, duration);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause reinfahren
		interval = setInterval(doTween, delay, func, this, duration);
	}
	public function onUnload() : Void {
	}

	/**
	 * ein movieclip reinfahren
	 * (hier bitte parameter anpassen)
	 * @param func
	 * @param mc
	 * @param index
	 */
	private function tweenIn(func:Function, mc:MovieClip, duration:Number ):Void
	{
		// was soll gewteent werden
		var prop:String = "_alpha";
		// startwert
		var begin:Number = _alpha;
		// endwert
		var finish:Number = 100;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
//		tween.onMotionFinished = Delegate.create(this, toggleState);
		// hintergrund reinfahren
		back_mc.gotoAndPlay("frIn");
	}
	
	/**
	 * Callback nach Drücken des Auswählen Buttons
	 */
	private function onAuswaehlen() : Void {
		// step setzen
		this.produkt.setStep(_antwort.getStep());
		// controller informieren
		ApplicationController.getInstance().waehlenAction(this.produkt);
	}
	
	/**
	 * Callback nach Drücken des Infos Button
	 */
	private function onInfos() : Void {
		// controller informieren
		ApplicationController.getInstance().zeigeProduktinfos(this.produkt);
	}
}