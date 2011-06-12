﻿import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;
	public function produktWaehlen(aProdukt : IProdukt) : Void {
			// online zustand
			zustand = this.automat.getOnlineZustand();
	
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
	}