import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.WallpaperUI extends MovieClip implements IPresentationControllerListener {

	private var wallpaper_mc:MovieClip;

	public function WallpaperUI() {

	}

	public function onLoad():Void
	{
		// beim presentationcontroller als listener registrieren
		PresentationController.getInstance().addListener(this);
		// platzhalter fuer wallpaper (wird nachgeladen)
		wallpaper_mc = this.createEmptyMovieClip("wallpaper_mc", getNextHighestDepth());
		// ausblenden
		_visible = false;
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		PresentationController.getInstance().removeListener(this);
	}

	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
		// je nach neuem state
		switch (newstate) {
			// menu aufbau
			case PresentationState.STATE_MENUCREATE :
				// wallpaper laden und anzeigen
				loadWallpaper(data.getWallpaper());

				break;
			// playlist
			case PresentationState.STATE_PLAYLIST :

				break;
			// warteloop, trailer, trailerloop
			case PresentationState.STATE_WAITING :
			case PresentationState.STATE_TRAILER :
			case PresentationState.STATE_TRAILERLOOP :
				// ausblenden
				_visible = false;

				break;
		}
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
	}

	public function onToggleFullscreen(bool:Boolean ):Void
	{
		// abbrechen, wenn nicht sichtbar
		if (_visible == false) return;
		// wallpaper positionieren und skalieren
		setPositionAndSize();
	}

	/**
	 * callback nach laden des wallpapers
	 */
	public function onLoadComplete(target_mc:MovieClip, status:Number ):Void
	{
		// wallpaper positionieren
		setPosition();
		// einblenden
		_visible = true;
	}

	/**
	 * wallpaper laden
	 */
	private function loadWallpaper(wallpaper:String ):Void
	{
		// platzhalter zum nachladen
		var dummy_mc:MovieClip = wallpaper_mc.createEmptyMovieClip("dummy_mc", 1);
		// loader
		var mcl:MovieClipLoader = new MovieClipLoader();
		// als listener registrieren
		mcl.addListener(this);
		// laden
		mcl.loadClip(wallpaper, dummy_mc);
	}

	/**
	 * wallpaper an position des videoplayers anpassen
	 */
	private function setPosition():Void
	{
		// position des players
		var position:Point = VideoController.getInstance().getVideoplayer().getPlayerPosition();
		// positionieren
		wallpaper_mc._x = position.x;
		wallpaper_mc._y = position.y;
	}

	/**
	 * wallpaper an position und groesse des videoplayers anpassen
	 */
	private function setPositionAndSize():Void
	{
		// umriss des players
		var bounds:Rectangle = VideoController.getInstance().getVideoplayer().getPlayerBounds();
		// positionieren
		wallpaper_mc._x = bounds.x;
		wallpaper_mc._y = bounds.y;
		// skalieren
		wallpaper_mc._width = bounds.width;
		wallpaper_mc._height = bounds.height;
	}

}