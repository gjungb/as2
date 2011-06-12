import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;import com.adgamewonderland.agw.util.StringFormatter;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;

class com.adgamewonderland.eplus.base.tarifberater.ui.WarenkorbsummeUI extends MovieClip implements ITarifberaterAutomatLsnr {
	
	private var preismonatlich_txt : TextField;
	
	public function WarenkorbsummeUI() {
	}	public function onLoad() : Void {		// als listener registrieren		ApplicationController.getInstance().getAutomat().addListener(this);		}		public function onUnload() : Void {		// als listener deregistrieren		ApplicationController.getInstance().getAutomat().removeListener(this);		}		public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {		// anzeige		zeigeSumme(aWarenkorb);	}
	
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