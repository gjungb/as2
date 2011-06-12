import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;
import flash.external.ExternalInterface;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;

class com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterJSClient extends TarifberaterClient {

	private static var instance : TarifberaterJSClient;
	
	/**
	 * @return singleton instance of TarifberaterJSClient
	 */
	public static function getInstance() : TarifberaterJSClient {
		if (instance == null)
			instance = new TarifberaterJSClient();
		return instance;
	}	
	
	public function legeErgebnissInWk(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
		// TODO: für base.de implementieren
		trace("legeErgebnissInWk 1: " + aPara1.toXML("beratungsergebnis"));
		trace("legeErgebnissInWk 2: " + aPara2.toXML("beratungsergebnis"));
		var erg1:String = "";
		var erg2:String = "";
		if(aPara1.toXML("beratungsergebnis").toString() != null){
			erg1 = aPara1.toXML("beratungsergebnis").toString();
		}
		if(aPara2.toXML("beratungsergebnis").toString() != null){
			erg2 = aPara2.toXML("beratungsergebnis").toString();
		}
		//baue extra fuer den javascript aufruf ein passendes xml
		var jsParam = "<tarifberater>"+erg1+erg2+"</tarifberater>";
		flash.external.ExternalInterface.call("tarifberaterFertig",jsParam);
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
	
	
	public function waehleHardwareZumErgebniss(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
	}
	
	public function onLegeErgebnissInWk(result : Object) : Void {
	}
	
	public function onWaehleHardwareZumErgebniss(result : Object) : Void {
	}
	
	private function TarifberaterJSClient() {
		
	}
}