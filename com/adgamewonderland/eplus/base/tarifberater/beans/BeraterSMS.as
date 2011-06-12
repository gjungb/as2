import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.BeraterSMS extends AbstractProdukt {
	
	public static var SMS_ALLE : String = "sms_alle";
	
	private static var _init : Boolean = initProdukte();
	
	public function BeraterSMS(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		super(aId, aName, aZusatztext, aPreiseinmalig, aStreichpreiseinmalig, aPreismonatlich, aStreichpreismonatlich, aVisible, aInfos, aStep);
	}
	
	public function clone() : IProdukt {
		return new BeraterSMS(this.getId(), this.getName(), this.getZusatztext(), this.getPreiseinmalig(), this.getStreichpreiseinmalig(), this.getPreismonatlich(), this.getStreichpreismonatlich(), this.getVisible(), this.getInfos(), this.getStep());
	}
	
	/**
	 * Initialisiert alle Telefonieverhalten mit statischen Werten
	 * TODO: Auslagern in XML oder Einladen über Webservice
	 */
	 private static function initProdukte() : Boolean {
	 	// sms als produkt
	 	var sms : BeraterSMS;
		// in alle deutschen Mobilfunknetze
		sms = new BeraterSMS(BeraterSMS.SMS_ALLE, "in alle deutschen Mobilfunknetze", "", 0, 0, 0, 0, false, false, "4b");
		produkte.put(BeraterSMS.SMS_ALLE, sms);
		// erfolgreich
		return true;
	}
}