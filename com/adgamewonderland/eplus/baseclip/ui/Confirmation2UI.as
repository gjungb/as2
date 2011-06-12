import mx.utils.Delegate;
import com.adgamewonderland.eplus.baseclip.controllers.TellafriendController;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.Confirmation2UI extends MovieClip {

	private var videos_btn:Button;

	public function Confirmation2UI() {

	}

	private function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// button videos ansehen
		videos_btn.onRelease = Delegate.create(this, doVideos);
		// als ui beim controller registrieren
		TellafriendController.getInstance().addUI(this, TellafriendController.STATUS_CONFIRMATION);
	}

	private function doVideos():Void
	{
		// TODO: verlinkung zu videogalerie
	}

	private function onUnload():Void
	{
		// als ui beim controller deregistrieren
		TellafriendController.getInstance().removeUI(this, TellafriendController.STATUS_CONFIRMATION);
	}

}