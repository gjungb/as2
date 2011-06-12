import mx.utils.Collection;
import mx.utils.CollectionImpl;

import com.adgamewonderland.eplus.vybe.stargallery.beans.Artist;
import com.adgamewonderland.eplus.vybe.stargallery.beans.Photo;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.stargallery.beans.Gallery {

	private var artists:Collection;

	private var artistmap:Object;

	public function Gallery() {
		this.artists = new CollectionImpl();
		this.artistmap = new Object();
	}

	public function addArtist(aArtist:Artist ):Void
	{
		// artist hinzufuegen
		this.artists.addItem(aArtist);
		// mapping zwischen name des artist und seinem index in der collection
		this.artistmap[aArtist.getName()] = this.artists.getLength() - 1;
	}

	public function getArtistByName(aName:String ):Artist
	{
		// index
		var index:Number = this.artistmap[aName];
		// artist
		var artist:Artist = Artist(this.artists.getItemAt(index));
		// zurueck geben
		return artist;
	}

	public function getRandomPhoto():Photo
	{
		// zufaelliger kuenstler
		var artist:Artist = Artist(getArtists().getItemAt(Math.floor(Math.random() * getArtists().getLength())));
		// zufaelliges photo
		var photo:Photo = Photo(artist.getPhotos().getItemAt(Math.floor(Math.random() * artist.getPhotoCount())));
		// zurueck geben
		return photo;
	}

	public function getArtists():Collection
	{
		return this.artists;
	}

}