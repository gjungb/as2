import com.adgamewonderland.eplus.basecasting.ui.VideoplayerUI;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.VideocontrollerUI extends MovieClip {

	public var back_mc:MovieClip;

	public var play_mc:MovieClip;

	public var pause_mc:MovieClip;

	public var seek_mc:MovieClip;

	function VideocontrollerUI() {
	}

	public function onLoad():Void
	{
		// als controller registrieren
		VideoplayerUI(_parent).registerVideocontroller(this);
	}

}