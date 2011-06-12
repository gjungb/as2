import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;

interface com.adgamewonderland.ea.nextlevel.interfaces.IPlaylistControllerListener
{
	public function onPlaylistChanged(playlist:PlaylistImpl):Void;

	public function onPlaylistitemAdded(item:PlaylistItem, itemcount:Number):Void;

	public function onPlaylistitemRemoved(item:PlaylistItem, itemcount:Number):Void;

	public function onVideoStarted(video:Video):Void;

	public function onPlaylistStarted(items:Array):Void;
}