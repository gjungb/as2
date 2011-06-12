import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;class com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand extends AbstractZustand {		public function SMSAllnetZustand(aAutomat : TarifberaterAutomat ) {		super(aAutomat);		// id		this.id = "SMSAllnetZustand";		// frage		this.frage = new Frage("Ich versende...");		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.SMS_ALLNET_FLAT, "bis zu 100 SMS in alle deutschen Mobilfunknetze."));		this.frage.addAntwort(new Antwort("AntworticonUI", "BeraterTarifOption", BeraterTarifOption.DUMMY_OPTION, ""));		this.frage.addAntwort(new Antwort("AntwortUI", "BeraterTarifOption", BeraterTarifOption.SMS_ALLNET_FLAT, "über 100 SMS in alle deutschen Mobilfunknetze."));	}
	public function produktWaehlen(aProdukt : IProdukt) : Void {		// gewaehlte tarifoption		var tarifoption : BeraterTarifOption;		// naechster zustand		var zustand : IZustand = this.automat.getFehlerZustand();		// onlinevorteil gewaehlt		if (aProdukt instanceof BeraterTarifOption) {			tarifoption = BeraterTarifOption(aProdukt);
			// online zustand
			zustand = this.automat.getOnlineZustand();		}				// sichtbar machen		tarifoption.setVisible(true);		// tarifoption hinzufuegen		this.automat.getBerater().addProdukt(tarifoption);		// naechster zustand		this.automat.setZustand(zustand);	}	//	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {//		// dieser zustand erreicht//		if (aZustand == this) {//			// je nach bisher empfohlenem tarif muss anderes set an produkten gewaehlt werden//			var antwort : Antwort = Antwort(this.frage.getAntworten().getItemAt(2));//			// base 2 classic und base 1 ohne allnet flatrate//			if (aWarenkorb.isProduktEnthalten(AbstractProdukt.getProdukt(BeraterTarif.BASEWEBEDITION))) {//				// letze antwort unsichtbar machen//				antwort.setVisible(false);//			} else {//				// letze antwort sichtbar machen//				antwort.setVisible(true);//			}//		}//	}
	
	public function vorwaertsGehenMoeglich() : Boolean {
		// moeglich, einen schritt vorwaerts zu gehen
		return true;
	}
	
	public function vorwaertsGehen() : Void {
		// naechster zustand
		var zustand : IZustand = this.automat.getOnlineZustand();
		// dummy hinzufuegen
		this.automat.getBerater().addProdukt(AbstractProdukt.getProdukt(BeraterTarifOption.DUMMY_OPTION));
		// naechster zustand
		this.automat.setZustand(zustand);
	}		public function toString() : String {		return "com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand";	}	}