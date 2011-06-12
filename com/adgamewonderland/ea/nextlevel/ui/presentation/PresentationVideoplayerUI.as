import com.adgamewonderland.ea.nextlevel.ui.player.VideoplayerUI;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationVideoplayerUI extends VideoplayerUI implements IPresentationControllerListener {

	private var wallpaper_mc:MovieClip;

	public function PresentationVideoplayerUI() {
		super();
	}

	public function onLoad():Void
	{
		super.onLoad();
		// beim presentationcontroller als listener registrieren
		PresentationController.getInstance().addListener(this);
	}

	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
	}

	/**
	 * callback nach umschalten des fullscreen modus
	 */
	public function onToggleFullscreen(bool:Boolean):Void
	{
		// fullscreen ein- / ausschalten
		showFullscreen(bool);
	}

	/**
	 * fullscreen modus ein- / ausschalten
	 * @param bool fullscreen ja / nein
	 */
	private function showFullscreen(bool:Boolean):Void
	{
		// ein- / ausschalten
		if (bool) {
			// skalieren (gesamte breite der buehne, skalierte hoehe)
			setSize(Stage.width, Stage.width / _playerwidth * _playerheight);
			// positionieren (abstand oben und unten)
			this.player._x = 0;
			this.player._y = (Stage.height - this.player.height) / 2;

		} else {
			// positionieren
			this.player._x = _playerx;
			this.player._y = _playery;
			// skalieren
			setSize(_playerwidth, _playerheight);
		}
		// wallpaper positionieren
		wallpaper_mc._x = this.player.x;
		wallpaper_mc._y = this.player.y;
		// wallpaper skalieren
		wallpaper_mc._width = this.player.width;
		wallpaper_mc._height = this.player.height;
	}

}