import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.StartUI extends MovieClip implements IApplicationControllerListener {

	function StartUI() {
		// ausblenden
		_visible = false;
	}

	public function onLoad():Void
	{
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);
	}

	public function onStateChangeInited(aState : String, aNewstate : String) : Void {
	}

	public function onStateChanged(aState:String, aNewstate:String):Void
	{
		// je nach neuem state
		switch (aNewstate) {
			// startseite
			case ApplicationController.STATE_START :
				// einblenden
				_visible = true;

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// ausblenden
				_visible = false;

				break;
		}
	}

}