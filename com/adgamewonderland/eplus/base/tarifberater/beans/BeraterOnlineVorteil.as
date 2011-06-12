import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnlineVorteil extends AbstractProdukt {
	
	public static var ONLINEVORTEIL_PROZENT : String = "onlinevorteil_prozent";
	
	public static var ONLINEVORTEIL_SMS : String = "onlinevorteil_sms";
	
	// neuer online-vorteil ab 1.3.2009
	public static var ONLINEVORTEIL_ABSOLUT : String = "onlinevorteil_absolut";
	
	private static var _init : Boolean = initProdukte();
	
	public function BeraterOnlineVorteil(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		super(aId, aName, aZusatztext, aPreiseinmalig, aStreichpreiseinmalig, aPreismonatlich, aStreichpreismonatlich, aVisible, aInfos, aStep);
	}
	
	public function clone() : IProdukt {
		return new BeraterOnlineVorteil(this.getId(), this.getName(), this.getZusatztext(), this.getPreiseinmalig(), this.getStreichpreiseinmalig(), this.getPreismonatlich(), this.getStreichpreismonatlich(), this.getVisible(), this.getInfos(), this.getStep());
	}
	
	/**
	 * Initialisiert alle Onlinevorteile mit statischen Werten
	 * TODO: Auslagern in XML oder Einladen über Webservice
	 */
	 private static function initProdukte() : Boolean {
	 	// onlinevorteil als produkt
	 	var onlinevorteil : BeraterOnlineVorteil;
		// 20% Rabatt auf Monatspaketpreis
		onlinevorteil = new BeraterOnlineVorteil(BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT, "20% Rabatt", "", 0, 0, 0, 0, false, false, "3a");
		produkte.put(BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT, onlinevorteil);
		// kostenlose SMS-Flatrate im E-Plus Netz
		onlinevorteil = new BeraterOnlineVorteil(BeraterOnlineVorteil.ONLINEVORTEIL_SMS, "SMS-Flatrate", "", 0, 0, 0, 0, false, false, "3b");
		produkte.put(BeraterOnlineVorteil.ONLINEVORTEIL_SMS, onlinevorteil);
	
		// absoluter Rabatt auf Monatspaketpreis
		onlinevorteil = new BeraterOnlineVorteil(BeraterOnlineVorteil.ONLINEVORTEIL_ABSOLUT, "Rabatt", "", 0, 0, 0, 0, false, false, "3a");
		produkte.put(BeraterOnlineVorteil.ONLINEVORTEIL_ABSOLUT, onlinevorteil);
		
		// erfolgreich
		return true;
	}
}