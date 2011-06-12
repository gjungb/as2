﻿import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
class com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand42 extends AbstractZustand {		public function SMSAllnetZustand42(aAutomat : TarifberaterAutomat ) {		super(aAutomat);		// id		this.id = "SMSAllnetZustand42";		// fortschritt		this.fortschritt = 5;		// frage		this.frage = new Frage("SMS versende ich...");		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, "gar nicht", "4.2.1"));		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, "eher wenig \n(insgesamt 1 SMS am Tag in dt. Mobilfunknetze)", "4.2.2"));		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.SMS_ALLNET_FLAT, "eher häufig \n(mehr als 1 SMS am Tag in dt. Mobilfunknetze)", "4.2.3"));	}
	public function produktWaehlen(aProdukt : IProdukt) : Void {		// gewaehlte tarifoption		var tarifoption : IProdukt = BeraterTarifOption(aProdukt);		// naechster zustand		var zustand : IZustand = this.automat.getFehlerZustand();		// je nach produkt muss andere tarifoption und anderer zustand gewaehlt werden		switch (tarifoption.getId()) {			// fast gar nicht			case BeraterTarifOption.DUMMY_OPTION :				// auswahl sms				zustand = this.automat.getOnlineZustand();								break;							// alle anderen			default :				// sichtbar machen				tarifoption.setVisible(true);				// auswahl welche allnet flat				zustand = this.automat.getOnlineZustand();		}				// tarifoption hinzufuegen		this.automat.getBerater().addProdukt(tarifoption);		// naechster zustand		this.automat.setZustand(zustand);	}		public function toString() : String {		return "com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand42";	}	}