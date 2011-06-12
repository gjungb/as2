import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.interfaces.IVideoControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.controllers.ApplicationController;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.application.DebugUI extends MovieClip implements IPresentationControllerListener, IVideoControllerListener {

	private var debug1_txt:TextField;

	private var debug2_txt:TextField;

	private var debug3_txt:TextField;

	public function DebugUI() {
		// nur im debug-modus einblenden
		_visible = ApplicationController.getInstance().isDebug();
		// textfelder linksbuendig
		debug1_txt.autoSize = "left";
		debug2_txt.autoSize = "left";
		debug3_txt.autoSize = "left";
	}

	public function onLoad():Void
	{
		// beim presentationcontroller als listener registrieren
		PresentationController.getInstance().addListener(this);
		// beim videocontroller als listener registrieren
		VideoController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		PresentationController.getInstance().removeListener(this);
		// als listener deregistrieren
		VideoController.getInstance().removeListener(this);
	}


	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl):Void {
		debug1_txt.text = newstate.toString();
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem):Void {
		debug2_txt.text = item.getVideo().getFilename();
	}

	public function onToggleFullscreen(bool:Boolean):Void {
		debug3_txt.text = "fullscreen: " + bool;
	}

	public function onItemSelected(item:PlaylistVideoItem):Void {
	}

	public function onItemsPlayed(items:Array):Void {
	}

}