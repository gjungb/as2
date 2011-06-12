import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;import mx.utils.Collection;import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
class com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand implements IZustand, ITarifberaterAutomatLsnr  {
	private var automat : TarifberaterAutomat;		private var id : String;		private var frage : Frage;		private var fortschritt : Number;

	/**
	 * "abstrakter" Konstruktor
	 */
	private function AbstractZustand(aAutomat : TarifberaterAutomat ) {
		// automat
		this.automat = aAutomat;		// als listener registrieren		this.automat.addListener(this);		// id		this.id = "AbstractZustand";		// fortschritt		this.fortschritt = 0;		// frage		this.frage = new Frage();
	}
	public function getId() : String {
		return this.id;
	}	public function getFortschritt() : Number {		return this.fortschritt;	}		public function getFrage() : Frage {		return this.frage;	}
	
	public function produktWaehlenMoeglich(aProdukt : IProdukt ) : Boolean {
		// grundsaetzlich ist es moeglich, ein produkt zu waehlen
		return true;
	}

	public function produktWaehlen(aProdukt : IProdukt) : Void {
		trace("produktWaehlen noch nicht implementiert: " + this.automat.getZustand());
	}
	
	public function zurueckGehenMoeglich() : Boolean {
		// grundsaetzlich ist es moeglich, einen schritt zurueck zu gehen, ausser im start zustand
		return isStartZustand() == false;
	}
	public function zurueckGehen() : Void {
		// letzes produkt loeschen
		this.automat.getBerater().removeLetzesProdukt();
		// aktuellen zustand aus weg entfernen
		this.automat.getWeg().removeItem(this.automat.getZustand());
		// zum letzten zustand
		this.automat.setZustand(IZustand(this.automat.getWeg().getItemAt(this.automat.getWeg().getLength() - 1)));
	}
	
	public function vorwaertsGehenMoeglich() : Boolean {
		// grundsaetzlich ist es nicht moeglich, einen schritt vorwaerts zu gehen
		return false;
	}
	
	public function vorwaertsGehen() : Void {
		trace("vorwaertsGehen noch nicht implementiert: " + this.automat.getZustand());
	}
	
	public function warenkorbBestellenMoeglich() : Boolean {
		// grundsaetzlich ist es nicht moeglich, zu bestellen
		return false;
	}
	
	public function warenkorbBestellen(aSessionid : String ) : Void {
		// an tarifberater melden
		this.automat.getBerater().bestellenAction(aSessionid, this.automat.getWegString());
	}

	public function handyAuswaehlenMoeglich() : Boolean {
		// identisch zu warenkorb bestellen
		return warenkorbBestellenMoeglich();
	}
	
	public function handyAuswaehlen(aSessionid : String ) : Void {
		// an tarifberater melden
		this.automat.getBerater().hardwareAction(aSessionid, this.automat.getWegString());
	}
	
	public function neuStartenMoeglich() : Boolean {		// grundsaetzlich ist es moeglich, neu zu starten, ausser im start zustand		return isStartZustand() == false;
	}
	
	public function neuStarten() : Void {
		trace("neuStarten noch nicht implementiert: " + this.automat.getZustand());
	}		public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {	}		public function equals(aZustand : IZustand) : Boolean {		return this.id == aZustand.getId();	}		public function isStartZustand() : Boolean {		return this.equals(this.automat.getKonfiguration().getStart());	}		public function isEndeZustand() : Boolean {		return this.equals(this.automat.getKonfiguration().getEnde());	}
}