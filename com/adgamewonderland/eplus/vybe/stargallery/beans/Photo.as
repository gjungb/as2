import com.adgamewonderland.eplus.vybe.stargallery.beans.Artist;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.stargallery.beans.Photo {

	public static var SEPARATOR:String = "/";

	private static var BASEPATH:String = "gallery";

	private var artist:Artist;

	private var path:String;

	private var filename:String;

	private var thumbnail:String;

	private var photographer:String;

	public function Photo(aArtist:Artist, aPath:String, aFilename:String, aThumbnail:String, aPhotographer:String ) {
		this.artist			= aArtist;
		this.path			= aPath;
		this.filename 		= aFilename;
		this.thumbnail 		= aThumbnail;
		this.photographer 	= aPhotographer;
	}

	public function getFilenameUrl():String
	{
		return BASEPATH + SEPARATOR + getPath() + SEPARATOR + getFilename();
	}

	public function getThumbnailUrl():String
	{
		return BASEPATH + SEPARATOR + getPath() + SEPARATOR + getThumbnail();
	}

	public function getArtist():Artist
	{
		return this.artist;
	}

	public function getPath():String
	{
		return this.path;
	}

	public function getFilename():String
	{
		return this.filename;
	}

	public function getThumbnail():String
	{
		return this.thumbnail;
	}

	public function getPhotographer():String
	{
		return this.photographer;
	}

	public function toString():String {
		return "com.adgamewonderland.eplus.vybe.stargallery.beans.Photo: " + getFilenameUrl();
	}

	public function equals(photo:Photo ):Boolean
	{
		// identisch, wenn pfade uebereinstimmen
		return getFilenameUrl() == photo.getFilenameUrl();
	}

}