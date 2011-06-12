import com.adgamewonderland.eplus.ayyildiz.ayworld.*;

class com.adgamewonderland.eplus.ayyildiz.ayworld.Controller implements IEventBroadcaster 
{
	private static var instance:com.adgamewonderland.eplus.ayyildiz.ayworld.Controller;
	private var event:com.adgamewonderland.eplus.ayyildiz.ayworld.EventBroadcaster;

	public static function getInstance():com.adgamewonderland.eplus.ayyildiz.ayworld.Controller
	{		if (instance == null)
			instance = new Controller();
		return instance;
	}

	private function Controller()
	{
		// event broadcaster
		this.event = new EventBroadcaster();
	}

	public function onUpdateSelector(selected:Number ):Void
	{
		// listener informieren
		getEvent().send("showContent", selected);
	}

	public function setEvent(event:com.adgamewonderland.eplus.ayyildiz.ayworld.EventBroadcaster):Void
	{
		this.event = event;
	}

	public function getEvent():com.adgamewonderland.eplus.ayyildiz.ayworld.EventBroadcaster
	{
		return this.event;
	}

	public function addListener(l:Object):Void
	{
		// als listener registrieren
		getEvent().addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		// als listener abmelden
		getEvent().removeListener(Object(l));
	}
}