import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.controllers.VideoController;
import com.adgamewonderland.eplus.basecasting.interfaces.IVideoControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.LayerUI;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.TellafriendaniUI extends LayerUI implements IVideoControllerListener {

	function TellafriendaniUI() {
	}

	public function onLoad():Void
	{
		super.onLoad();
		// als listener registrieren
		VideoController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		super.onUnload();
		// als listener deregistrieren
		VideoController.getInstance().removeListener(this);
	}

	public function onClipSelected(aClip:Clip ):Void
	{
	}

	public function onVotingStarted(aClip:Clip ):Void
	{
	}

	public function onTellafriendStarted(aClip:Clip ):Void
	{
		// einblenden
		showLayer();
	}

}