﻿import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterSMS;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.automat.SMSZustand extends AbstractZustand {
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
		this.automat.setZustand(zustand);