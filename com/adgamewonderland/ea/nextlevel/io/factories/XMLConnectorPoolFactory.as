import com.adgamewonderland.ea.nextlevel.io.connectors.ConnectorPool;
import com.adgamewonderland.ea.nextlevel.io.connectors.XMLConnectorPool;
import com.adgamewonderland.ea.nextlevel.io.factories.ConnectorFacory;
import com.adgamewonderland.ea.nextlevel.io.factories.ConnectorPoolFactory;
import com.adgamewonderland.ea.nextlevel.io.factories.XMLConnectorFactory;

class com.adgamewonderland.ea.nextlevel.io.factories.XMLConnectorPoolFactory extends ConnectorPoolFactory
{

	public function XMLConnectorPoolFactory()
	{
	}

	private function createConnectorPool():ConnectorPool
	{
		// xml basierte abstract factory
		var factory:ConnectorFacory = new XMLConnectorFactory();
		// xml basierter pool
		var pool:ConnectorPool = new XMLConnectorPool(factory);
		// initialisieren
		pool.init();
		// zurueck geben
		return pool;
	}
}