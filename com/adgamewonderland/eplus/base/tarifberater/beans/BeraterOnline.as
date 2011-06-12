import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
class com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnline extends AbstractProdukt {
	
	public static var ONLINE_1SIM : String = "online_1sim";
	
	public static var ONLINE_2SIM : String = "online_2sim";
	
	public static var ONLINE_MICROSIM : String = "online_microsim";
	
	private static var _init : Boolean = initProdukte();
	
	public function BeraterOnline(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		super(aId, aName, aZusatztext, aPreiseinmalig, aStreichpreiseinmalig, aPreismonatlich, aStreichpreismonatlich, aVisible, aInfos, aStep);
	}
	
	public function clone() : IProdukt {
		return new BeraterOnline(this.getId(), this.getName(), this.getZusatztext(), this.getPreiseinmalig(), this.getStreichpreiseinmalig(), this.getPreismonatlich(), this.getStreichpreismonatlich(), this.getVisible(), this.getInfos(), this.getStep());
	}
	
	/**
	 * Initialisiert alle Telefonieverhalten mit statischen Werten
	 * TODO: Auslagern in XML oder Einladen über Webservice
	 */
	 private static function initProdukte() : Boolean {
	 	// online als produkt
	 	var online : BeraterOnline;
		// 1 SIM
		online = new BeraterOnline(BeraterOnline.ONLINE_1SIM, "1 SIM", "", 0, 0, 0, 0, false, false, "5.3.1");
		produkte.put(BeraterOnline.ONLINE_1SIM, online);
		// 2 SIM
		online = new BeraterOnline(BeraterOnline.ONLINE_2SIM, "2 SIM", "", 0, 0, 0, 0, false, false, "5.3.2");
		produkte.put(BeraterOnline.ONLINE_2SIM, online);
		// 1 Standard-SIM/1 Micro-SIM
		online = new BeraterOnline(BeraterOnline.ONLINE_MICROSIM, "1 Standard-SIM/1 Micro-SIM", "", 0, 0, 0, 0, false, false, "5.3.3");
		produkte.put(BeraterOnline.ONLINE_MICROSIM, online);
		
		// erfolgreich
		return true;
	}
}