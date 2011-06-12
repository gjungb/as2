import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.automat.TarifBASE1Zustand extends AbstractZustand {
	
	public function TarifBASE1Zustand(aAutomat : TarifberaterAutomat ) {
		super(aAutomat);
		// id
		this.id = "TarifBASE1Zustand";
		// frage
		this.frage = new Frage("Dann wählen Sie folgende BASE Flatrate.");
		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION));
		this.frage.addAntwort(new Antwort("AntwortBASE1UI", "BeraterTarif", BeraterTarif.BASE1));
		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION));
	}
	
	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// zu empfehlender tarif
		var tarif : BeraterTarif;
		// naechster zustand
		var zustand : IZustand = this.automat.getFehlerZustand();
		// tarif gewaehlt
		if (aProdukt instanceof BeraterTarif) {
			tarif = BeraterTarif(aProdukt);
			// onlinevorteil waehlen
			zustand = this.automat.getOnlineVorteilZustand();
		}
		
		// sichtbar machen
		tarif.setVisible(true);
		// tarif hinzufuegen
		this.automat.getBerater().addProdukt(tarif);
		// naechster zustand
		this.automat.setZustand(zustand);
	}
	
	public function warenkorbBestellenMoeglich() : Boolean {
		// nicht moeglich, zu bestellen
		return false;
	}
	
	public function toString() : String {
		return "com.adgamewonderland.eplus.base.tarifberater.automat.TarifBASE1Zustand";
	}
}
