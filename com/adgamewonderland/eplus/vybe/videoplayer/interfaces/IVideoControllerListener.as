import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import mx.utils.Collection;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoControllerListener {

	public function onItemSelected(item:AssetImpl ):Void;

	public function onItemsPlayed(items:Collection ):Void;

}