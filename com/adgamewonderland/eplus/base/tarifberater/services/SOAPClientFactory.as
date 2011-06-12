/**
 * @author gerd
 */
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterSOAPClient;
import com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;

class com.adgamewonderland.eplus.base.tarifberater.services.SOAPClientFactory extends ClientFactory {

	public function getInstance() : TarifberaterClient {
		return TarifberaterSOAPClient.getInstance();
	}
}