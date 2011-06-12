import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;

import mx.utils.Delegate;
import mx.utils.Collection;
import mx.utils.Iterator;

import com.adgamewonderland.agw.util.StringFormatter;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.ui.AuswahlUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr {

	private var tarif_txt : TextField;
	
	private var onlinevorteil_txt : TextField;
	
	private var tarifoption1_txt : TextField;
	
	private var tarifoption2_txt : TextField;
	
	private var preismonatlich_txt : TextField;
	
	private var details_btn : Button;

	private var schliessen_btn : Button;
	
	private var box_mc : MovieClip;
	
	public function AuswahlUI() {
		// textfelder linksbuendig
		for (var i : String in this) {
			if (this[i] instanceof TextField) {
				var field : TextField = TextField(this[i]);
				field.autoSize = "left";
			}
		}
		// button details (des warenkorbs)
		details_btn.onRelease = Delegate.create(this, onDetails);
		// button schliessen (des warenkorbs)
		schliessen_btn.onRelease = Delegate.create(this, onSchliessen);
		// buttons ausblenden
		details_btn._visible = schliessen_btn._visible = false;
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
		// auswahl anzeigen
		zeigeAuswahl(aWarenkorb);
		// hinspringen
		this.gotoAndStop("fr" + aZustand.getId());
		// am ende warenkorb einblenden
		if (aZustand instanceof FertigZustand)
			onDetails();
		else
			onSchliessen();
	}

	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
	}
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void {
		// wenn fertig, dann keine buttons
		if (aZustand instanceof FertigZustand) {
			// ausblenden
			details_btn._visible = schliessen_btn._visible = false;
		} else {
			// details button ein- / ausblenden
			details_btn._visible = !aSichtbar && aZustand.warenkorbBestellenMoeglich();
			// schliessen button ein- / einblenden
			schliessen_btn._visible = aSichtbar;
		}
	}

	/**
	 * Füllt die Textfelder entsprechend den Produkten im Warenkorb
	 * @param aWarenkorb
	 */
	private function zeigeAuswahl(aWarenkorb : Warenkorb ) : Void {
//		// TODO: textfelder fuer headlines
//		
//		
//		// textfelder leeren
//		for (var i : String in this) {
//			if (this[i] instanceof TextField) {
//				var field : TextField = TextField(this[i]);
//				field.text = "";
//			}
//		}
//		
//		// 1. tarif
//		var tarife : Collection = aWarenkorb.getTarife();
//		// tarif anzeigen
//		if (! tarife.isEmpty()) {
//			tarif_txt.text = IProdukt(tarife.getItemAt(0)).getName();	
//		}
//		
//		// 2. onlinevorteil
//		var onlinevorteile : Collection = aWarenkorb.getOnlinevorteile();
//		// onlinevorteil anzeigen
//		if (! onlinevorteile.isEmpty()) {
//			onlinevorteil_txt.text = IProdukt(onlinevorteile.getItemAt(0)).getName();	
//		}
//		
//		// 3. tarifoptionen
//		var tarifoptionen : Collection = aWarenkorb.getTarifoptionen();
//		// iterator
//		var iterator : Iterator = tarifoptionen.getIterator();
//		// zaehler fuer textfeld
//		var counter : Number = 0;
//		// durchschleifen
//		while (iterator.hasNext()) {
//			// anzeigen
//			TextField(this["tarifoption" + (++counter) + "_txt"]).text = IProdukt(iterator.next()).getName();
//		}
//		
//		// 4. preis
//		if (aWarenkorb.getPreismonatlich() > 0)
//			preismonatlich_txt.text = StringFormatter.formatMoney(aWarenkorb.getPreismonatlich());
//			
//		// 5. box, wenn prepaid
//		box_mc._visible = (aWarenkorb.isProduktEnthalten(BeraterTarif.getProdukt(BeraterTarif.BASEPREPAID)));
	}

	private function onDetails() : Void {
		// warenkorb einblenden
		ApplicationController.getInstance().zeigeWarenkorb(true);
	}

	private function onSchliessen() : Void {
		// warenkorb ausblenden
		ApplicationController.getInstance().zeigeWarenkorb(false);
	}
}