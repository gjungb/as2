import com.adgamewonderland.eplus.vybe.stargallery.beans.Photo;
import com.adgamewonderland.eplus.vybe.stargallery.controllers.GalleryController;
import com.adgamewonderland.eplus.vybe.stargallery.interfaces.IGalleryListener;
import com.adgamewonderland.eplus.vybe.stargallery.beans.Artist;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.stargallery.ui.ThumbnailUI extends MovieClip implements IGalleryListener {

	public static var BORDER_NORMAL:Number = 1;

	public static var BORDER_SELECTED:Number = 2;

	private static var THUMBX:Number = 0;

	private static var THUMBY:Number = 0;

	private static var THUMBSCALE:Number = 100;

	private var _photo:Photo;

	private var photo:Photo;

	private var thumbnail_mc:MovieClip;

	private var border_mc:MovieClip;

	function ThumbnailUI() {
		// photo
		this.photo = _photo;
		// als listener registrieren
		GalleryController.getInstance().addListener(this);
	}

	public function onLoad():Void
	{
		// thumbnail laden
		loadThumbnail(getPhoto().getThumbnailUrl());
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		GalleryController.getInstance().removeListener(this);
	}

	public function onRelease():Void
	{
		// photo auswaehlen
		GalleryController.getInstance().selectPhoto(getPhoto());
	}

	public function getPhoto():Photo
	{
		return this.photo;
	}

	public function setBorder(type:Number):Void
	{
		// umrandung anzeigen
		border_mc.gotoAndStop(type);
	}

	/**
	 * callback nach laden des thumbnails
	 */
	public function onLoadComplete(target_mc:MovieClip, status:Number ):Void
	{
		// thumbnail skalieren
		thumbnail_mc._xscale = thumbnail_mc._yscale = THUMBSCALE;
		// einblenden
		thumbnail_mc._visible = true;
	}

	/**
	 * thumbnail laden
	 */
	private function loadThumbnail(thumbnail:String ):Void
	{
		// thumbnail
		thumbnail_mc = this.createEmptyMovieClip("thumbnail_mc", getNextHighestDepth());
		// positionieren
		thumbnail_mc._x = THUMBX;
		thumbnail_mc._y = THUMBY;
		// ausblenden
		thumbnail_mc._visible = false;
		// platzhalter zum nachladen
		var dummy_mc:MovieClip = thumbnail_mc.createEmptyMovieClip("dummy_mc", 1);
		// loader
		var mcl:MovieClipLoader = new MovieClipLoader();
		// als listener registrieren
		mcl.addListener(this);
		// laden
		mcl.loadClip(thumbnail, dummy_mc);
	}

	public function onArtistSelected(artist:Artist ):Void
	{
	}

	public function onPhotoSelected(photo:Photo ):Void
	{
		// testen, ob dieses item ausgewaehlt
		if (getPhoto().equals(photo)) {
			// umrandung einblenden
			setBorder(BORDER_SELECTED);

		} else {
			// umrandung ausblenden
			setBorder(BORDER_NORMAL);
		}
	}

}