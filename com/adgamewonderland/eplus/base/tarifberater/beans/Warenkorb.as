import com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt;

import mx.utils.Collection;
import mx.utils.CollectionImpl;
import mx.utils.Iterator;

import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterOnlineVorteil;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarif;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeraterTarifOption;
import com.adgamewonderland.eplus.base.tarifberater.beans.Rechnungsrabatt;
import com.adgamewonderland.eplus.base.tarifberater.beans.Zusatzkartenrabatt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb {
	
	private var produkte : Collection;

	public function Warenkorb() {
		// produkte im warenkorb
		this.produkte = new CollectionImpl();
	}

	/**
	 * Fügt ein Produkt zum Warenkorb hinzu
	 * @param aProdukt
	 */
	public function addProdukt(aProdukt : IProdukt ) : Void {
		// abbrechen, wenn leer
		if (aProdukt == null)
			return;
		// zur liste der produkte hinzu fuegen
		this.produkte.addItem(aProdukt);
		_root.zeigeDebug("addProdukt: " + aProdukt);
		// TODO: Sonderfälle bzgl. Allnet Flats prüfen
		pruefeSonderfaelle(aProdukt);
	}
	
	/**
	 * Prüft die Sonderfälle nzgl Allnet Flats
	 * 1. Allnet Flat 500 mit BASE Flat und Festnetz Flatz wird zu Allnet Flat
	 * 2. Allnet Flat löscht BASE Flat und / oder Festnetz Flat
	 */
	private function pruefeSonderfaelle(aProdukt : IProdukt ) : Void {
		// je nach produkt
		switch (aProdukt.getId()) {
			// Allnet Flat 500
			case BeraterTarifOption.ALLNET_FLAT_500 :
				// BASE Flat und Festnetz Flat
				if (isProduktIdEnthalten(BeraterTarifOption.BASE_FLAT) && isProduktIdEnthalten(BeraterTarifOption.FESTNETZ_FLAT)) {
					// Allnet Flat 
					var produkt : IProdukt = AbstractProdukt.getProdukt(BeraterTarifOption.ALLNET_FLAT);
					// sichtbar schalten
					produkt.setVisible(true);
					// hinzufügen
					addProdukt(produkt);	
				}
				
				break;
				
			// Allnet Flat
			case BeraterTarifOption.ALLNET_FLAT :
				// BASE Flat löschen
				if (isProduktIdEnthalten(BeraterTarifOption.BASE_FLAT))
					removeProdukt(getProdukt(BeraterTarifOption.BASE_FLAT));
				// Festnetz Flat löschen
				if (isProduktIdEnthalten(BeraterTarifOption.FESTNETZ_FLAT))
					removeProdukt(getProdukt(BeraterTarifOption.FESTNETZ_FLAT));
				// Allnet Flat 500 löschen
				if (isProduktIdEnthalten(BeraterTarifOption.ALLNET_FLAT_500))
					removeProdukt(getProdukt(BeraterTarifOption.ALLNET_FLAT_500));
			
				break;	
		}
	}
	
	private function getProdukt(aId : String) : IProdukt {
		// gesuchtes produkt
		var produkt : IProdukt;
		// iterator
		var iterator : Iterator = this.produkte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt
			produkt = IProdukt(iterator.next());
			// zurueck geben
			if (produkt.getId() == aId)
			 return produkt;
		}
		// nichts
		return null;
	}

	/**
	 * Entfernt ein Produkt aus dem Warenkorb
	 * @param aProdukt
	 */
	public function removeProdukt(aProdukt : IProdukt ) : Void {
		// abbrechen, wenn leer
		if (aProdukt == null)
			return;
		// unsichtbar schalten
		aProdukt.setVisible(false);
		// aus liste der produkte entfernen
		this.produkte.removeItem(aProdukt);
		;
	}

	/**
	 * Entfernt das zuletzt hinzu gefügte Produkt aus dem Warenkorb
	 */
	public function removeLetzesProdukt() : Void {
		// letztes produkt
		var produkt : IProdukt = IProdukt(this.produkte.getItemAt(this.produkte.getLength() - 1));
		// es muessen alle produkte entfernt werden, die im selben step hinzu gefuegt wurden
		var step : String = produkt.getStep();
//		_root.zeigeDebug(step);
		// entfernen
		removeProdukteAtStep(step);
	}

	/**
	 * Leert den Warenkorb
	 */
	public function leereWarenkorb() : Void {
		// alle unsichtbar
		var produkt : IProdukt;
		// iterator
		var iterator : Iterator = this.produkte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt
			produkt = IProdukt(iterator.next());
		// unsichtbar
			produkt.setVisible(false);
		}
		// leeren
		this.produkte.clear();
	}

	/**
	 * Gibt Tarife als Liste zurueck
	 * @return Tarife als Liste
	 */
	public function getTarife() : Collection {
		// tarife
		var tarife : Collection = getProduktliste(BeraterTarif);
		// zurueck geben
		return tarife;
	}

	/**
	 * Gibt Onlinevorteile als Liste zurueck
	 * @return Onlinevorteile als Liste
	 */
	public function getOnlinevorteile() : Collection {
		// tarife
		var tarife : Collection = getProduktliste(BeraterOnlineVorteil);
		// zurueck geben
		return tarife;
	}

	/**
	 * Gibt Tarifoptionen als Liste zurueck
	 * @return Tarifoptionen als Liste
	 */
	public function getTarifoptionen() : Collection {
		// tarife
		var tarife : Collection = getProduktliste(BeraterTarifOption);
		// zurueck geben
		return tarife;
	}

	/**
	 * Prüft, ob ein Produkt enthalten ist
	 * @param aProdukt
	 */
	public function isProduktEnthalten(aProdukt : IProdukt ) : Boolean {
		// alle unsichtbar
		var produkt : IProdukt;
		// iterator
		var iterator : Iterator = this.produkte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt
			produkt = IProdukt(iterator.next());
			// enthalten, wenn id passt
			if (aProdukt.getId() == produkt.getId())
				return true;
		}
		// nicht enthalten
		return false;
	}
	
	public function isProduktIdEnthalten(id :String) : Boolean {
		// alle unsichtbar
		var produkt : IProdukt;
		// iterator
		var iterator : Iterator = this.produkte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt
			produkt = IProdukt(iterator.next());
			// enthalten, wenn id passt
			if (id == produkt.getId())
				return true;
		}
		// nicht enthalten
		return false;
	}

	/**
	 * Berechnet die Summer der monatlichen Kosten für alle Produkte
	 */
	public function getPreismonatlich() : Number {
		// preis
		var preis : Number = 0;
		// iterator
		var iterator : Iterator = getProduktliste(null).getIterator();
		// aktuelles produkt
		var produkt : IProdukt;
		// durchschleifen
		while (iterator.hasNext()) {
			produkt = IProdukt(iterator.next());
			// addieren
			if (produkt.getPreismonatlich() != null)
				preis += produkt.getPreismonatlich();
		}
		// zurueck geben
		return preis;
	}
	
	/**
	 * Gibt Map der Produkte zurück
	 * @return Map der Produkte
	 */
	public function getProdukte() : Collection {
		return this.produkte;
	}
	
	/**
	 * Gibt Produkte als Collection zurück
	 * @return Produkte als Collection
	 */
	private function getProduktliste(aFunction : Function ) : Collection {
		// liste
		var liste : Collection = new CollectionImpl();
		// aktuelles produkt
		var produkt : IProdukt;
		// iterator
		var iterator : Iterator = this.produkte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt von dekorieren befreit
			produkt = IProdukt(iterator.next());
			// testen, ob gewuenschte klasse und produkt sichtbar
			if (aFunction == null || getDekoriertesProdukt(produkt) instanceof aFunction)
				if (produkt.getVisible())
					liste.addItem(produkt);
		}
		// zurueck geben
		return liste;
	}
	
	/**
	 * Entfernt alle Dekorierer
	 * @param aProdukt
	 * @return das undekorierte Produkt
	 */
	private function getDekoriertesProdukt(aProdukt : IProdukt ) : IProdukt {
		// rechnungsrabatt
		if (aProdukt instanceof Rechnungsrabatt) {
			return getDekoriertesProdukt(Rechnungsrabatt(aProdukt).getProdukt());
		}
		// zusatzkartenrabatt
		if (aProdukt instanceof Zusatzkartenrabatt) {
			return getDekoriertesProdukt(Zusatzkartenrabatt(aProdukt).getProdukt());
		}
		// original zurueck geben
		return aProdukt;
	}
	
	/**
	 * Entfernt alle Produkte, die den übergebenen step haben
	 * @param aStep
	 */
	 private function removeProdukteAtStep(aStep : String) : Void {
		// aktuelles produkt
		var produkt : IProdukt;
		// schleife, bis alle entfernt
		do {
			produkt = getProduktAtStep(aStep);
			// enfernen
			removeProdukt(produkt);
		} while (produkt != null);
	 }
	 
	 /**
	  * Liefert ein Produkt zu einem übergebenen step
	  * @return wenn mind. ein Produkt zum übergebenen step vorhanden, dann genau 1 Produkt, ansonsten null
	  */
	  private function getProduktAtStep(aStep : String) : IProdukt {
		// aktuelles produkt
		var produkt : IProdukt;
		// iterator
		var iterator : Iterator = this.produkte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt
			produkt = IProdukt(iterator.next());
			// pruefen, ob step
			if (produkt.getStep() == aStep)
				return produkt;
		}
		// nichts gefunden
		return null;
	  	
	  }
}