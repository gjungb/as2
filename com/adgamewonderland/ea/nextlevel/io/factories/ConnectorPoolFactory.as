import com.adgamewonderland.ea.nextlevel.io.connectors.ConnectorPool;
import com.adgamewonderland.ea.nextlevel.io.factories.XMLConnectorPoolFactory;

class com.adgamewonderland.ea.nextlevel.io.factories.ConnectorPoolFactory
{

	public static function getXMLConnectorPool():ConnectorPool
	{
		return new XMLConnectorPoolFactory().getConnectorPool();
	}

	public function getConnectorPool():ConnectorPool
	{
		// neuer konkreter pool
		var pool:ConnectorPool = createConnectorPool();
		// zurueck geben
		return pool;
	}

	private function createConnectorPool():ConnectorPool
	{
		// abstrakt
		return null;
	}

	private function ConnectorPoolFactory()
	{
		// abstrakt
	}
}