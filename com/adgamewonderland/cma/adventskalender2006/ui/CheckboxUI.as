import mx.utils.Delegate;

class com.adgamewonderland.cma.adventskalender2006.ui.CheckboxUI extends MovieClip 
{
	private var _status:Boolean;
	private var status:Boolean;
	private var cross_mc:MovieClip;
	private var check_mc:MovieClip;

	public function CheckboxUI()
	{
		// status der checkbox
		setStatus(_status);
		// status wechseln
		check_mc.onRelease = Delegate.create(this, switchStatus);
	}

	public function switchStatus():Void
	{
		// status wechseln
		setStatus(!isStatus());
	}

	public function setEnabled(bool:Boolean):Void
	{
		// an- / ausschalten
		check_mc.enabled = bool;
	}

	public function setStatus(status:Boolean):Void
	{
		this.status = status;
		// kreuz ein- / ausblenden
		cross_mc._visible = status;
	}

	public function isStatus():Boolean
	{
		return this.status;
	}
}