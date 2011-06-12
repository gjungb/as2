import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;

import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.ui.FortschrittUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr {
	
	public function FortschrittUI() {
	}

	public function onLoad() : Void {
		// als listener registrieren
		ApplicationController.getInstance().getAutomat().addListener(this);	
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);	
	}
	
	public function onUnload() : Void {
		// als listener deregistrieren
		ApplicationController.getInstance().getAutomat().removeListener(this);	
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);	
	}
	
	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {
		if(aZustand.isEndeZustand())
			this.gotoAndStop(1);
		else {
			// hinspringen
			if (aZustand.getFortschritt() > 0)
				this.gotoAndStop("fr" + aZustand.getFortschritt());
		}
	}

	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
	}
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void {
	}
}