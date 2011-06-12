import mx.utils.Collection;
import mx.utils.CollectionImpl;

import com.adgamewonderland.eplus.vybe.stargallery.beans.Photo;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.stargallery.beans.Artist {

	private var name:String;

	private var photos:Collection;

	private var photomap:Object;

	public function Artist(aName:String ) {
		this.name = aName;
		this.photos = new CollectionImpl();
		this.photomap = new Object();
	}

	public function addPhoto(aPhoto:Photo ):Void
	{
		// photo hinzufuegen
		this.photos.addItem(aPhoto);
		// mapping zwischen name des artist und seinem index in der collection
		this.photomap[aPhoto.getFilename()] = this.photos.getLength() - 1;
	}

	public function getName():String
	{
		return this.name;
	}

	public function getPhotos():Collection
	{
		return this.photos;
	}

	public function getPhotoCount():Number
	{
		return this.photos.getLength();
	}

	public function getNextPhoto(aPhoto:Photo):Photo
	{
		return getAdjacentPhoto(aPhoto, 1);
	}

	public function getPreviousPhoto(aPhoto:Photo):Photo
	{
		return getAdjacentPhoto(aPhoto, -1);
	}

	public function toString():String {
		return "com.adgamewonderland.eplus.vybe.stargallery.beans.Artist: " + getName() + " (" + getPhotoCount() + ")";
	}

	private function getAdjacentPhoto(aPhoto:Photo, aDirection:Number ):Photo
	{
		// in der uebergebenen richtung folgendes photo
		var photo:Photo;
		// index des gewuenschten photos
		var index:Number = getPhotoIndex(aPhoto) + aDirection;
		// grenzen pruefen
		if (index < 0) {
			index = this.photos.getLength() - 1;
		}
		if (index > this.photos.getLength() - 1) {
			index = 0;
		}
		//  und photo auswaehlen
		photo = Photo(this.photos.getItemAt(index));
		// zurueck geben
		return photo;
	}

	private function getPhotoIndex(aPhoto:Photo ):Number
	{
		// index
		var index:Number = this.photomap[aPhoto.getFilename()];
		// zurueck geben
		return index;
	}

}