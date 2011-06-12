import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnlineVorteil;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.automat.OnlineVorteilZustand extends AbstractZustand {		public function OnlineVorteilZustand(aAutomat : TarifberaterAutomat) {		super(aAutomat);		// id		this.id = "OnlineVorteilZustand";		// frage		this.frage = new Frage("Als Vorteil bei Online Bestellung wähle ich...");		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterOnlineVorteil", BeraterOnlineVorteil.ONLINEVORTEIL_SMS, "die kostenlose SMS-Flatrate im E-Plus Netz."));		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, ""));		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterOnlineVorteil", BeraterOnlineVorteil.ONLINEVORTEIL_ABSOLUT, "Rabatt auf den Monatspaketpreis."));	}
	public function produktWaehlen(aProdukt : IProdukt) : Void {		// gewaehlter onlinevorteil		var onlinevorteil : BeraterOnlineVorteil;		// naechster zustand		var zustand : IZustand = this.automat.getFehlerZustand();		// onlinevorteil gewaehlt		if (aProdukt instanceof BeraterOnlineVorteil) {			onlinevorteil = BeraterOnlineVorteil(aProdukt);			// je nach onlinevorteil muss anderer zustand gewaehlt werden			switch (onlinevorteil.getId()) {				// sms flatrate				case BeraterOnlineVorteil.ONLINEVORTEIL_SMS :					// online zustand					zustand = this.automat.getOnlineZustand();									break;				// rechnungsrabatt				case BeraterOnlineVorteil.ONLINEVORTEIL_ABSOLUT :					// sms flatrate waehlen					zustand = this.automat.getSMSZustand();									break;				}		}				// sichtbar machen		onlinevorteil.setVisible(true);		// onlinevorteil hinzufuegen		this.automat.getBerater().addProdukt(onlinevorteil);		// naechster zustand		this.automat.setZustand(zustand);	}		public function warenkorbBestellenMoeglich() : Boolean {		// nicht moeglich, zu bestellen		return false;	}
	
	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {
		// je nach tarif anderer text bei rabatt
		if (this.equals(aZustand)) {
			// rabatt text
			var rabatt : String = "";
			// je nach tarif
			if (aWarenkorb.isProduktEnthalten(AbstractProdukt.getProdukt(BeraterTarif.BASE2CLASSICWEBEDITION)) || aWarenkorb.isProduktEnthalten(AbstractProdukt.getProdukt(BeraterTarif.BASE2PLUSWEBEDITION)))
				rabatt = "5 € ";
			if (aWarenkorb.isProduktEnthalten(AbstractProdukt.getProdukt(BeraterTarif.BASE5WEBEDITION)))
				rabatt = "15 € ";
			// betroffene antwort
			var antwort : Antwort = Antwort(this.frage.getAntworten().getItemAt(2));
			// text aendern
			antwort.setText(rabatt + "Rabatt auf den Monatspaketpreis.");
		}
	}		public function toString() : String {		return "com.adgamewonderland.eplus.base.tarifberater.automat.OnlineVorteilZustand";	}}