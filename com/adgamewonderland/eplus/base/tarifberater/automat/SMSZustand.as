import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterSMS;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.automat.SMSZustand extends AbstractZustand {		public function SMSZustand(aAutomat : TarifberaterAutomat ) {		super(aAutomat);		// id		this.id = "SMSZustand";		// frage		this.frage = new Frage("Ich möchte kostenlose SMS...");//		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.SMS_FLATRATE, "zu BASE und ins E-Plus Netz versenden."));		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, ""));		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterSMS", BeraterSMS.SMS_ALLE, "in alle deutschen Mobilfunknetze versenden."));	}
	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// gewaehltes produkt
		var produkt : IProdukt = aProdukt;
		// naechster zustand
		var zustand : IZustand = this.automat.getFehlerZustand();
		// je nach produkt muss anderer zustand gewaehlt werden
		switch (produkt.getId()) {
			// sms flatrate
//			case BeraterTarifOption.SMS_FLATRATE :
//				// online zustand
//				zustand = this.automat.getOnlineZustand();
//			
//				break;	
			// sms in alle netze
			case BeraterSMS.SMS_ALLE :
//				// art der sms allnet flatrate waehlen
//				zustand = this.automat.getSMSAllnetZustand();
			
				break;
		}
		
		// sichtbar machen
		produkt.setVisible(true);
		// produkt hinzufuegen
		this.automat.getBerater().addProdukt(produkt);
		// naechster zustand
		this.automat.setZustand(zustand);	}		public function vorwaertsGehenMoeglich() : Boolean {		// moeglich, einen schritt vorwaerts zu gehen		return true;	}		public function vorwaertsGehen() : Void {		// naechster zustand		var zustand : IZustand = this.automat.getOnlineZustand();		// dummy hinzufuegen		this.automat.getBerater().addProdukt(AbstractProdukt.getProdukt(BeraterTarifOption.DUMMY_OPTION));		// naechster zustand		this.automat.setZustand(zustand);	}		public function toString() : String {		return "com.adgamewonderland.eplus.base.tarifberater.automat.SMSZustand";	}	}