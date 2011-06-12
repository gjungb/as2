/**
 * @author gerd
 */
class com.adgamewonderland.dhl.adventsgewinnspiel.ui.QuestionlinkUI extends MovieClip {
	
	private var _link:String;
	
	public function QuestionlinkUI() {
	}
	
	public function onRelease():Void
	{
		// link oeffnen
		getURL(_link, "_blank");	
	}
}