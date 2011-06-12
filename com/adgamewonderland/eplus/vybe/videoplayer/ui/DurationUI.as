import com.adgamewonderland.agw.util.TimeFormater;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.ui.DurationUI extends MovieClip {

	private var duration_txt:TextField;

	public function DurationUI() {
		// duration
		duration_txt.autoSize = "left";
	}

	public function showDuration(duration:Number ):Void
	{
		// duration
		duration_txt.text = TimeFormater.getHoursMinutesSeconds(Math.round(duration), ":");
	}

}