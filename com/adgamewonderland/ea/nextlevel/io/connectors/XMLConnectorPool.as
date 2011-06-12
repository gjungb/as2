import com.adgamewonderland.ea.nextlevel.io.connectors.ConnectorPool;
import com.adgamewonderland.ea.nextlevel.io.factories.ConnectorFacory;

class com.adgamewonderland.ea.nextlevel.io.connectors.XMLConnectorPool extends ConnectorPool
{

	public function XMLConnectorPool(factory:ConnectorFacory)
	{
		// abstrakte factory
		this.factory = factory;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.ea.nextlevel.io.connectors.XMLConnectorPool\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}