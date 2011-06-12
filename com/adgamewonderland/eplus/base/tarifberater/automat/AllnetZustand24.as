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

class com.adgamewonderland.eplus.base.tarifberater.automat.AllnetZustand24 extends AbstractZustand {

	

	public function AllnetZustand24(aAutomat : TarifberaterAutomat ) {

		super(aAutomat);

		// id

		this.id = "AllnetZustand24";

		// fortschritt

		this.fortschritt = 3;

		// frage

		this.frage = new Frage("Ich telefoniere mit dem Handy...");

		this.frage.addAntwort(new Antwort("Antwort2UI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, "kaum \n(weniger als 1 Minute am Tag)", "2.4.0"));

		this.frage.addAntwort(new Antwort("Antwort2UI", "BeraterTarifOption", BeraterTarifOption.ALLNET_FLAT_50, "wenig \n(1-3 Minuten \nam Tag)", "2.4.1"));

		this.frage.addAntwort(new Antwort("Antwort2UI", "BeraterTarifOption", BeraterTarifOption.ALLNET_FLAT_200, "normal \n(4-5 Minuten \nam Tag)", "2.4.2"));

		this.frage.addAntwort(new Antwort("Antwort2UI", "BeraterTarifOption", BeraterTarifOption.ALLNET_FLAT_500, "viel \n(6-8 Minuten \nam Tag)", "2.4.3"));

		this.frage.addAntwort(new Antwort("Antwort2UI", "BeraterTarifOption", BeraterTarifOption.ALLNET_FLAT, "sehr viel \n(mehr als 8 Minuten am Tag)", "2.4.4"));

	}



	public function produktWaehlen(aProdukt : IProdukt) : Void {

		// gewaehlte tarifoption

		var tarifoption : IProdukt = BeraterTarifOption(aProdukt);

		// naechster zustand

		var zustand : IZustand = this.automat.getFehlerZustand();

		// je nach produkt muss andere tarifoption und anderer zustand gewaehlt werden

		switch (tarifoption.getId()) {

			// fast gar nicht

			case BeraterTarifOption.DUMMY_OPTION :

				// auswahl sms

				zustand = this.automat.getSMSAllnetZustand42();

				

				break;

				

			// alle anderen

			default :

				// sichtbar machen

				tarifoption.setVisible(true);

				// auswahl welche allnet flat

				zustand = this.automat.getSMSAllnetZustand42();

		}

		

		// tarifoption hinzufuegen

		this.automat.getBerater().addProdukt(tarifoption);

		// naechster zustand

		this.automat.setZustand(zustand);

	}

	

	public function toString() : String {

		return "com.adgamewonderland.eplus.base.tarifberater.automat.AllnetZustand24";

	}

}

