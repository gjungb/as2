/**
 * @author gerd
 */
 
import mx.utils.Delegate;

import com.adgamewonderland.agw.util.TimelineFollower;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.ControllerUI extends MovieClip {
	
	private var pause:Boolean;
	
	private var stop_mc:MovieClip;
	
	private var play_mc:MovieClip;
	
	private var next_mc:MovieClip;
	
	private var download_mc:MovieClip;
	
	public function ControllerUI() {
		this.pause = true;
	}
	
	public function onLoad():Void
	{
		// registrieren
		VideoPlayer.getInstance().addListener(this);
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "initController");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
	}
	
	public function initController():Void
	{
		// stop
		stop_mc.onPress = Delegate.create(this, onPressStop);
		// pause
		play_mc.onPress = Delegate.create(this, onPressPause);
		// next
		next_mc.onPress = Delegate.create(this, onPressNext);
		// download
		download_mc.onPress = Delegate.create(this, onPressDownload);
		// pause
		setPause(true);
	}
	
	public function onPressStop():Void
	{
		// stoppen
		VideoPlayer.getInstance().stopVideo();
	}
	
	public function onPressPause():Void
	{
		// button umschalten
		setPause(!getPause());
		// pausieren / abspielen
		VideoPlayer.getInstance().pauseVideo(getPause());	
	}
	
	public function onPressNext():Void
	{
		// naechstes
		VideoPlayer.getInstance().nextVideo();	
	}
	
	public function onPressDownload():Void
	{
		// download des aktuellen
		VideoPlayer.getInstance().downloadVideo();	
	}
	
	public function onStartVideo():Void
	{
		// keine pause
		setPause(false);
	}
	
	public function onStopVideo():Void
	{
		// pause
		setPause(true);
	}
	
	public function getPause():Boolean {
		return pause;
	}

	public function setPause(pause:Boolean):Void {
		this.pause = pause;
		play_mc.gotoAndStop(pause ? "frPause" : "frPlay");
	}

}