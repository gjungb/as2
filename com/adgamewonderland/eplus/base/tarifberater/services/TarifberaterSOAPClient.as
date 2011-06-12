import mx.services.Log;
import mx.services.PendingCall;
import mx.services.WebService;
import mx.utils.Delegate;

import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;

class com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterSOAPClient extends TarifberaterClient {

	private static var _instance : TarifberaterSOAPClient;

	private var wsdl : String = "http://192.168.0.217:8080/base_tarifberater/TarifberaterService?wsdl";
	
	private var ws:WebService;
	
	private var log:Log;
	
	private var loglevel:Number = Log.BRIEF;

	public static function getInstance() : TarifberaterSOAPClient {
		if (_instance == null)
			_instance = new TarifberaterSOAPClient();
		return _instance;
	}

	/**
	 * Legt einen oder mehrere Ergebnisse in den Warenkorb.
	 * 
	 * @param para
	 */
	public function legeErgebnissInWk(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
		
		_root.zeigeDebug("TarifberaterClient >>> aPara1: " + aPara1);
		
		_root.zeigeDebug("TarifberaterClient >>> aPara2: " + aPara2);
		
		// an service uebergeben
		var pc : PendingCall = this.ws.legeErgebnissInWk(aPara1, aPara2);
		// callback fuer result
		pc.onResult = Delegate.create(this, onLegeErgebnissInWk);
	}

	public function onLegeErgebnissInWk(result : Object) : Void {
		// listener informieren
		_event.send("onLegeErgebnissInWk", result);
	}

	/**
	 * Die Beratungsergebnisse werden innerhalb der Session gespeichert,
	 * damit der benutzer ein Stück Hardware auswählen kann.
	 * 
	 * @param para
	 */
	public function waehleHardwareZumErgebniss(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
		
		_root.zeigeDebug("TarifberaterClient >>> aPara1: " + aPara1);
		
		_root.zeigeDebug("TarifberaterClient >>> aPara2: " + aPara2);
		
		// an service uebergeben
		var pc : PendingCall = this.ws.waehleHardwareZumErgebniss(aPara1, aPara2);
		// callback fuer result
		pc.onResult = Delegate.create(this, onWaehleHardwareZumErgebniss);
	}

	public function onWaehleHardwareZumErgebniss(result : Object) : Void {
		// listener informieren
		_event.send("onWaehleHardwareZumErgebniss", result);
	}

	public function getService():WebService
	{
		return this.ws;
	}

	public function setLog(aLog:Log):Void
	{
		this.log = aLog;
	}

	public function getLog():Log
	{
		return this.log;
	}

	public function setLoglevel(aLoglevel:Number):Void
	{
		this.loglevel = aLoglevel;
	}

	public function getLoglevel():Number
	{
		return this.loglevel;
	}

	private function TarifberaterSOAPClient() {
		// initialisieren
		
		this.log = new Log(this.loglevel, "DefaultLog");
		
		this.log.onLog = function (message : String) : Void {
			_root.zeigeDebug(message);
		};
		
		this.ws = new WebService(this.wsdl, this.log);
	}
}
