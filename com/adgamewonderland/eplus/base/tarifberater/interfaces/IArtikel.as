import mx.utils.Collection;

interface com.adgamewonderland.eplus.base.tarifberater.interfaces.IArtikel 
{

	/**
	 * @return Die Position des Artikels im Warenkorb
	 */
	public function getPosition():Number;

	public function setPosition(aPosition:Number):Void;

	/**
	 * @return Die Liste aller Produkte, die diesem Artikel zugeordnet sind
	 */
	public function getProduktliste():Collection;

	/**
	 * @return Die Anzahl der Produkte, die dem Artikel zugeordnet sind
	 * TODO: wie sieht das aus mit dem Ändern der Anzahl? Ist das wirklich die Anzahl der Produkte, oder die Anzahl der Artikel
	 */
	public function getAnzahl():Number;

	public function setAnzahl(aNewVal:Number):Void;

	/**
	 * @return Die Summe der monatlich zu zahlenden Preise der einzelnen Produkte (Mul mit Anzhahl)
	 */
	public function getGesamtpreismonatlich():Number;

	public function getGesamtErsparnissMonatlich():Number;

	/**
	 * @return Die Summe der einmalig zu zahlenden Preise der einzelnen Produkte
	 */
	public function getGesamtpreiseinmalig():Number;

	public function getGesamtErsparnissEinmalig():Number;

	/**
	 * @return Anschlusspreise
	 */
	public function getGesamtanschlusspreis():Number;

	/**
	 * @return Die Summe der monatlich zu zahlenden Preise der einzelnen Produkte (für Anzahl 1)
	 */
	public function getZeilenpreismonatlich():Number;

	/**
	 * @return Die Summe der einmalig zu zahlenden Preise der einzelnen Produkte
	 */
	public function getZeilenpreiseinmalig():Number;
}
