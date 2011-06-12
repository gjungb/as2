import com.adgamewonderland.ea.nextlevel.io.connectors.ChapterConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.PlaylistConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.RepositoryConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.VideoConnector;

interface com.adgamewonderland.ea.nextlevel.io.factories.ConnectorFacory
{

	public function createRepositoryConnector():RepositoryConnector;

	public function createPlaylistConnector():PlaylistConnector;

	public function createChapterConnector():ChapterConnector;

	public function createVideoConnector():VideoConnector;

}