import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.VideoassetsImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
interface com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoassetsListener
{

	public function onVideoassetsFault(data:Object ):Void;

	public function onVideoassetsLoaded():Void;

	public function onVideoassetsParsed(videoassets:VideoassetsImpl ):Void;

	public function onMinitvlistSelected(minitvlist:MinitvlistImpl ):Void;
}
