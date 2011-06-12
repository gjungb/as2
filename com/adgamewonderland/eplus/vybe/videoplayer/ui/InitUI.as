import com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoassetsListener;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.VideoassetsImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.ui.InitUI extends MovieClip implements IVideoassetsListener {

	public function InitUI() {

	}

	public function onVideoassetsFault(data:Object ):Void
	{
	}

	public function onVideoassetsLoaded():Void
	{
	}

	public function onVideoassetsParsed(videoassets:VideoassetsImpl ):Void
	{
	}

	public function onMinitvlistSelected(minitvlist:MinitvlistImpl ):Void
	{
	}

}