import com.adgamewonderland.ea.nextlevel.io.connectors.ChapterConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.PlaylistConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.RepositoryConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.VideoConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.XMLPlaylistConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.XMLRepositoryConnector;
import com.adgamewonderland.ea.nextlevel.io.factories.ConnectorFacory;

class com.adgamewonderland.ea.nextlevel.io.factories.XMLConnectorFactory implements ConnectorFacory
{

	public function XMLConnectorFactory()
	{
	}

	public function createRepositoryConnector():RepositoryConnector
	{
		return new XMLRepositoryConnector();
	}

	public function createPlaylistConnector():PlaylistConnector
	{
		return new XMLPlaylistConnector();
	}

	public function createChapterConnector():ChapterConnector
	{
		// Not yet implemented
		return null;
	}

	public function createVideoConnector():VideoConnector
	{
		// Not yet implemented
		return null;
	}

	public function toString() : String {
		return "com.adgamewonderland.ea.nextlevel.io.factories.XMLConnectorFactory";
	}
}