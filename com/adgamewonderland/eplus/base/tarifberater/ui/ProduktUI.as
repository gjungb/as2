import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnlineVorteil;

import mx.utils.Delegate;

import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.agw.util.StringFormatter;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.ui.ProduktUI extends MovieClip {
	
	private var _produkt : IProdukt;

	private var name_txt : TextField;
	
	private var zusatztext_txt : TextField;

	private var preismonatlich_txt : TextField;
	
	private var details_btn : Button;

	public function ProduktUI() {
	}

	public function onLoad() : Void {
		// anzeigen
		zeigeProdukt(_produkt);
	}

	public function onUnload() : Void {
	}
	
	/**
	 * Zeigt Details zu einem Produkt an
	 * @param aProdukt
	 */
	public function zeigeProdukt(aProdukt : IProdukt) : Void {
		// name
		name_txt.autoSize = "left";
		name_txt.text = aProdukt.getName();
		// hack fuer 20 %
		if (aProdukt.getId() == BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT)
			name_txt.text += " auf den Monatspaketpreis";
		// zusatztext
		zusatztext_txt.autoSize = "left";
		zusatztext_txt.text = aProdukt.getZusatztext();
		// preis
		preismonatlich_txt.autoSize = "right";
		preismonatlich_txt.text = StringFormatter.formatMoney(aProdukt.getPreismonatlich());
		// button zu details
		details_btn._visible = aProdukt.getInfos();
		details_btn.onRelease = Delegate.create(this, onDetails);
	}
	
	/**
	 * Callback nach Drücken des Infos Button
	 */
	private function onDetails() : Void {
		// controller informieren
		ApplicationController.getInstance().zeigeProduktinfos(_produkt);
	}
}