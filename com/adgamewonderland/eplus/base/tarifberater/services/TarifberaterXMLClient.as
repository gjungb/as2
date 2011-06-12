import mx.xpath.XPathAPI;

import com.adgamewonderland.agw.util.XMLConnector;
import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;

class com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterXMLClient extends TarifberaterClient {

	private static var _instance : TarifberaterXMLClient;
	
	private static var ZIEL_WK : String = "warenkorb";
	
	private static var ZIEL_HANDY : String = "handys";
	
	private var servleturl : String;

	public static function getInstance() : TarifberaterXMLClient {
		if (_instance == null)
			_instance = new TarifberaterXMLClient();
		return _instance;
	}
	
	public function legeErgebnissInWk(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
		
		// ergebisse als xml
		var xml : XML = erzeugeXML(ZIEL_WK, aPara1, aPara2);
		
		_root.zeigeDebug("TarifberaterClient >>> legeErgebnissInWk: " + xml);
		
		// xml senden
		sendeXML(xml);
	}

	public function onLegeErgebnissInWk(result : Object) : Void {
		// listener informieren
		_event.send("onLegeErgebnissInWk", result);
	}

	public function waehleHardwareZumErgebniss(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
		
		_root.zeigeDebug("TarifberaterClient >>> waehleHardwareZumErgebniss: " + erzeugeXML(ZIEL_HANDY, aPara1, aPara2));
		
		// ergebisse als xml
		var xml : XML = erzeugeXML(ZIEL_HANDY, aPara1, aPara2);
		// xml senden
		sendeXML(xml);
	}

	public function onWaehleHardwareZumErgebniss(result : Object) : Void {
		// listener informieren
		_event.send("onWaehleHardwareZumErgebniss", result);
	}
	
	private function TarifberaterXMLClient() {
		// url des servlets
		this.servleturl = (_url.indexOf("http") == -1 ?  "http://192.168.0.5:8080/base_development_v3r/tarife/TarifberaterServlet" : "TarifberaterServlet");
	}

	/**
	 * Sendet Ergebnisse als XML an das Servlet
	 */
	private function sendeXML(aXML : XML ) : Void {
		// sender
		var sender : LoadVars = new LoadVars();
		// xml
		sender["xml"] = aXML;
		// receiver
		var receiver : LoadVars = new LoadVars();
		// callback
		receiver.onLoad = function (aSuccess : Boolean ) : Void {
			// ergebnis
			var result : String = this["xml"];
			// "callback"
			TarifberaterXMLClient.getInstance().onXMLResult(result);
		};
		// senden
		sender.sendAndLoad(this.servleturl, receiver, "GET");
	}
	
	/**
	 * Callback nach Senden der Ergebnisse
	 * @param aResult
	 */
	public function onXMLResult(aResult : String ) : Void {
		// result als xml
		var xml : XML = new XML(aResult);
		// result
		var result : XMLNode = XPathAPI.selectSingleNode(xml.firstChild, "/root/result");
		// url
		var url : String = result.firstChild.nodeValue;
		// leerzeichen ersetzen
		url = url.split(" ").join("&");
		// redirect
		ApplicationController.getInstance().redirectAction(url);
	}
	
	/**
	 * Erzeugt XML zur Übergabe an das Servlet
	 */
	private function erzeugeXML(aZiel : String, aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : XML {
		// ergebnis als xml
		var result : XML;
		// connector
		var conn : XMLConnector = new XMLConnector(this, "");
		// head
		result = conn.getXMLHead("root", {});
		// ziel
		var ziel : XMLNode = conn.getXMLNode("ziel", {});
		ziel.appendChild(result.createTextNode(aZiel));
		result.firstChild.appendChild(ziel);
		// ergebnis 1
		if (aPara1 != null)
			result.firstChild.appendChild(aPara1.toXML("para1"));
		// ergebnis 2
		if (aPara2 != null)
			result.firstChild.appendChild(aPara2.toXML("para2"));
		// zurueck geben
		return result;
	}
}