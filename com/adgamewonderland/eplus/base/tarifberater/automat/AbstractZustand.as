import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
class com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand implements IZustand, ITarifberaterAutomatLsnr  {


	/**
	 * "abstrakter" Konstruktor
	 */
	private function AbstractZustand(aAutomat : TarifberaterAutomat ) {
		// automat
		this.automat = aAutomat;
	}

		return this.id;
	}
	
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
	
	public function neuStartenMoeglich() : Boolean {
	}
	
	public function neuStarten() : Void {
		trace("neuStarten noch nicht implementiert: " + this.automat.getZustand());
	}
}