import com.adgamewonderland.ea.nextlevel.io.connectors.ChapterConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.PlaylistConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.RepositoryConnector;
import com.adgamewonderland.ea.nextlevel.io.connectors.VideoConnector;
import com.adgamewonderland.ea.nextlevel.io.factories.ConnectorFacory;

class com.adgamewonderland.ea.nextlevel.io.connectors.ConnectorPool
{

	private var factory:ConnectorFacory;

	private var repositoryconn:RepositoryConnector;

	private var playlistconn:PlaylistConnector;

	private var chapterconn:ChapterConnector;

	private var videoconn:VideoConnector;

	private function ConnectorPool(factory:ConnectorFacory)
	{
		// abstrakt
	}

	public function init():Void
	{
		// connectors mit abstrakter factory erzeugen
		this.chapterconn = this.factory.createChapterConnector();
		this.playlistconn = this.factory.createPlaylistConnector();
		this.repositoryconn = this.factory.createRepositoryConnector();
		this.videoconn = this.factory.createVideoConnector();
	}

	public function setRepositoryconn(repositoryconn:RepositoryConnector):Void
	{
		this.repositoryconn = repositoryconn;
	}

	public function getRepositoryconn():RepositoryConnector
	{
		return this.repositoryconn;
	}

	public function setPlaylistconn(playlistconn:PlaylistConnector):Void
	{
		this.playlistconn = playlistconn;
	}

	public function getPlaylistconn():PlaylistConnector
	{
		return this.playlistconn;
	}

	public function setChapterconn(chapterconn:ChapterConnector):Void
	{
		this.chapterconn = chapterconn;
	}

	public function getChapterconn():ChapterConnector
	{
		return this.chapterconn;
	}

	public function setVideoconn(videoconn:VideoConnector):Void
	{
		this.videoconn = videoconn;
	}

	public function getVideoconn():VideoConnector
	{
		return this.videoconn;
	}

	public function toString() : String {
		return "com.adgamewonderland.ea.nextlevel.io.connectors.ConnectorPool";
	}
}