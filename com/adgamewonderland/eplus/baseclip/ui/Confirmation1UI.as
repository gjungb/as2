import mx.utils.Delegate;
import com.adgamewonderland.eplus.baseclip.controllers.ParticipationController;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.Confirmation1UI extends MovieClip {

	private var videos_btn:Button;

	private var tellafriend_btn:Button;

	public function Confirmation1UI() {

	}

	private function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// button videos ansehen
		videos_btn.onRelease = Delegate.create(this, doVideos);
		// button tellafriend
		tellafriend_btn.onRelease = Delegate.create(this, doTellafriend);
		// als ui beim controller registrieren
		ParticipationController.getInstance().addUI(this, ParticipationController.STATUS_CONFIRMATION);
	}

	private function doVideos():Void
	{
		// TODO: verlinkung zu videogalerie
	}

	private function doTellafriend():Void
	{
		// TODO: verlinkung zu tellafriend-formular
	}

	private function onUnload():Void
	{
		// als ui beim controller deregistrieren
		ParticipationController.getInstance().removeUI(this, ParticipationController.STATUS_CONFIRMATION);
	}

}