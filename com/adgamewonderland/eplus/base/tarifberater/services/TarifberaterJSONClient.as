import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterJSONClient extends TarifberaterClient {

	private static var instance : TarifberaterJSONClient;
	
	/**
	 * @return singleton instance of TarifberaterJSClient
	 */
	public static function getInstance() : TarifberaterJSONClient {
		if (instance == null)
			instance = new TarifberaterJSONClient();
		return instance;
	}	
	
	/**
	 * {beratungsergebnis1:{'tarif':452,'simkarte':'SIMGERAET','tarifoptionen':'festnetzflat|allnetflat50'},beratungsergebnis2:{'tarif':452,'simkarte':'SIMGERAET','tarifoptionen':'internetlaptopflat'}}
	 */
	public function legeErgebnissInWk(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
		// gesamtergebnis als json
		var json : String = "";
		// anfang
		json += "{";
		// tarif 1
		var json1 : String = aPara1.toJSON(1);
		if (json1 != null)
			json += json1;
		// tarif 2
		var json2 : String = aPara2.toJSON(2);
		if (json2 != null)
			json += "," + json2;
		// ende
		json += "}";
		trace("legeErgebnissInWk: " + json);
		// übergabe an wen auch js
		flash.external.ExternalInterface.call("tarifberaterFertig", json);
	}
	
	public function neuStarten(aZustand : IZustand): Void {
		if(aZustand instanceof FertigZustand){
			flash.external.ExternalInterface.call("tarifberaterNeustart");
			trace("starte neu zustand "+aZustand.getId());
		}
	}
	
	public function zurueckGehen(aZustand: IZustand): Void {
		if(aZustand instanceof FertigZustand){
			flash.external.ExternalInterface.call("tarifberaterWarenkorbBack");
			trace("zurueck  "+aZustand.getId());
		}
	}
	
	private function TarifberaterJSONClient() {
		
	}
}