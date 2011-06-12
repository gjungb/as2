import de.kruesch.event.*;

class de.kruesch.event.OEFTimer
{
	private static var _DEPTH : Number = 12345;
	private static var _clockMC : MovieClip = null;
	private static var _event : EventBroadcaster = new EventBroadcaster();
	
	private static function createClock() : Void
	{
		if (_clockMC instanceof MovieClip) return;
		
		var l0:MovieClip = _level0;
		var d:Number = _DEPTH;
		
		while (l0.getInstanceAtDepth(d)!=null) d++;
		_clockMC = l0.createEmptyMovieClip("__clock__",d);
		
		var e = _event;
		_clockMC.onEnterFrame = function()
		{
			e.send("onEnterFrame");
		}
	}
	
	private static function deleteClock() : Void
	{
		if (_clockMC!=null) 
		{
			_clockMC.removeMovieClip();
			_clockMC = null;
		}
	}
	
	static function addListener(o:IFrameListener) : Void
	{
		_event.addListener(Object(o));		
		createClock();
	}	
	
	static function removeListener(o:IFrameListener) : Void
	{
		_event.removeListener(Object(o));
		if (_event.listenerCount<1) deleteClock();
	}	
	
	private function OEFTimer() {}
}

