import com.adgamewonderland.ea.nextlevel.model.beans.Playlist;

interface com.adgamewonderland.ea.nextlevel.interfaces.IPlaylistConnectorListener
{

	public function onPlaylistLoaded(playlist:Playlist):Void;

	public function onPlaylistUpdated(id:Number):Void;

	public function onPlaylistSaved(id:Number):Void;
}