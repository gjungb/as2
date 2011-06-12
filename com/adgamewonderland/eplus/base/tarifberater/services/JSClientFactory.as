import com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterJSClient;

class com.adgamewonderland.eplus.base.tarifberater.services.JSClientFactory extends ClientFactory {
	
	public function getInstance() : TarifberaterClient {
		return TarifberaterJSClient.getInstance();
	}

}
