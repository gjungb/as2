import mx.utils.Collection;

import com.adgamewonderland.eplus.base.tarifberater.interfaces.IArtikel;

class com.adgamewonderland.eplus.base.tarifberater.beans.Artikel implements IArtikel 
{

	/**
	 * @return Die Position des Artikels im Warenkorb
	 */
	public function getPosition():Number
	{
		// Not yet implemented
		return 0;
	}

	public function setPosition(aPosition:Number):Void
	{
		// Not yet implemented
	}

	/**
	 * @return Die Liste aller Produkte, die diesem Artikel zugeordnet sind
	 */
	public function getProduktliste():Collection
	{
		// Not yet implemented
		return null;
	}

	/**
	 * @return Die Anzahl der Produkte, die dem Artikel zugeordnet sind
	 * TODO: wie sieht das aus mit dem Ändern der Anzahl? Ist das wirklich die Anzahl der Produkte, oder die Anzahl der Artikel
	 */
	public function getAnzahl():Number
	{
		// Not yet implemented
		return 0;
	}

	public function setAnzahl(aNewVal:Number):Void
	{
		// Not yet implemented
	}

	/**
	 * @return Die Summe der monatlich zu zahlenden Preise der einzelnen Produkte (Mul mit Anzhahl)
	 */
	public function getGesamtpreismonatlich():Number
	{
		// Not yet implemented
		return 0;
	}

	public function getGesamtErsparnissMonatlich():Number
	{
		// Not yet implemented
		return 0;
	}

	/**
	 * @return Die Summe der einmalig zu zahlenden Preise der einzelnen Produkte
	 */
	public function getGesamtpreiseinmalig():Number
	{
		// Not yet implemented
		return 0;
	}

	public function getGesamtErsparnissEinmalig():Number
	{
		// Not yet implemented
		return 0;
	}

	/**
	 * @return Anschlusspreise
	 */
	public function getGesamtanschlusspreis():Number
	{
		// Not yet implemented
		return 0;
	}

	/**
	 * @return Die Summe der monatlich zu zahlenden Preise der einzelnen Produkte (für Anzahl 1)
	 */
	public function getZeilenpreismonatlich():Number
	{
		// Not yet implemented
		return 0;
	}

	/**
	 * @return Die Summe der einmalig zu zahlenden Preise der einzelnen Produkte
	 */
	public function getZeilenpreiseinmalig():Number
	{
		// Not yet implemented
		return 0;
	}
}
