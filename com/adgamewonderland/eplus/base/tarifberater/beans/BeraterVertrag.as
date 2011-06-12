import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.BeraterVertrag extends AbstractProdukt {
	
	public static var VERTRAG_PREPAID : String = "vertrag_prepaid";
	
	public static var VERTRAG_LAUFZEIT : String = "vertrag_laufzeit";
	
	private static var _init : Boolean = initProdukte();
	
	public function BeraterVertrag(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		super(aId, aName, aZusatztext, aPreiseinmalig, aStreichpreiseinmalig, aPreismonatlich, aStreichpreismonatlich, aVisible, aInfos, aStep);
	}
	
	public function clone() : IProdukt {
		return new BeraterVertrag(this.getId(), this.getName(), this.getZusatztext(), this.getPreiseinmalig(), this.getStreichpreiseinmalig(), this.getPreismonatlich(), this.getStreichpreismonatlich(), this.getVisible(), this.getInfos(), this.getStep());
	}
	
	/**
	 * Initialisiert alle Telefonieverhalten mit statischen Werten
	 * TODO: Auslagern in XML oder Einladen über Webservice
	 */
	 private static function initProdukte() : Boolean {
	 	// vertrag als produkt
	 	var vertrag : BeraterVertrag;
		// ohne Vertragsbindung
		vertrag = new BeraterVertrag(BeraterVertrag.VERTRAG_PREPAID, "ohne Vertragsbindung", "", 0, 0, 0, 0, false, false, "");
		produkte.put(BeraterVertrag.VERTRAG_PREPAID, vertrag);
		// als Laufzeitvertrag
		vertrag = new BeraterVertrag(BeraterVertrag.VERTRAG_LAUFZEIT, "als Laufzeitvertrag", "", 0, 0, 0, 0, false, false, "");
		produkte.put(BeraterVertrag.VERTRAG_LAUFZEIT, vertrag);
		// erfolgreich
		return true;
	}
}