import de.kruesch.event.*;

class de.kruesch.osterspiel.ui.KickController extends MovieClip
{
	private var _event:EventBroadcaster;
	private var mcPower:MovieClip;

	private var power:Number;
	private var delta:Number;

	public var enabled:Boolean;
	private var down:Boolean;

	private static var D_UP:Number = 8;
	private static var D_DOWN:Number = -12;

	function KickController()
	{
		_event = new EventBroadcaster();

		power = 0;
		delta = 0;

		down = false;

		enabled = true;
	}

	function onMouseDown() : Void
	{		
		down = true;
		if (!enabled) return;

		delta = D_UP;
	}

	function onMouseUp() : Void
	{
		down = false;
		if (!enabled) return;

		delta = D_DOWN;
		_event.send("onKickOff",power);
	}

	function onEnterFrame() : Void
	{
		power += delta;

		if (power<0) power = 0;
		if (power>100) power = 100;

		mcPower._y = 19 - power*95/100;
	}

	function addListener(o) : Void
	{
		_event.addListener(o);
	}

	function removeListener(o) : Void
	{
		_event.removeListener(o);
	}

	function enable() : Void
	{
		enabled = true;

		if (down) delta = D_UP;
	}

	function disable() : Void
	{	
		enabled = false;
		delta = D_DOWN;
	}

};
