import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

/**
 * @author gerd
 */

class com.adgamewonderland.eplus.base.tarifberater.automat.VertragsZustand extends AbstractZustand {
	
	public function VertragsZustand(aAutomat : TarifberaterAutomat ) {
		super(aAutomat);
		// id
		this.id = "VertragsZustand";
		// fortschritt
		this.fortschritt = 1;
		// frage
		this.frage = new Frage("Ich möchte...");
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarif", BeraterTarif.MEINBASE, "einen Laufzeitvertrag mit kostenlosen Minuten \nund SMS", "1.1"));
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarif", BeraterTarif.MEINBASEPREPAID, "einen Prepaid-Tarif \nohne Vertragsbindung", "1.2"));
	} 
	
	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// zu empfehlendes produkt
		var produkt : IProdukt = aProdukt;
		// naechster zustand
		var zustand : IZustand = this.automat.getFehlerZustand();
		// je nach produkt muss anderes produkt und anderer zustand gewaehlt werden
		switch (produkt.getId()) {
			// laufzeit
			case BeraterTarif.MEINBASE :
				// telefonie waelen
				zustand = this.automat.getTelefonieZustand();
				
				break;
			// prepaid
			case BeraterTarif.MEINBASEPREPAID :
				// fertig
				zustand = this.automat.getFertigZustand();
				
				break;
		}
		// sichtbar machen
		produkt.setVisible(true);
		// produkt hinzufuegen
		this.automat.getBerater().addProdukt(produkt);
		// naechster zustand
		this.automat.setZustand(zustand);
	}
	
	public function warenkorbBestellenMoeglich() : Boolean {
		// nicht moeglich, zu bestellen
		return false;
	}
	
	public function neuStartenMoeglich() : Boolean {
		// nicht moeglich, neu zu starten
		return false;
	}
	
	public function toString() : String {
		return "com.adgamewonderland.eplus.base.tarifberater.automat.VertragsZustand";
	}
	
}