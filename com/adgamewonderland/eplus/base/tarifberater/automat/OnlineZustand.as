import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterInternetNutzung;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.automat.OnlineZustand extends AbstractZustand {			public function OnlineZustand(aAutomat : TarifberaterAutomat ) {
		super(aAutomat);		// id		this.id = "OnlineZustand";
		// fortschritt
		this.fortschritt = 6;		// frage		this.frage = new Frage("Mobiles Internet nutze ich...");
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, "gar nicht", "5.1"));
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterInternetNutzung", BeraterInternetNutzung.INTERNETNUTZUNG_HANDY, "mit dem Handy oder Smartphone", "5.2"));
		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.INTERNET_FLAT_XL, "mit dem Laptop oder Tablet-PC", "5.3"));
	}

	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// gewaehlte tarifoption
		var tarifoption : IProdukt = aProdukt;
		// naechster zustand
		var zustand : IZustand = this.automat.getFehlerZustand();
		// je nach produkt muss andere tarifoption und anderer zustand gewaehlt werden
		switch (tarifoption.getId()) {
			// gar nicht
			case BeraterTarifOption.DUMMY_OPTION :
				// fertig
				zustand = this.automat.getFertigZustand();
				
				break;
				
			// handy
			case BeraterInternetNutzung.INTERNETNUTZUNG_HANDY :
				// mit dem handy
				zustand = this.automat.getHandyInternetFlatrateZustand();
				
				break;
				
			// handy
			case BeraterTarifOption.INTERNET_FLAT_XL :
				// wurden bisher  tarifoptionen gebucht
				var gebucht : Boolean = this.automat.getBerater().isTarifoptionEnthalten();
				// wenn ja, zusatzfrage
				if (true) {
					// dummy
					tarifoption = AbstractProdukt.getProdukt(BeraterTarifOption.DUMMY_OPTION);
					// eine oder zwei sim-karten
					zustand = this.automat.getInternetFlatrateZustand();
					
				} else {
					// sichtbar machen
					tarifoption.setVisible(true);
					// fertig
					zustand = this.automat.getFertigZustand();
				}
		}
		
		// tarifoption hinzufuegen
		this.automat.getBerater().addProdukt(tarifoption);
		// naechster zustand
		this.automat.setZustand(zustand);
	}		public function toString() : String {		return "com.adgamewonderland.eplus.base.tarifberater.automat.OnlineZustand";	}	}