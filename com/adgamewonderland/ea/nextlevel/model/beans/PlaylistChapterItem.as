import com.adgamewonderland.ea.nextlevel.model.beans.Chapter;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.Repository;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;

class com.adgamewonderland.ea.nextlevel.model.beans.PlaylistChapterItem extends PlaylistItem
{
	private var chapter:Chapter;

	public function PlaylistChapterItem()
	{
		super();
		chapter = null;
	}

	/**
	 * Es wird nur einen Setter geben
	 *
	 * alle Funktionen des Chapters die relevant sind werden
	 * überschrieben.
	 */
	public function setChapter(value:Chapter) : Void {
		this.chapter = value;
	}

	public function getMetainfo():Metainfo {
		return this.chapter.getMetainfo();
	}

	public function getTrailer():PlaylistVideoItem
	{
		return this.chapter.getTrailer();
	}

	public function getTrailerLoop():PlaylistVideoItem
	{
		return this.chapter.getTrailerLoop();
	}

	public function getUebergang():PlaylistVideoItem
	{
		return this.chapter.getUebergang();
	}

	public function toVideosArray():Array
	{
		return this.chapter.toVideosArray();
	}

	public function getAuthor():String
	{
		return this.chapter.getAuthor();
	}

	public function isActive():Boolean
	{
		return this.chapter.isActive();
	}

	public function getWallpaper():String
	{
		return this.chapter.getPfadWallpaper() + this.chapter.getWallpaper();
	}
}