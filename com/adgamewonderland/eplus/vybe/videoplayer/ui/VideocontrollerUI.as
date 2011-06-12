import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoController;

class com.adgamewonderland.eplus.vybe.videoplayer.ui.VideocontrollerUI extends MovieClip
{

	private static var KEY_BACK:Number = Key.LEFT;

	private static var KEY_PLAY:Number = "P".charCodeAt(0);

	private static var KEY_FORWARD:Number = Key.RIGHT;

	private var active:Boolean;

	public var back_mc:MovieClip;

	public var play_mc:MovieClip;

	public var pause_mc:MovieClip;

	public var forward_mc:MovieClip;

	public var seek_mc:MovieClip;

	public var mute_mc:MovieClip;

	public var volume_mc:MovieClip;

	public function VideocontrollerUI() {
	}

	public function onLoad():Void
	{
		// ist der controller aktiv
		this.active = true;
		// beim videocontroller als controller registrieren
		VideoController.getInstance().setVideocontroller(this);
//		// als key listener registrieren
//		Key.addListener(this);
	}

	public function onUnload():Void
	{
//		// als key listener deregistrieren
//		Key.removeListener(this);
	}

	/**
	 * callback nach tastendruck
	 */
	public function onKeyDown():Void
	{
		// abbrechen, wenn nicht aktiv
		if (isActive() == false) return;
		// zuletzt gedrueckte taste
		var code:Number = Key.getCode();
		// je nach taste
		switch (code) {
			// back
			case KEY_BACK :
				back_mc.onRelease();

				break;
			// play
			case KEY_PLAY :
				// unterscheidung der beiden buttons play / pause
				if (play_mc.play_mc._visible) {
					play_mc.play_mc.onRelease();
				} else if (play_mc.pause_mc._visible) {
					play_mc.pause_mc.onRelease();
				}

				break;
			// forward
			case KEY_FORWARD :
				forward_mc.onRelease();

				break;
		}
	}

	public function setActive(active:Boolean):Void
	{
		this.active = active;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	public function showButton(mc:MovieClip, enabled:Boolean ):Void
	{
		// de- / aktivieren
		mc.enabled = enabled;
		// ein- / ausblenden
		mc._alpha = enabled ? 100 : 35;
		// zum normalzustand
		mc.gotoAndStop("_up");
	}
}