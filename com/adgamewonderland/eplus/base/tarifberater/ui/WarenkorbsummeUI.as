import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;

class com.adgamewonderland.eplus.base.tarifberater.ui.WarenkorbsummeUI extends MovieClip implements ITarifberaterAutomatLsnr {
	
	private var preismonatlich_txt : TextField;
	
	public function WarenkorbsummeUI() {
	}
	
	/**
	 * Zeigt die Summe an
	 * @param aWarenkorb
	 */
	private function zeigeSumme(aWarenkorb : Warenkorb ) : Void {
		// summe
		preismonatlich_txt.autoSize = "right";
		preismonatlich_txt.text = StringFormatter.formatMoney(aWarenkorb.getPreismonatlich());
	}
}