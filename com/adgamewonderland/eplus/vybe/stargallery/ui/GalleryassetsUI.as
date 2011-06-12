import mx.utils.Delegate;

import com.adgamewonderland.eplus.vybe.stargallery.beans.Artist;
import com.adgamewonderland.eplus.vybe.stargallery.beans.Photo;
import com.adgamewonderland.eplus.vybe.stargallery.controllers.GalleryController;
import com.adgamewonderland.eplus.vybe.stargallery.interfaces.IGalleryListener;
import com.adgamewonderland.eplus.vybe.stargallery.ui.ArtistsUI;
import com.adgamewonderland.eplus.vybe.stargallery.ui.PhotosUI;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.stargallery.ui.GalleryassetsUI extends MovieClip implements IGalleryListener {

	private var artists_mc:ArtistsUI;

	private var photos_mc:PhotosUI;

	private var photos_on_mc:MovieClip;

	private var photos_off_mc:MovieClip;

	private var artists_on_mc:MovieClip;

	private var artists_off_mc:MovieClip;

	public function GalleryassetsUI() {
		// button zum wechsel zur kuenstlerauswahl
		artists_off_mc.onRelease = Delegate.create(this, doSwitch);
	}

	public function onLoad():Void
	{
		// beim gallerycontroller als listener registrieren
		GalleryController.getInstance().addListener(this);
		// zur kuenstlerauswahl
		doSwitch();
	}

	public function onUnload():Void
	{
		// beim gallerycontroller als listener deregistrieren
		GalleryController.getInstance().removeListener(this);
	}

	public function doSwitch():Void
	{
		// thumbnails ausblenden
		photos_mc.hidePhotos();
		// kategorien einblenden
		artists_mc.showArtists(GalleryController.getInstance().getArtists());

		// reiter umblenden
		photos_on_mc._visible = artists_off_mc._visible = false;
		photos_off_mc._visible = artists_on_mc._visible = true;
		// wechsel nicht moeglich
		artists_off_mc.enabled = false;
	}

	public function onArtistSelected(artist:Artist ):Void
	{
		// kuenstler ausblenden
		artists_mc.hideArtists();
		// thumbnails einblenden
		photos_mc.showPhotos(artist);

		// reiter umblenden
		photos_on_mc._visible = artists_off_mc._visible = true;
		photos_off_mc._visible = artists_on_mc._visible = false;
		// wechsel moeglich
		artists_off_mc.enabled = true;
	}

	public function onPhotoSelected(photo:Photo ):Void
	{
	}

}