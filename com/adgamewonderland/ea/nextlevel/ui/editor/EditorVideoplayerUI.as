import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.ui.editor.DurationUI;
import com.adgamewonderland.ea.nextlevel.ui.player.VideoplayerUI;
import com.adgamewonderland.ea.nextlevel.ui.player.VideocontrollerUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.EditorVideocontrollerUI;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.editor.EditorVideoplayerUI extends VideoplayerUI {

	private var title_txt:TextField;

	private var duration_mc:DurationUI;

	public function EditorVideoplayerUI() {
		super();
		// title linksbuendig
		title_txt.autoSize = "left";
	}

	/**
	 * registriert eine videocontroller-komponente mit den entsprechenden control-komponenten
	 * @param videocontroller instanz eines videocontrollerui
	 */
	public function registerVideocontroller(videocontroller:VideocontrollerUI ):Void
	{
		super.registerVideocontroller(videocontroller);
		// controller-komponenten bei playback anmelden
		seekBar 		= EditorVideocontrollerUI(videocontroller).seek_mc;
		muteButton 		= EditorVideocontrollerUI(videocontroller).mute_mc;
		volumeBar 		= EditorVideocontrollerUI(videocontroller).volume_mc;
	}

	public function onItemSelected(item:PlaylistVideoItem ):Void
	{
		super.onItemSelected(item);
		// video
		var video:Video = getCurrentitem().getVideo();
		// title des video anzeigen
		title_txt.text 	= video.getMetainfo().getTitle();
		// duration des video anzeigen
		duration_mc.showDuration(video.getDuration());
	}

}