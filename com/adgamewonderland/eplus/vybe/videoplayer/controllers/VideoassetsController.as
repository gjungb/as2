import mx.data.components.XMLConnector;
import mx.utils.Delegate;

import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.VideoassetsImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.DefaultController;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;

class com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoassetsController extends DefaultController implements IEventBroadcaster
{
	private static var _instance:VideoassetsController;

	private var videoassets:VideoassetsImpl;

	public function loadVideoassets(aUrl:String ):Void
	{
		// xml connector
		var conn:XMLConnector = new XMLConnector();
		// url setzen
		conn.URL = aUrl;
		// nur lesen
		conn.direction = "receive";
		// ohne leerzeichen
		conn.ignoreWhite = true;
		// nur eine verbindung
		conn.multipleSimultaneousAllowed = false;
		// als listener registrieren
		conn.addEventListener("status", Delegate.create(this, onVideoassetsStatus));
		conn.addEventListener("result", Delegate.create(this, onVideoassetsLoaded));
		// laden
		conn.trigger();
	}

	public function onVideoassetsStatus(event:Object ):Void
	{
		// fehlerbehandlung
		if (event.code == "Fault") {
			// listener informieren
			_event.send("onVideoassetsFault", event.data);
		}
	}

	public function onVideoassetsLoaded(event:Object ):Void
	{
		// videoassets als xml
		var node:XMLNode = event.target.results.firstChild;
		// parsen
		getVideoassets().parseXML(node);
		// listener informieren
		_event.send("onVideoassetsParsed", getVideoassets());
	}

	public function selectMinitvlist(category:String ):Void
	{
		// entsprechende minitvlist
		var minitvlist:MinitvlistImpl = getVideoassets().getMinitvlistByCategory(category);
		// listener informieren
		if (minitvlist != null) _event.send("onMinitvlistSelected", minitvlist);
	}

	public function getVideoassets():VideoassetsImpl
	{
		return this.videoassets;
	}

	public function toString() : String {
		return "VideoassetsController";
	}

	/**
	 * @return singleton instance of VideoassetsController
	 */
	public static function getInstance() : VideoassetsController {
		if (_instance == null)
			_instance = new VideoassetsController();
		return _instance;
	}

	private function VideoassetsController() {
		super();
		// videoassets
		this.videoassets = new VideoassetsImpl();
	}
}
