import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
/**
 * @author Harry
 */
interface com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener {

	public function onPresentationStateChanged(oldstate:PresentationState , newstate:PresentationState, data:PresentationImpl ):Void;

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void;

	public function onToggleFullscreen(bool:Boolean ):Void;

}