/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.HeadlineUI extends MovieClip {

	function HeadlineUI() {
	}

	public function showHeadline(aId:Number ):Void
	{
		// einblenden
		_visible = true;
		// hinspringen
		gotoAndStop(aId + 1);
	}

}