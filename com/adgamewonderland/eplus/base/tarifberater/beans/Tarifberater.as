import com.adgamewonderland.eplus.base.tarifberater.beans.Konfiguration;

import mx.utils.Collection;
import mx.utils.CollectionImpl;
import mx.utils.Iterator;

import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnlineVorteil;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;
import com.adgamewonderland.eplus.base.tarifberater.beans.Rechnungsrabatt;
import com.adgamewonderland.eplus.base.tarifberater.beans.TarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.beans.Zusatzkartenrabatt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterClientLsnr;
import com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.beans.Tarifberater implements ITarifberaterClientLsnr {
	
	private var konfiguration : Konfiguration;

	private var client : TarifberaterClient;

	private var warenkorb : Warenkorb;

	public function Tarifberater() {
		// warenkorb
		this.warenkorb = new Warenkorb();
	}

	/**
	 * Fügt ein Produkt zum Warenkorb hinzu
	 * @param aProdukt
	 */
	public function addProdukt(aProdukt : IProdukt ) : Void {
		// an warenkorb delegieren
		this.warenkorb.addProdukt(aProdukt);
	}

	/**
	 * Entfernt ein Produkt aus dem Warenkorb
	 * @param aProdukt
	 */
	public function removeProdukt(aProdukt : IProdukt ) : Void {
		// an warenkorb delegieren
		this.warenkorb.removeProdukt(aProdukt);
		// onlinevorteil aktualisieren
		aktualisiereOnlinevorteilProzent();
	}

	/**
	 * Entfernt das zuletzt hinzu gefügte Produkt aus dem Warenkorb
	 */
	public function removeLetzesProdukt() : Void {
		// an warenkorb delegieren
		this.warenkorb.removeLetzesProdukt();
		// onlinevorteil aktualisieren
		aktualisiereOnlinevorteilProzent();
	}

	/**
	 * Leert den Warenkorb
	 */
	public function leereWarenkorb() : Void {
		// an warenkorb delegieren
		this.warenkorb.leereWarenkorb();
	}

	/**
	 * Prüft, ob ein Produkt enthalten ist
	 * @param aProdukt
	 */
	public function isProduktEnthalten(aProdukt : IProdukt ) : Boolean {
		// an warenkorb delegieren
		return (this.warenkorb.isProduktEnthalten(aProdukt));
	}
	
	/**
	 * Prüft, ob mind. eine Tarifoption enthalten ist
	 * @return true, wenn mid. eine Tarifoption im Warenkorb, ansonsten false
	 */
	 public function isTarifoptionEnthalten() : Boolean {
	 	// warenkorb fragen
	 	return (this.warenkorb.getTarifoptionen().getLength() > 0);
	 }

	/**
	 * Gibt ein Produkt anhand seines Typs und seines Namens zurück
	 * @param aType Typ des Produkts (Tarif, Tarifoption)
	 * @param aName Name des Produkts
	 * @return das gesuchte Produkt oder null, falls der Typ ungültig ist oder kein Produkt mit dem Namen existiert
	 */
	public function getProdukt(aType : String, aName : String ) : IProdukt {
		// gesuchtes produkt
		var produkt : IProdukt;
		// pruefung auf typ
		switch (aType) {
			case "BeraterVertrag" :
			case "BeraterTelefonie" :
			case "BeraterTarif" :
			case "BeraterTarifOption" :
			case "BeraterOnlineVorteil" :
			case "BeraterSMS" :
			case "BeraterOnline" :
			case "BeraterInternetNutzung" :
				produkt = AbstractProdukt.getProdukt(aName);
				break;
			// unbekannt
			default :
				trace("getProdukt fehlgeschlagen mit " + aType + " # " + aName);
		}
		// zurueck geben
		return produkt;
	}

	public function bestellenAction(aSessionid : String, aWeg : String ) : Void {
		// ergebnisse
		var ergebnisse : Collection = erzeugeErgebnisse(aSessionid, aWeg);
		// in den warenkorb
		getClient().legeErgebnissInWk(BeratungsErgebniss(ergebnisse.getItemAt(0)), BeratungsErgebniss(ergebnisse.getItemAt(1)));
	}

	public function hardwareAction(aSessionid : String, aWeg : String ) : Void {
		// ergebnisse
		var ergebnisse : Collection = erzeugeErgebnisse(aSessionid, aWeg);
		// zu den handys
		getClient().waehleHardwareZumErgebniss(BeratungsErgebniss(ergebnisse.getItemAt(0)), BeratungsErgebniss(ergebnisse.getItemAt(1)));
	}

	public function onLegeErgebnissInWk(result : Object) : Void {
		_root.zeigeDebug("onLegeErgebnissInWk: " + result);
	}

	public function onWaehleHardwareZumErgebniss(result : Object) : Void {
		_root.zeigeDebug("onWaehleHardwareZumErgebniss: " + result);
	}

	public function setKonfiguration(aKonfiguration : Konfiguration) : Void {
		this.konfiguration = aKonfiguration;
	}

	public function getKonfiguration() : Konfiguration {
		return this.konfiguration;
	}

	public function getWarenkorb() : Warenkorb {
		return this.warenkorb;
	}
	
	public function neuStarten(aZustand : IZustand): Void {
		getClient().neuStarten(aZustand);
	}
	
	public function zurueckGehen(aZustand: IZustand): Void {
		getClient().zurueckGehen(aZustand);
	}
	
	/**
	 * berechnet den monatlichen Rabatt für alle im Warenkorb liegenden Tarife neu
	 * @deprecated ab 1.3.2009 nicht mehr relevant, da kein prozentualer onlinevorteil mehr
	 */
	private function aktualisiereOnlinevorteilProzent() : Void {
//		// testen, ob rechnungsrabatt
//		if (isProduktEnthalten(AbstractProdukt.getProdukt(BeraterOnlineVorteil.ONLINEVORTEIL_PROZENT)) == false)
//			return;
//		// onlinevorteil
//		var onlinevorteil : IProdukt = IProdukt(this.warenkorb.getOnlinevorteile().getItemAt(0));
//		// rabatt
//		var rabatt : Number = 0;
//		// tarif
//		var tarif : IProdukt;
//		// schleife ueber tarife
//		var iterator : Iterator = this.warenkorb.getTarife().getIterator();
//		// durchschleifen
//		while (iterator.hasNext()) {
//			// tarif
//			tarif = IProdukt(iterator.next());
//			// bei zusatzkartenrabatt originalen preis nehmen
//			if (tarif instanceof Zusatzkartenrabatt)
//				tarif = Zusatzkartenrabatt(tarif).getProdukt();
//			// rabatt berechnen
//			rabatt -= tarif.getPreismonatlich() * (1 - Rechnungsrabatt.PROZENT);
//		}
//		// und speichern
//		onlinevorteil.setPreismonatlich(rabatt);
	}
	
	/**
	 * berechnet den monatlichen Rabatt für alle im Warenkorb liegenden Tarife neu
	 * @deprecated ab 1.6.2010 kein onlinevorteil mehr
	 */
//	private function aktualisiereOnlinevorteilAbsolut() : Void {
//		// testen, ob rechnungsrabatt
//		if (isProduktEnthalten(AbstractProdukt.getProdukt(BeraterOnlineVorteil.ONLINEVORTEIL_ABSOLUT)) == false)
//			return;
//		// onlinevorteil
//		var onlinevorteil : IProdukt = IProdukt(this.warenkorb.getOnlinevorteile().getItemAt(0));
//		// rabatt
//		var rabatt : Number = 0;
//		// tarif
//		var tarif : IProdukt;
//		// schleife ueber tarife
//		var iterator : Iterator = this.warenkorb.getTarife().getIterator();
//		// durchschleifen
//		while (iterator.hasNext()) {
//			// tarif
//			tarif = IProdukt(iterator.next());
//			// rabatt je nach tarif
//			
//			switch (tarif.getId()) {
//				case BeraterTarif.BASEWEBEDITION :
//					rabatt -= 5;
//					break;
//				case BeraterTarif.BASE2DOPPELFLAT :
//					rabatt -= 5;
//					break;
//				case BeraterTarif.BASE5DOPPELFLAT :
//					rabatt -= 15;
//					break;				
//			}
//		}
//		// und speichern
//		onlinevorteil.setPreismonatlich(rabatt);
//	}
	
	/**
	 * TODO: erzeugung ergebnisse überarbeiten bzgl. ein / zwei tarife
	 * erzeugt aus dem im Warenkorb liegenden Produkten die Ergebnisse zur Übergabe den Webservice
	 * @param aSessionid
	 * @return eine Liste der BeratungsErgebnisse
	 */
	private function erzeugeErgebnisse(aSessionid : String, aWeg : String ) : Collection {
		// ergebnisse
		var ergebnisse : Collection = new CollectionImpl();
		// tarif
		var tarif : IProdukt;
		// je tarif ein ergebnis
		var tarife : Iterator = this.warenkorb.getTarife().getIterator();
		// zaehler zur unterscheidung tarif 1 / 2
		var zaehler = 0;
		// durchschleifen
		while (tarife.hasNext()) {
			// tarif
			tarif = IProdukt(tarife.next());
			// hochzaehlen
			zaehler ++;
			// neues ergebnis
			var ergebnis : BeratungsErgebniss = new BeratungsErgebniss(aSessionid, aWeg);	
			// tarif hinzufuegen
			ergebnis.setTarif(tarif);
			// optionen hinzufuegen
			var tarifoption : IProdukt;
			// tarifotionen
			var tarifoptionen : Iterator = this.warenkorb.getTarifoptionen().getIterator();
			// durchschleifen
			while (tarifoptionen.hasNext()) {
				// tarifoption
				tarifoption = IProdukt(tarifoptionen.next());
				// sonderbehandlung bei zwei tarifeb bzgl. laptop internet flat
				if (this.warenkorb.getTarife().getLength() == 2) {
						if (zaehler == 1 && tarifoption.getId() == BeraterTarifOption.INTERNET_FLAT_XL)
							continue;
						if (zaehler == 2 && tarifoption.getId() != BeraterTarifOption.INTERNET_FLAT_XL)
							continue;
				}
				// hinzufuegen
				ergebnis.addTarifOption(new TarifOption(tarifoption.getId(), tarifoption.getVisible()));
			}
			// ergebnis hinzufuegen
			ergebnisse.addItem(ergebnis);
		}
		// zurueck geben
		return ergebnisse;
	}
	
	private function getClient() : TarifberaterClient {
		if (this.client == null) {
			// client zum versenden der bestellung
			this.client = ClientFactory.getClient(getKonfiguration().getClient());
			// als listener registrieren
			this.client.addListener(this);
		}
		return this.client;
	}
}