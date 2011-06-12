import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.BlindUI extends MovieClip implements IApplicationControllerListener {

	function BlindUI() {
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

	public function onStateChanged(aState:String, aNewstate:String ):Void
	{
	}

	public function onStateChangeInited(aState:String, aNewstate:String):Void
	{
		// abspielen
		gotoAndPlay("frIn");
	}

}