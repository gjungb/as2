import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.automat.BlackberryZustand extends AbstractZustand {
	
	public function BlackberryZustand(aAutomat : TarifberaterAutomat) {
		super(aAutomat);
		// id
		this.id = "BlackberryZustand";
		// frage
		this.frage = new Frage("Ich möchte...");
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.BLACKBERRYDIENST, "den BlackBerry Dienst als Option zu meinem Sprachtarif nutzen."));
		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, ""));
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarif", BeraterTarif.BLACKBERRY, "den BlackBerry Dienst als Tarif mit eigener SIM-Karte nutzen."));
	}

	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// gewaehltes produkt
		var produkt : IProdukt = aProdukt;
		// naechster zustand
		var zustand : IZustand = this.automat.getFehlerZustand();
		// je nach produkt muss anderer zustand gewaehlt werden
		switch (produkt.getId()) {
			// als option
			case BeraterTarifOption.BLACKBERRYDIENST :
				// fertig
				zustand = this.automat.getKonfiguration().getEnde();
			
				break;	
			// als tarif
			case BeraterTarif.BLACKBERRY :
				// fertig
				zustand = this.automat.getKonfiguration().getEnde();
			
				break;
		}
		
		// sichtbar machen
		produkt.setVisible(true);
		_root.zeigeDebug(produkt);
		// tarif / -option hinzufuegen
		this.automat.getBerater().addProdukt(produkt);
		// naechster zustand
		this.automat.setZustand(zustand);
	}

	public function toString() : String {
		return "com.adgamewonderland.eplus.base.tarifberater.automat.BlackberryZustand";
	}
}