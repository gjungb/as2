import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import mx.utils.Delegate;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.LayerUI extends MovieClip implements IApplicationControllerListener {

	private var blind_btn:Button;

	private var show_btn:Button;

	function LayerUI() {
	}

	public function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);
		// blind button ohne cursor
		blind_btn.useHandCursor = false;
		// blind button ausblenden
		blind_btn._visible = false;
		// button zum einblenden
		show_btn.onRelease = Delegate.create(this, showLayer);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);
	}

	public function showLayer():Void
	{
		// blind button einblenden
		blind_btn._visible = true;
		// gewinne einblenden
		gotoAndPlay("frIn");
	}

	public function hideLayer():Void
	{
		// blind button ausblenden
		blind_btn._visible = false;
		// gewinne ausblenden
		gotoAndPlay("frOut");
	}

	public function onStateChangeInited(aState:String, aNewstate:String ):Void
	{
	}

	public function onStateChanged(aState:String, aNewstate:String ):Void
	{
		// einblenden
		_visible = aNewstate != ApplicationController.STATE_INIT;
	}

}