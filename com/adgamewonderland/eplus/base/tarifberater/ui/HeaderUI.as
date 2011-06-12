import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;

import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.InternetFlatrateZustand;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;

class com.adgamewonderland.eplus.base.tarifberater.ui.HeaderUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr {
	
	public function HeaderUI() {
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
		if(aZustand.isEndeZustand()){
			//pruefe ob prepaid und zeige ggf einen anderen header
			if(aWarenkorb.isProduktIdEnthalten(BeraterTarif.MEINBASEPREPAID)){
				this.gotoAndStop('header_prepaid');
			} else {
				this.gotoAndStop('header_ende');
			}
			return;
		}
		//zeige header mit infos zu 2 simkarten
		if(aZustand instanceof InternetFlatrateZustand){
			this.gotoAndStop('header_sim');
			return;
		}
		//zeige den header am start
		if(aZustand.isStartZustand()){
			this.gotoAndStop('header_anfang');
			return;
		}
		//zeige den header bei allen anderen schritten
		this.gotoAndStop('header_zwischen');
	}

	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
	}
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void {
	}
}