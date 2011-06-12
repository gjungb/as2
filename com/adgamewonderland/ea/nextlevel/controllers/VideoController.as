import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.ui.player.VideoplayerUI;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import mx.utils.Delegate;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.ui.player.VideocontrollerUI;

class com.adgamewonderland.ea.nextlevel.controllers.VideoController implements IEventBroadcaster
{
	private static var _instance:VideoController;

	private var _event:EventBroadcaster;

	private var items:Array;

	private var pointer:Number;

	private var videoplayer:VideoplayerUI;

	private var videocontroller:VideocontrollerUI;

	/**
	 * die uebergebenen items in ihrer reihenfolge abspielen
	 * @param items array mit PlaylistVideoItem
	 * @param startat position des items, das als erstes abgespielt werden soll
	 */
	public function playItems(items:Array, startat:Number ):Void
	{
		// aktuelles video stoppen und ausblenden
		hideVideo();
		// liste der items, die abgespielt werden sollen
		setItems(items);
		// zeiger auf aktuelles item
		setPointer(startat - 1);
		// naechstes item abspielen
		nextItem();
	}

	/**
	 * testen, ob es weitere abzuspielende items gibt
	 * falls ja, naechstes item abspielen lassen
	 */
	public function nextItem():Void
	{
		// abbrechen, wenn kein item mehr uebrig
		if (this.pointer == getItems().length - 1) {
			// listener informieren
			_event.send("onItemsPlayed", getItems());
			// abbrechen
			return;
		}
		// hochzaehlen
		this.pointer++;
		// listener informieren
		_event.send("onItemSelected", getCurrentItem());
	}

	/**
	 * testen, ob es vorhergehende abzuspielende items gibt
	 * falls ja, vorhergehendes item abspielen lassen
	 */
	public function prevItem():Void
	{
		// abbrechen, wenn kein item mehr uebrig
		if (this.pointer == 0) {
			// abbrechen
			return;
		}
		// runterzaehlen
		this.pointer--;
		// listener informieren
		_event.send("onItemSelected", getCurrentItem());
	}

	/**
	 * zu einem bestimmten item springen
	 * @param startat position des items, das abgespielt werden soll
	 */
	public function gotoItem(startat:Number ):Void
	{
		// abbrechen, falls keine gueltige position
		if (startat < 0 || startat >= this.items.length) return;
		// zeiger auf aktuelles item
		setPointer(startat - 1);
		// naechstes item abspielen
		nextItem();
	}

	/**
	 * aktuell laufendes video stoppen
	 */
	public function stopVideo():Void
	{
		// testen, ob video geladen
		if (getVideoplayer().isVideoLoaded()) {
			// stoppen
			getVideoplayer().stop();
		}
	}

	/**
	 * aktuell laufendes video stoppen und ausblenden
	 */
	public function hideVideo():Void
	{
		// testen, ob video geladen
		if (getVideoplayer().isVideoLoaded()) {
			// stoppen
			getVideoplayer().stop();
			// zurueck spulen
			getVideoplayer().seekPercent(0);
			// ausblenden
			getVideoplayer().visible = false;
		}
	}

	/**
	 * ermittelt das aktuell abzuspielende item
	 * @return gibt das aktuell abzuspielende item zurueck
	 */
	public function getCurrentItem():PlaylistVideoItem
	{
		// aktuelles item
		var item:PlaylistVideoItem = getItems()[getPointer()];
		// zurueck geben
		return item;
	}

	public static function getInstance():VideoController
	{
		if (_instance == null)
			_instance = new VideoController();
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

	public function setVideoplayer(videoplayer:VideoplayerUI ):Void
	{
		// videoplayer-komponente
		this.videoplayer = videoplayer;
		// mit videocontroller-komponente bekannt machen
		if (getVideocontroller() != null) videoplayer.registerVideocontroller(getVideocontroller());
	}

	public function getVideoplayer():VideoplayerUI
	{
		return this.videoplayer;
	}

	public function setVideocontroller(videocontroller:VideocontrollerUI ):Void
	{
		// videocontroller-komponente
		this.videocontroller = videocontroller;
		// bei videoplayer-komponente bekannt machen
		if (getVideoplayer() != null) getVideoplayer().registerVideocontroller(videocontroller);
	}

	public function getVideocontroller():VideocontrollerUI
	{
		return this.videocontroller;
	}

	public function setItems(items:Array):Void
	{
		this.items = items;
	}

	public function getItems():Array
	{
		return this.items;
	}

	public function setPointer(pointer:Number):Void
	{
		this.pointer = pointer;
	}

	public function getPointer():Number
	{
		return this.pointer;
	}

	private function VideoController()
	{
		this._event = new EventBroadcaster();
		// liste der items, die abgespielt werden sollen
		this.items = new Array();
		// zeiger auf aktuelles item
		this.pointer = -1;
		// videoplayer-komponente
		this.videoplayer = null;
		// videocontroller-komponente
		this.videocontroller = null;
	}
}