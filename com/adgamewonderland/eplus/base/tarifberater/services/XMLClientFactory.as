/**
 * @author gerd
 */
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterXMLClient;
import com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient;
import com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory;

class com.adgamewonderland.eplus.base.tarifberater.services.XMLClientFactory extends ClientFactory {

	public function getInstance() : TarifberaterClient {
		return TarifberaterXMLClient.getInstance();
	}
}