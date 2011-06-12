import mx.utils.Delegate;import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
class com.adgamewonderland.eplus.base.tarifberater.ui.ErgebnisUI extends MovieClip implements IApplicationCtrlLsnr {
	
	private var warenkorb_btn : Button;
	
	public function ErgebnisUI() {
		// buttons initialisieren
		warenkorb_btn.onRelease = Delegate.create(this, onWarenkorb);
		// ausblenden
		this._visible = false;
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
	}

	public function onAendereGroesse(aSizable : ISizable) : Void {
	}

	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand) : Void {
		// ein- / ausblenden
		this._visible = aSichtbar;
		// anzeigen
		if (aSichtbar)
			zeigeWarenkorb(aWarenkorb);
	}
	
	/**
	 * Zeigt die Inhalte des Warenkorbs an
	 * @param aWarenkorb
	 */
	private function zeigeWarenkorb(aWarenkorb : Warenkorb ) : Void {
		// bestellen nur bei tarifen
		var bestellbar : Boolean = aWarenkorb.getTarife().isEmpty() == false;
		// button ein- / ausblenden
		warenkorb_btn._visible = bestellbar;
		// tarif- / tarifoption anzeigen
		var frame : String = "";
		// unterscheidung tarif- / tarifoption
		if (bestellbar) {
			frame = IProdukt(aWarenkorb.getTarife().getItemAt(0)).getId();
		} else {
			frame = IProdukt(aWarenkorb.getTarifoptionen().getItemAt(0)).getId();	
		}
		// hinspringen
//		trace(frame);
		gotoAndStop(frame);
	}

	private function onWarenkorb() : Void {
		ApplicationController.getInstance().warenkorbAction();
	}
}