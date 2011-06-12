/**
 * @author gerd
 */

import de.kruesch.event.*;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.VideoItemUI extends MovieClip {
	
	public static var HEIGHT:Number = 85;
	
	public static var WIDTH:Number = 148;
	
	public static var YDIFF:Number = 0;
	
	private static var XPOS:Number = 10;
	
	private static var YPOS:Number = 7;
	
	private var _item:VideoItem;
	
	private var item:VideoItem;
	
	private var _event:EventBroadcaster;
	
	private var thumb_mc:MovieClip;
	
	public function VideoItemUI() {
		this.item = _item;
		useHandCursor = false;
		// event handling
		_event = new EventBroadcaster();
	}
	
	public function onLoad():Void
	{
		// registrieren
		VideoPlayer.getInstance().addListener(this);
		// thumb platzhalter
		thumb_mc = createEmptyMovieClip("thumb_mc", 1);
		// positionieren
		thumb_mc._x = XPOS;
		thumb_mc._y = YPOS;
		// thumb laden
		thumb_mc.loadMovie(getItem().getThumb(), null);
		
		// erstes video automatisch abspielen
		if (getItem().getId() == 0) onPress();
	}
	
	public function addListener(l ):Void
	{
		_event.addListener(l);
	}
	
	public function removeListener(l ):Void
	{
		_event.removeListener(l);
	}
	
	public function onPress():Void
	{
		// video wechseln
		VideoPlayer.getInstance().changeItem(getItem());
	}
	
	public function onChangeItem(item:VideoItem ):Void
	{
		// button aktivieren / deaktivieren
		enabled = (item != getItem());
		// rahmen einblenden / ausblenden
		gotoAndStop(item == getItem() ? "_over" : "_up");
	}
	
	public function onMouseMove():Void
	{
		// hit test
		if (this.hitTest(_root._xmouse, _root._ymouse, false)) {
			// event
			_event.send("onThumbMouseMove", this);
		}
	}
	
	public function getItem():VideoItem {
		return item;
	}

	public function setItem(item:VideoItem):Void {
		this.item = item;
	}

}