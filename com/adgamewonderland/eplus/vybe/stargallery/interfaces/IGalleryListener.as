import com.adgamewonderland.eplus.vybe.stargallery.beans.Artist;
import com.adgamewonderland.eplus.vybe.stargallery.beans.Photo;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.vybe.stargallery.interfaces.IGalleryListener {

	public function onArtistSelected(artist:Artist ):Void;

	public function onPhotoSelected(photo:Photo ):Void;

}