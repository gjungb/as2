﻿import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
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

class com.adgamewonderland.eplus.base.tarifberater.automat.OnlineVorteilZustand extends AbstractZustand {
	public function produktWaehlen(aProdukt : IProdukt) : Void {
	
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
	}