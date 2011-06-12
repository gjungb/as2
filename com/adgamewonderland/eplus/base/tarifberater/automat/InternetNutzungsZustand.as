import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterInternetNutzung;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.automat.InternetNutzungsZustand extends AbstractZustand {
	
	public function InternetNutzungsZustand(aAutomat : TarifberaterAutomat) {
		super(aAutomat);
		// id
		this.id = "InternetNutzungsZustand";
		// frage
		this.frage = new Frage("Mit meinem Laptop arbeite und surfe ich...");
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarif", BeraterTarif.LAPTOPTAGESFLAT, "unterwegs nur an manchen Tagen im Monat"));
//		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, ""));
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterInternetNutzung", BeraterInternetNutzung.INTERNETNUTZUNG_TAEGLICH,  "unterwegs fast täglich"));
	}

	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// gewaehltes produkt
		var produkt : IProdukt = aProdukt;
		// naechster zustand
		var zustand : IZustand = this.automat.getFehlerZustand();
		// je nach produkt muss anderer zustand gewaehlt werden
		switch (produkt.getId()) {
			// laptop tages-flat
			case BeraterTarif.LAPTOPTAGESFLAT :
				// fertig
				zustand = this.automat.getKonfiguration().getEnde();
			
				break;
			case BeraterInternetNutzung.INTERNETNUTZUNG_TAEGLICH :
				// laptop internet-flat
				zustand = this.automat.getInternetFlatrateZustand();
			
				break;
		}
		
		// sichtbar machen
		produkt.setVisible(true);
		// tarifoption hinzufuegen
		this.automat.getBerater().addProdukt(produkt);
		// naechster zustand
		this.automat.setZustand(zustand);
	}

	public function toString() : String {
		return "com.adgamewonderland.eplus.base.tarifberater.automat.InternetNutzungsZustand";
	}
}
