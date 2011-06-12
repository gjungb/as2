import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.DefaultController;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.VideocontrollerUI;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.StreamplayerUI;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import mx.utils.Collection;
import mx.utils.CollectionImpl;

class com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoController extends DefaultController implements IEventBroadcaster
{
	private static var _instance:VideoController;

	private var items:Collection;

	private var pointer:Number;

	private var videoplayer:StreamplayerUI;

	private var videocontroller:VideocontrollerUI;

	/**
	 * ein einzelnes item abspielen
	 * @param item das abzuspielende item
	 */
	public function playSingleItem(item:AssetImpl ):Void
	{
		// in collection wrappen
		var items:Collection = new CollectionImpl();
		// als einziges item
		items.addItem(item);
		// abspielen
		playItems(items, 0);
	}

	/**
	 * die uebergebenen items in ihrer reihenfolge abspielen
	 * @param items array mit AssetImpl
	 * @param startat position des items, das als erstes abgespielt werden soll
	 */
	public function playItems(items:Collection, startat:Number ):Void
	{
		// aktuelles video stoppen
		stopVideo();
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
		if (this.pointer == getItems().getLength() - 1) {
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
		if (startat < 0 || startat >= this.items.getLength()) return;
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
			getVideoplayer().stopVideo();
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
			getVideoplayer().stopVideo();
			// zurueck spulen
			getVideoplayer().seekPercent(0);
			// ausblenden
			getVideoplayer()._visible = false;
		}
	}

	/**
	 * ermittelt das aktuell abzuspielende item
	 * @return gibt das aktuell abzuspielende item zurueck
	 */
	public function getCurrentItem():AssetImpl
	{
		// aktuelles item
		var item:AssetImpl = AssetImpl(getItems().getItemAt(getPointer()));
		// zurueck geben
		return item;
	}

	public static function getInstance():VideoController
	{
		if (_instance == null)
			_instance = new VideoController();
		return _instance;
	}

	public function setVideoplayer(videoplayer:StreamplayerUI ):Void
	{
		// videoplayer-komponente
		this.videoplayer = videoplayer;
		// mit videocontroller-komponente bekannt machen
		if (getVideocontroller() != null) videoplayer.registerVideocontroller(getVideocontroller());
	}

	public function getVideoplayer():StreamplayerUI
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

	public function setItems(items:Collection ):Void
	{
		this.items = items;
	}

	public function getItems():Collection
	{
		return this.items;
	}

	public function setPointer(pointer:Number ):Void
	{
		this.pointer = pointer;
	}

	public function getPointer():Number
	{
		return this.pointer;
	}

	private function VideoController()
	{
		super();
		// liste der items, die abgespielt werden sollen
		this.items = new CollectionImpl();
		// zeiger auf aktuelles item
		this.pointer = -1;
		// videoplayer-komponente
		this.videoplayer = null;
		// videocontroller-komponente
		this.videocontroller = null;
	}
}