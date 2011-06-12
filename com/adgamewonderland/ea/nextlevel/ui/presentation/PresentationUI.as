import com.adgamewonderland.ea.nextlevel.ui.presentation.HeadlineUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuSmallUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuBigUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationControllerUI;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationMetainfoUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationVideoplayerUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.WallpaperUI;
/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationUI extends MovieClip {

	private var headline_mc:HeadlineUI;

	private var menusmall_mc:ChapterMenuSmallUI;

	private var menubig_mc:ChapterMenuBigUI;

	private var metainfo_mc:PresentationMetainfoUI;

	private var videoplayer_mc:PresentationVideoplayerUI;

	private var wallpaper_mc:WallpaperUI;

	private var controller_mc:PresentationControllerUI;

	public function PresentationUI() {

	}

	public function onLoad():Void
	{
		// praesentation nach pause starten
		var interval:Number;
		// starten
		var doStart:Function = function():Void {
			// interval loeschen
			clearInterval(interval);
			// starten
			PresentationController.getInstance().startPresentation();
		};
		// nach pause aufrufen
		interval = setInterval(doStart, 100);
	}

}