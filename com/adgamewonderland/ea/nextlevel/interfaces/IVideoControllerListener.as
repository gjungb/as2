import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
/**
 * @author gerd
 */
interface com.adgamewonderland.ea.nextlevel.interfaces.IVideoControllerListener {

	public function onItemSelected(item:PlaylistVideoItem ):Void;

	public function onItemsPlayed(items:Array ):Void;

}