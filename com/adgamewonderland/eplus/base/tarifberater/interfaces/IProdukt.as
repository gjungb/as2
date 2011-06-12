interface com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt 
{

	/**
	 * @return Die eindeutige ID
	 */
	public function getId():String;

	/**
	 * @return Der Name
	 */
	public function getName():String;

	/**
	 * @return Ein optionaler Zusatztext
	 */
	public function getZusatztext():String;

	/**
	 * @return Der einmalig zu zahlende Preis
	 */
	public function getPreiseinmalig():Number;

	/**
	 * @return Der Streichpreis des einmalig zu zahlenden Preises
	 */
	public function getStreichpreiseinmalig():Number;

	/**
	 * @return Der monatlich zu zahlende Preis
	 */
	public function getPreismonatlich():Number;
	
	public function setPreismonatlich(aValue : Number) : Void;

	/**
	 * @return Der Streichpreis des monatlich zu zahlenden Preises
	 */
	public function getStreichpreismonatlich():Number;

	/**
	 * @return Soll das Produkt sichtbar sein (Für Warenkorbdarstellung etc)
	 */
	public function getVisible():Boolean;

	public function setVisible(aValue:Boolean) : Void;

	/**
	 * @return Gibt es Detailinfos zum Produkt
	 */
	public function getInfos() : Boolean;
	
	/**
	 * @return WToD Step
	 */
	 public function getStep() : String;

	public function setStep(aStep : String) : Void;
	
	public function getSapnummer() : String;

	public function setSapnummer(aSapnummer : String) : Void;
	
	/**
	 * @return eine neue Instanze des Produkts als Kopie der Instanz
	 */
	public function clone() : IProdukt;
}
