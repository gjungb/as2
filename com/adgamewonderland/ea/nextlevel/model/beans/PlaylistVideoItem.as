import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;

class com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem extends PlaylistItem
{
	private var video:Video;

	public function PlaylistVideoItem()
	{
		super();
	}

	public function setVideo(video:Video):Void
	{
		this.video = video;
	}

	public function getVideo():Video
	{
		return this.video;
	}

	public function toString() : String {
		return "com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem " + getID() + ", " + getVideo().debugTrace();
	}
}