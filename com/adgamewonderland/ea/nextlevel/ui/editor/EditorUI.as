import com.adgamewonderland.ea.nextlevel.controllers.DragController;
import com.adgamewonderland.ea.nextlevel.ui.editor.EditorVideocontrollerUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.EditorVideoplayerUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.MenuUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.PlaylistUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.RepositoryUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.EditorMetainfoUI;

class com.adgamewonderland.ea.nextlevel.ui.editor.EditorUI extends MovieClip
{
	private var metainfo_mc:EditorMetainfoUI;

	private var menu_mc:MenuUI;

	private var repository_mc:RepositoryUI;

	private var videoplayer_mc:EditorVideoplayerUI;

	private var videocontroller_mc:EditorVideocontrollerUI;

	private var playlist_mc:PlaylistUI;

	public function EditorUI()
	{
	}

	public function onLoad():Void
	{
		// als container fuer draggen registrieren
		DragController.getInstance().setContainer(this);
	}
}