import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;class com.adgamewonderland.eplus.base.tarifberater.beans.BeraterInternetNutzung extends AbstractProdukt {
	
	public static var INTERNETNUTZUNG_HANDY : String = "internetnutzung_handy";
	
	private static var _init : Boolean = initProdukte();
	
	public function BeraterInternetNutzung(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		super(aId, aName, aZusatztext, aPreiseinmalig, aStreichpreiseinmalig, aPreismonatlich, aStreichpreismonatlich, aVisible, aInfos, aStep);
	}
	
	public function clone() : IProdukt {
		return new BeraterInternetNutzung(this.getId(), this.getName(), this.getZusatztext(), this.getPreiseinmalig(), this.getStreichpreiseinmalig(), this.getPreismonatlich(), this.getStreichpreismonatlich(), this.getVisible(), this.getInfos(), this.getStep());
	}
	
	/**
	 * Initialisiert alle Telefonieverhalten mit statischen Werten
	 * TODO: Auslagern in XML oder Einladen über Webservice
	 */
	 private static function initProdukte() : Boolean {
	 	// nutzung als produkt
	 	var nutzung : BeraterInternetNutzung;
		// taeglich
		nutzung = new BeraterInternetNutzung(BeraterInternetNutzung.INTERNETNUTZUNG_HANDY, "mit dem Handy oder Smartphone", "", 0, 0, 0, 0, false, false, "");
		produkte.put(BeraterInternetNutzung.INTERNETNUTZUNG_HANDY, nutzung);
		// erfolgreich
		return true;
	}
}