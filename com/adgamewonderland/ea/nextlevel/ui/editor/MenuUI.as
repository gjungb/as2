import mx.utils.Delegate;

import com.adgamewonderland.ea.nextlevel.controllers.MenuController;
import com.adgamewonderland.ea.nextlevel.interfaces.IMenuControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.controllers.PlaylistController;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;

class com.adgamewonderland.ea.nextlevel.ui.editor.MenuUI extends MovieClip implements IMenuControllerListener
{
	private var new_btn:Button;

	private var open_btn:Button;

	private var save_btn:Button;

	private var saveas_btn:Button;

	private var metainfo_btn:Button;

	private var close_btn:Button;

	public function MenuUI() {

	}

	public function onLoad():Void
	{
		// als listener fuer menu registrieren
		MenuController.getInstance().addListener(this);
		// new
		new_btn.onRelease = Delegate.create(this, doCreate);
		// open
		open_btn.onRelease = Delegate.create(this, doOpen);
		// save
		save_btn.onRelease = Delegate.create(this, doSave);
		// saveas
		saveas_btn.onRelease = Delegate.create(this, doSaveas);
		// metainfo
		metainfo_btn.onRelease = Delegate.create(this, doMetainfo);
		// close
		close_btn.onRelease = Delegate.create(this, doClose);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		MenuController.getInstance().removeListener(this);
	}

	public function doCreate():Void
	{
		// neue playlist anlegen
		MenuController.getInstance().createPlaylist();
	}

	public function doOpen():Void
	{
		// playlist oeffen
		MenuController.getInstance().openPlaylist();
	}

	public function doSave():Void
	{
		// playlist speichern
		MenuController.getInstance().savePlaylist();
	}

	public function doSaveas():Void
	{
		// playlist unter neuem namen speichern
		MenuController.getInstance().savePlaylistAs();
	}

	public function doMetainfo():Void
	{
		// metainfo anzeigen / editieren
		MenuController.getInstance().openMetainfoEditor(true);
	}

	public function doClose():Void
	{
		// editor beenden
		MenuController.getInstance().closeEditor();
	}

	public function onPlaylistCreated() : Void {
	}

	public function onPlaylistOpened() : Void {
	}

	public function onPlaylistSaved() : Void {
	}

	public function onPlaylistSavedAs() : Void {
	}

	public function onMetainfoEdit(metainfo:Metainfo, allowcancel:Boolean) : Void {
	}

	public function onMetainfoClosed() : Void {
	}

	public function onPresentationCompleteOpened() : Void {
	}

	public function onPresentationIndividualOpened() : Void {
	}

	public function onFireMenue() : Void {
		VideoController.getInstance().hideVideo();
	}

}