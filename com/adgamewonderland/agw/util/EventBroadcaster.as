

class com.adgamewonderland.agw.util.EventBroadcaster
{
	private var _listeners:Array;

	public function EventBroadcaster()
	{
		AsBroadcaster.initialize(this);

		send = broadcastMessage;
	}

	public function addListener(o):Void	{}

	public function removeListener(o):Void {}

	public function send():Void	{}

	private function broadcastMessage():Void {}

	public function getListenerCount():Number
	{
		return _listeners.length;
	}

	public function getListeners():Array
	{
		return _listeners.concat();
	}

	public function toString():String {
		return "com.adgamewonderland.agw.util.EventBroadcaster";
	}
}