import com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterJSONClient;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.services.JSONClientFactory extends ClientFactory {

	public function getInstance() : TarifberaterClient {
		return TarifberaterJSONClient.getInstance();
	}
}