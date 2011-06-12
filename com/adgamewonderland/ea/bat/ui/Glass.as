class com.adgamewonderland.ea.bat.ui.Glass extends MovieClip
{
	private var btn:MovieClip;

	function Glass()
	{
		this.hitArea = btn;
		btn._visible = false;
		useHandCursor = false;
		onPress = null;
	}

	function show() : Void 
	{
		_visible = true;
	}

	function hide() : Void 
	{
		_visible = false;
	}
}