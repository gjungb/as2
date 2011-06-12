import com.adgamewonderland.ea.nextlevel.ui.player.VideocontrollerUI;
import com.adgamewonderland.ea.nextlevel.interfaces.IMenuControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.controllers.MenuController;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.editor.EditorVideocontrollerUI extends VideocontrollerUI implements IMenuControllerListener {

	public var seek_mc:MovieClip;

	public var mute_mc:MovieClip;

	public var volume_mc:MovieClip;

	public function EditorVideocontrollerUI() {
		super();
		// als listener fuer menu registrieren
		MenuController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		MenuController.getInstance().removeListener(this);
	}

	public function onPlaylistCreated() : Void {
	}

	public function onPlaylistOpened() : Void {
	}

	public function onPlaylistSaved() : Void {
	}

	public function onPlaylistSavedAs() : Void {
	}

	public function onMetainfoEdit(metainfo : Metainfo, allowcancel : Boolean) : Void {
		// als key listener deregistrieren
		Key.removeListener(this);
	}

	public function onMetainfoClosed() : Void {
		// als key listener registrieren
		Key.addListener(this);
	}

	public function onPresentationCompleteOpened() : Void {
	}

	public function onPresentationIndividualOpened() : Void {
	}

	public function onFireMenue() : Void {
	}

}