import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
interface com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand {
	
	public function getId() : String;
	
	public function getFrage() : Frage;
	
	public function produktWaehlenMoeglich(aProdukt : IProdukt ) : Boolean;
	
	public function produktWaehlen(aProdukt : IProdukt ) : Void;
	
	public function zurueckGehenMoeglich() : Boolean;
	
	public function zurueckGehen() : Void;
	
	public function vorwaertsGehenMoeglich() : Boolean;
	
	public function vorwaertsGehen() : Void;
	
	public function warenkorbBestellenMoeglich() : Boolean;
	
	public function warenkorbBestellen(aSessionid : String ) : Void;
	
	public function handyAuswaehlenMoeglich() : Boolean;
	
	public function handyAuswaehlen(aSessionid : String ) : Void;
	
	public function neuStartenMoeglich() : Boolean;
	
	public function neuStarten() : Void;
}