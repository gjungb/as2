class de.kruesch.event.EventBroadcaster
{
	private var _listeners : Array;
	
	function EventBroadcaster()
	{
		AsBroadcaster.initialize(this);	
		
		send = broadcastMessage;
	}
		
	// stubs
	function addListener(o:Object) : Void {}
	function removeListener(o:Object) : Void {}	
	function send() : Void {}
	
	private function broadcastMessage() : Void {}
	
	function getListeners() : Array
	{
		return _listeners.concat();
	}
	
	function get listenerCount() : Number
	{
		return _listeners.length;
	}
}
