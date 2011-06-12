
/** * @author gerd */import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.beans.Rechnungsrabatt;
import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnlineVorteil;

import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.ui.ProduktinfosUI extends MovieClip implements IApplicationCtrlLsnr {

	private var schliessen_btn : Button;
	
	private var back_mc : MovieClip;
	
	private var infos_mc : MovieClip;
	
	private var produkt : IProdukt;
	public function ProduktinfosUI() {
		// schliessen button
		schliessen_btn.onRelease = Delegate.create(this, onSchliessen);
		// hintergrund als button
		back_mc.onRelease = function() : Void {
		};
		back_mc.useHandCursor = false;
		// deaktivieren
		setActive(false);
	}

	public function onLoad() : Void {
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);	
	}
	
	public function onUnload() : Void {
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);	
	}
	
	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
		// produkt
		this.produkt = aProdukt;
		// frame abhaengig vom onine vorteil
		var frame : String = aProdukt.getId();
//		// sonderbehandlung base 2 / base 5 je nach online vorteil
//		if (ApplicationController.getInstance().getTarifberater().getWarenkorb().isProduktEnthalten(AbstractProdukt.getProdukt(BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT))) {
//			switch (aProdukt.getId()) {
//				case BeraterTarif.BASE2 :
//				case BeraterTarif.BASE5 :
//					frame += "_" + BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT;
//					break;
//			}
//		} else if (ApplicationController.getInstance().getTarifberater().getWarenkorb().isProduktEnthalten(AbstractProdukt.getProdukt(BeraterOnlineVorteil.ONLINEVORTEIL_SMS))) {
//			switch (aProdukt.getId()) {
//				case BeraterTarif.BASE2 :
//				case BeraterTarif.BASE5 :
//					frame += "_" + BeraterOnlineVorteil.ONLINEVORTEIL_SMS;
//					break;
//			}
//		}
//		trace(frame);
		// hinspringen
		gotoAndStop(frame);
		// animation
		doTween(0, 100, ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION, true);
		// button positionieren
		schliessen_btn._x = infos_mc._x + infos_mc._width - schliessen_btn._width - 4;
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
	}
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void {
	}

	/**
	 * Ermittelt Preis für das aktuelle Produkt
	 */
	public function getPreismonatlich() : Number {
		// preis des produkts unter beruecksichtigung des rechnugsrabattes
		var preis : Number = getProdukt().getPreismonatlich();
		// wenn das produkt bereits im wk liegt, dessen preis zurueck geben
		if (ApplicationController.getInstance().getTarifberater().getWarenkorb().isProduktEnthalten(getProdukt()))
			return preis;
		// rechnungsrabatt
		if (ApplicationController.getInstance().getTarifberater().getWarenkorb().isProduktEnthalten(AbstractProdukt.getProdukt(BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT))) {
			// reduzierter preis
			preis = new Rechnungsrabatt(getProdukt()).getPreismonatlich();
		}
		// zurueck geben
		return preis;
	}
	
	public function getProdukt() : IProdukt {
		return this.produkt;
	}
	
	/**
	 * Aktivität von Button und Hintergrund
	 * @param aActive
	 */
	private function setActive(aActive : Boolean ) : Void {
		// button
		schliessen_btn._visible = aActive;
		// hintergund
		back_mc._visible = aActive;
	}
	
	/**
	 * Callback bei Drücken von Schliessen
	 */
	private function onSchliessen() : Void {
		// zurueck
		gotoAndStop(1);
		// animation
		doTween(100, 00, ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION, false);
	}

	/**
	 * Ändert Alpha des Hintergrunds mittels Tweening
	 * @param aStart Startalpha
	 * @param aEnd Endalpha
	 * @param aDuration Dauer in s
	 */
	private function doTween(aStart : Number, aEnd : Number, aFunction : Function, aDuration : Number, aActive : Boolean ) : Void {
		// tween fur alpha
		var t1 : Tween = new Tween(this, "_alpha", aFunction, aStart, aEnd, aDuration, true);
		// de- / aktivieren
		setActive(aActive);
	}
}