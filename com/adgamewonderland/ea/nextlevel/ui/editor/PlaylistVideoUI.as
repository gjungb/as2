import com.adgamewonderland.ea.nextlevel.controllers.PlaylistController;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.interfaces.IDraggable;
import com.adgamewonderland.ea.nextlevel.interfaces.IVideoControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.ui.editor.VideoUI;
import mx.utils.Delegate;
import com.adgamewonderland.ea.nextlevel.ui.player.VideoplayerUI;

class com.adgamewonderland.ea.nextlevel.ui.editor.PlaylistVideoUI extends VideoUI implements IVideoControllerListener
{

	public static var WIDTH:Number = 100;

	private var _item:PlaylistItem;

	private var identifier:String = "PlaylistVideoUI";

	private var item:PlaylistItem;

	private var progress_mc:MovieClip;

	public function PlaylistVideoUI()
	{
		super();
		// item
		this.item = _item;
		// als listener fuer videoplayer registrieren
		VideoController.getInstance().addListener(this);
		// fortschrittsbalken ausblenden
		hideProgress();
	}

	public function onUnload():Void
	{
		// deaktivieren
		followProgress(false);

		super.onUnload();
	}

	public function setBorder(type:Number):Void
	{
		// umrandung anzeigen
		border_mc.gotoAndStop(type);
	}

	public function onStartDrag(sibling:IDraggable):Void
	{
		super.onStartDrag(sibling);
		// aus playlist loeschen
		PlaylistController.getInstance().removeItem(getItem());
	}

	public function onItemSelected(item:PlaylistVideoItem ):Void
	{
		// wurde item dieser ui ausgewaehlt
		var selected:Boolean = item.getID() == getItem().getID();
		// umrandung entsprechend anzeigen
		this.setBorder(selected ? BORDER_SELECTED : BORDER_NORMAL);
		// fortschrittsanzeige umschalten
		if (selected) {
			// aktivieren
			followProgress(true);
		} else {
			// deaktivieren
			followProgress(false);
		}
	}

	public function onItemsPlayed(items : Array) : Void {
	}

	public function onStateChanged(event:Object ):Void
	{
		// target
		var target:VideoplayerUI = VideoplayerUI(event.target);
		// state
		var state:String = event.state;
		// time
		var time:Number = event.playheadTime;

		ssDebug.trace("onStateChanged: " + state);

		// state verarbeiten
		switch (state) {
			case VideoplayerUI.STOPPED :
				// deaktivieren (01.08.2007: bringt alles durcheinder)
//				followProgress(false);

			break;

			default :
		}
	}

	public function setItem(item:PlaylistItem):Void
	{
		this.item = item;
	}

	public function getItem():PlaylistItem
	{
		return this.item;
	}

	/**
	 * abspielen eines videos beginnen
	 */
	private function doPlay():Void
	{
		// playlist ab diesem item abspielen lassen
		PlaylistController.getInstance().startPlaylist(getItem());
	}

	/**
	 * fortschrittsverfolung de- / aktivieren
	 * @param startstop
	 */
	private function followProgress(startstop:Boolean ):Void
	{
		// aktivieren
		if (startstop) {
			// beim videoplayer als listener registrieren
			VideoController.getInstance().getVideoplayer().addEventListener("stateChange", Delegate.create(this, onStateChanged));
			// fortschritt verfolgen
			onEnterFrame = showProgress;

		// deaktivieren
		} else {
			// beim videoplayer als listener abmelden
			VideoController.getInstance().getVideoplayer().removeEventListener(this);
			// fortschrittsbalken ausblenden
			hideProgress();
			// fortschritt verfolgen beenden
			delete(onEnterFrame);
		}
	}

	/**
	 * fortschrittsbalken ausblenden
	 */
	private function hideProgress():Void
	{
		// ausblenden
		progress_mc._visible = false;
	}

	/**
	 * fortschrittsbalken anzeigen
	 */
	private function showProgress():Void
	{
		// einblenden
		progress_mc._visible = true;
		// vor das thumbnail
		progress_mc.swapDepths(thumbnail_mc.getDepth() + 1);
		// prozentualer fortschritt des aktuellen items
		var progress:Number = Math.min(100, VideoController.getInstance().getVideoplayer().playheadPercentage);
		// abbrechen, wenn kein vernuenftiger wert
		if (progress == undefined || isNaN(progress)) return;
		// anzeigen
		progress_mc._x = Math.round(progress / 100 * border_mc._width);
	}

}