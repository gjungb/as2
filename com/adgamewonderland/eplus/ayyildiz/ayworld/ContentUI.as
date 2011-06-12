import com.adgamewonderland.eplus.ayyildiz.ayworld.Controller;

class com.adgamewonderland.eplus.ayyildiz.ayworld.ContentUI extends MovieClip 
{

	public function ContentUI()
	{
	}
	
	public function onLoad():Void
	{
		// als listener registrieren
		Controller.getInstance().addListener(this);
	}
	
	public function onUnload():Void
	{
		// als listener deregistrieren
		Controller.getInstance().removeListener(this);
	}

	public function showContent(content:Number ):Void
	{
		// content anzeigen
		gotoAndPlay("fr" + content);
	}
}