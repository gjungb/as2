import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistVideoItemImpl;
import com.adgamewonderland.ea.nextlevel.controllers.RepositoryController;

class com.adgamewonderland.ea.nextlevel.controllers.PlaylistController implements IEventBroadcaster
{
	private static var _instance:PlaylistController;

	private var _event:EventBroadcaster;

	private var playlist:PlaylistImpl;
	private var strPfadPlaylist:String;
	private var dirty:Boolean;

	/**
	 * Getter für geladene Playlist (Pfad)
	 */
	public function getPfadPlaylist() : String {
		return this.strPfadPlaylist;
	}
	/**
	 * Setter für geladene Playlist (Pfad)
	 */
	public function setPfadPlaylist(value:String) : Void {
		this.strPfadPlaylist = value;
	}

	public function getDirty() : Boolean {
		return this.dirty;
	}
	public function setDirty(value:Boolean) : Void {
		this.dirty = value;
	}

	/**
	 * fuegt ein video zur playlist hinzu
	 * @param video video, das hinzugefuegt werden soll
	 * @param index index, den das video innerhalb der playlist haben soll
	 */
	public function addVideo(video:Video, index:Number ):Void
	{
		// neues item
		var item:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
		// referenz auf video
		item.setVideo(video);
		// TODO: stopmark setzen
		if (item.getVideo().isActive() == true) {
			item.setStopmarks(String(item.getVideo().getDuration() - 1));
		}
		// in playlist einfuegen
		getPlaylist().addItem(item, index);
		// playlist wurde geaendert
		dirty = true;
		// listener informieren
		_event.send("onPlaylistitemAdded"	, item);
		_event.send("onPlaylistChanged"		, getPlaylist());
	}

	/**
	 * loescht ein item aus der playlist
	 * @param item das zu loeschende item
	 */
	public function removeItem(item:PlaylistItem):Void
	{
		// aus playlist loeschen
		getPlaylist().removeItem(item);
		// anzahl der items
		var itemcount:Number = getPlaylist().getItemcount(item);
		// playlist wurde geaendert
		dirty = true;
		// listener informieren
		_event.send("onPlaylistitemRemoved", item, itemcount);
		_event.send("onPlaylistChanged", getPlaylist());
	}

	/**
	 * lässt genau ein video abspielen
	 * @param video das abzuspielende video
	 */
	public function startVideo(video:Video ):Void
	{
		// video in playlistitem wrappen
		var item:PlaylistVideoItem = new PlaylistVideoItem();
		// video setzen
		item.setVideo(video);
		// als array mit einem element an videocontroller uebergeben
		VideoController.getInstance().playItems(new Array(item), 0);
	}

	/**
	 * lässt mehrere videos in der reihenfolge der items in der aktuellen playlist abspielen
	 * @param item item in der playlist, bei dem das abspielen beginnen soll
	 */
	public function startPlaylist(item:PlaylistItem, pause:Number ):Void
	{
		// alle items der playlist
		var items:Array = getPlaylist().toItemsArray();
		// position des items, bei dem das abspielen beginnen soll (0-basiert)
		var startat:Number = item.getID() - 1;
		// pause des ersten items setzen
		PlaylistItem(items[0]).setPause(pause);
		// an videocontroller uebergeben
		VideoController.getInstance().playItems(items, startat);
	}

	/**
	 * loescht alle items aus der aktuellen playlist und legt eine neue, leere playlist an
	 */
	public function resetPlaylist():Void
	{
		// alle items in playlist loeschen
		for (var i:String in getPlaylist().toItemsArray()) {
			removeItem(getPlaylist().toItemsArray()[i]);
		}
		// neue playlist
		setPlaylist(new PlaylistImpl());
		// leerer pfad
		setPfadPlaylist("");
		// playlist wurde nicht geaendert
		dirty = false;
	}

	/**
	 * aendert die metainfo der aktuellen playlist
	 * @param title neuer title
	 * @param subtitle neuer subtitle
	 * @param city neue city
	 * @param presenter neuer presenter
	 * @param presentationdate neues presentationdate
	 * @param description neue description
	 */
	public function updateMetainfo(title:String, subtitle:String, city:String, presenter:String, presentationdate:String, description:String ):Void
	{
		// neue werte speichern
		getPlaylist().getMetainfo().setTitle(title);
		getPlaylist().getMetainfo().setSubtitle(subtitle);
		getPlaylist().getMetainfo().setCity(city);
		getPlaylist().getMetainfo().setPresenter(presenter);
		getPlaylist().getMetainfo().setPresentationdate(presentationdate);
		getPlaylist().getMetainfo().setDescription(description);
		// playlist wurde geaendert
		dirty = true;
		// listener informieren
		_event.send("onPlaylistChanged", getPlaylist());
	}

	/**
	 * Speichert die aktuelle Playlist unter dem bekannten namen
	 */
	public function savePlaylist() : Void {
		if (strPfadPlaylist == "")
			return;

		var node:XMLNode = playlist.SerializeXML();
		if (node == null)
			return;

		var header:String = "";		// '<?xml version="1.0"?>' + String.fromCharCode(13) + String.fromCharCode(10);
		var content = header + node.toString();

		ssCore.FileSys.writeToFile(
			{
				path:strPfadPlaylist,
				data:content
			}
		);
		dirty = false;
	}

	/**
	 * Laden einer Playlist aus einer XML datei
	 */
	public function loadPlaylist(datei:String) : Void {

		var file_obj = ssCore.FileSys.readFile (
			{path:datei}
		);
		if (file_obj.success) {
			var content:String = file_obj.result;

			var xml:XML = new XML();
			xml.parseXML(content);

			var node:XMLNode 		= xml.firstChild;
			var temp:PlaylistImpl 	= new PlaylistImpl();

			temp.DeserializeXML(node);

			this.setPfadPlaylist(datei);
			setPlaylist(temp);

			dirty = false;
		}
	}

	public function setPlaylist(playlist:PlaylistImpl):Void
	{
		this.playlist = playlist;
		// listener informieren
		_event.send("onPlaylistChanged", getPlaylist());
	}

	public function getPlaylist():PlaylistImpl
	{
		return this.playlist;
	}

	public static function getInstance():PlaylistController
	{
		if (_instance == null)
			_instance = new PlaylistController();
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

	private function PlaylistController()
	{
		this._event = new EventBroadcaster();

		// playlist
		this.playlist 			= new PlaylistImpl();
		this.strPfadPlaylist 	= "";
		// playlist wurde nicht geaendert
		this.dirty = false;
	}
}