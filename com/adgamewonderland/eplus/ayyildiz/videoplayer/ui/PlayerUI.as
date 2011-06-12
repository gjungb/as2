/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.TimelineFollower;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.PlayerUI extends MovieClip {
	
	private var dummy_video:Video;
	
	public function PlayerUI() {
	}
	
	public function onLoad():Void
	{
		// registrieren
		VideoPlayer.getInstance().addListener(this);
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "initPlayer");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
	}
	
	public function initPlayer():Void
	{
		// laden
		VideoPlayer.getInstance().loadItems();
		// neues video
		dummy_video.attachVideo(VideoPlayer.getInstance().getNs());
	}
	
	public function onChangeItem(item:VideoItem ):Void
	{
		// video loeschen
		dummy_video.clear();
	}
}