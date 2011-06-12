import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.agw.interfaces.IEventBroadcaster;

class com.adgamewonderland.agw.util.DefaultController implements IEventBroadcaster
{
	private var _event:EventBroadcaster;

	public function DefaultController() {
		this._event = new EventBroadcaster();
	}

	public function addListener(l:Object):Void
	{
		this._event.addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		this._event.removeListener(l);
	}
}
