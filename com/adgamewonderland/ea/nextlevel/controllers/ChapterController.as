import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl;

class com.adgamewonderland.ea.nextlevel.controllers.ChapterController implements IEventBroadcaster
{
	private static var _instance:ChapterController;

	private var _event:EventBroadcaster;

	public function selectChapter(chapter:ChapterImpl):Void
	{
		// listener informieren
		_event.send("onChapterSelected", chapter);
	}

	public static function getInstance():ChapterController
	{
		if (_instance == null)
			_instance = new ChapterController();
		return _instance;
	}

	public function addListener(l:Object):Void
	{
		this._event.addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		this._event.removeListener(l);
	}

	private function ChapterController()
	{
		this._event = new EventBroadcaster();
	}
}