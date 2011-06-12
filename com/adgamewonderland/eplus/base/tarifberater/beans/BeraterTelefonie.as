import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTelefonie extends AbstractProdukt {
	
	public static var TELEFONIE_BASE_EPLUS : String = "telefonie_base_eplus";
	
	public static var TELEFONIE_FESTNETZ : String = "telefonie_festnetz";
	
	public static var TELEFONIE_BASE_EPLUS_FESTNETZ : String = "telefonie_base_eplus_festnetz";
	
	public static var TELEFONIE_ALLE : String = "telefonie_alle";
	
	private static var _init : Boolean = initProdukte();
	
	public function BeraterTelefonie(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		super(aId, aName, aZusatztext, aPreiseinmalig, aStreichpreiseinmalig, aPreismonatlich, aStreichpreismonatlich, aVisible, aInfos, aStep);
	}
	
	public function clone() : IProdukt {
		return new BeraterTelefonie(this.getId(), this.getName(), this.getZusatztext(), this.getPreiseinmalig(), this.getStreichpreiseinmalig(), this.getPreismonatlich(), this.getStreichpreismonatlich(), this.getVisible(), this.getInfos(), this.getStep());
	}
	
	/**
	 * Initialisiert alle Telefonieverhalten mit statischen Werten
	 * TODO: Auslagern in XML oder Einladen über Webservice
	 */
	 private static function initProdukte() : Boolean {
	 	// telefonie als produkt
	 	var telefonie : BeraterTelefonie;
	 	// überwiegend zu BASE und E-Plus
		telefonie = new BeraterTelefonie(BeraterTelefonie.TELEFONIE_BASE_EPLUS, "überwiegend zu BASE und E-Plus", "", 0, 0, 0, 0, false, false, "2.1");
		produkte.put(BeraterTelefonie.TELEFONIE_BASE_EPLUS, telefonie);
	 	// überwiegend ins Festnetz
		telefonie = new BeraterTelefonie(BeraterTelefonie.TELEFONIE_FESTNETZ, "überwiegend ins Festnetz", "", 0, 0, 0, 0, false, false, "2.2");
		produkte.put(BeraterTelefonie.TELEFONIE_FESTNETZ, telefonie);
	 	// überwiegend zu BASE, E-Plus und ins Festnetz 
		telefonie = new BeraterTelefonie(BeraterTelefonie.TELEFONIE_BASE_EPLUS_FESTNETZ, "überwiegend zu BASE, E-Plus und ins Festnetz", "", 0, 0, 0, 0, false, false, "2.3");
		produkte.put(BeraterTelefonie.TELEFONIE_BASE_EPLUS_FESTNETZ, telefonie);
	 	// in alle Handynetze und ins Festnetz
		telefonie = new BeraterTelefonie(BeraterTelefonie.TELEFONIE_ALLE, "in alle Handynetze und ins Festnetz", "", 0, 0, 0, 0, false, false, "2.4");
		produkte.put(BeraterTelefonie.TELEFONIE_ALLE, telefonie);
		
		// erfolgreich
		return true;
	}
}