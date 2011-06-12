import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistChapterItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Playlist;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;

/**
 * @author Harry
 *
 * Kapselt alle daten die innerhalb einer
 * Presentations Linie benötigt werden
 *
 */
class com.adgamewonderland.ea.nextlevel.model.beans.Presentation {
	private var metainfo	:Metainfo;
	private var warteLoop	:PlaylistVideoItem;
	private var trailer		:PlaylistVideoItem;
	private var trailerLoop	:PlaylistVideoItem;
	private var uebergang	:PlaylistVideoItem;

	private var wallpaper:String;

	private var menue		:Array;
	private var videos		:Array;		// Array aus Beans der Klasse PlaylistVideoItem
	private var chapters	:Array;		// Array aus Beans dieser Klasse

	/**
	 * Konstruktor
	 */
	public function Presentation() {
		menue 		= null;
		videos 		= null;
		chapters 	= null;
		metainfo 	= null;
		warteLoop 	= null;
		trailer		= null;
		trailerLoop = null;
		uebergang	= null;
	}

	/**
	 * Getter und Setterpaare
	 */
	public function toMenueArray ():Array {
		return menue;
	}
	public function toChapterArray ():Array {
		return chapters;
	}
	public function toVideoArray ():Array {
		return videos;
	}

	/**
	 * Getter um bestimmte Einträge zu laden
	 * aus Videos oder Chapters
	 *
	 */
	public function getChapterFromIndex (index:Number):PresentationImpl {
		if (chapters == null)
			return null;
		if (index < chapters.length && index >= 0) {
			return chapters[index];
		}
		return null;
	}
	public function getVideoFromIndex (index:Number):PlaylistVideoItem {
		if (videos == null)
			return null;
		if (index < videos.length && index >= 0) {
			return videos[index];
		}
		return null;
	}
	/**
	 *
	 */

	public function setMetainfo (value:Metainfo):Void {
		metainfo = value;
	}
	public function getMetainfo ():Metainfo {
		return metainfo;
	}
	public function setWarteLoop (value:PlaylistVideoItem):Void {
		warteLoop = value;
	}
	public function getWarteLoop ():PlaylistVideoItem {
		return warteLoop;
	}
	public function setTrailer (value:PlaylistVideoItem):Void {
		trailer = value;
	}
	public function getTrailer ():PlaylistVideoItem {
		return trailer;
	}
	public function setTrailerLoop (value:PlaylistVideoItem):Void {
		trailerLoop = value;
	}
	public function getTrailerLoop ():PlaylistVideoItem {
		return trailerLoop;
	}
	public function setUebergang (value:PlaylistVideoItem):Void {
		uebergang = value;
	}
	public function getUebergang ():PlaylistVideoItem {
		return uebergang;
	}
	public function setWallpaper(wallpaper:String):Void {
		this.wallpaper = wallpaper;
	}
	public function getWallpaper():String {
		return this.wallpaper;
	}
}