/**
 * @author gerd
 */
import com.adgamewonderland.eplus.base.tarifberater.services.JSClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.JSONClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.PROClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.SOAPClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;
import com.adgamewonderland.eplus.base.tarifberater.services.XMLClientFactory;

class com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory {
	
	public static var XMLCLIENT : Number = 0;
	
	public static var SOAPCLIENT : Number = 1;
	
	public static var JSCLIENT : Number = 2;
	
	public static var PROCLIENT : Number = 3;
	
	public static var JSONCLIENT : Number = 4;
	
	public static function getFactory(aClient : Number ) : ClientFactory {
		// gesuchte factory
		var factory : ClientFactory = null;
		// logik zur ermittlung der konkreten factory
		switch (aClient) {
			case XMLCLIENT :
				factory = new XMLClientFactory();
				break;
			case SOAPCLIENT :
				factory = new SOAPClientFactory();
				break;
			case JSCLIENT :
				factory = new JSClientFactory();
				break;
			case JSONCLIENT :
				factory = new JSONClientFactory();
				break;
			case PROCLIENT :
				factory = new PROClientFactory();
				break;
		}
		// zurueck geben
		return factory;
	}

	public static function getClient(aClient : Number ) : TarifberaterClient {
		return ClientFactory.getFactory(aClient).getInstance();
	}

	/**
	 * abstrakt
	 */
	public function getInstance() : TarifberaterClient {
		return null;
	}

	/**
	 * abstrakt
	 */
	private function ClientFactory() {
		
	}
}