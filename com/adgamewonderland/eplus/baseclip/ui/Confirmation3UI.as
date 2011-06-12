import mx.utils.Delegate;
import com.adgamewonderland.eplus.baseclip.controllers.ContactController;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.Confirmation3UI extends MovieClip {

	private var videos_btn:Button;

	public function Confirmation3UI() {

	}

	private function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// button videos ansehen
		videos_btn.onRelease = Delegate.create(this, doVideos);
		// als ui beim controller registrieren
		ContactController.getInstance().addUI(this, ContactController.STATUS_CONFIRMATION);
	}

	private function doVideos():Void
	{
		// TODO: verlinkung zu videogalerie
	}

	private function onUnload():Void
	{
		// als ui beim controller deregistrieren
		ContactController.getInstance().removeUI(this, ContactController.STATUS_CONFIRMATION);
	}

}