import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.Repository;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;

class com.adgamewonderland.ea.nextlevel.model.beans.Chapter
{
	private var ID:Number;
	private var author:String;
	private var active:Boolean = true;
	private var repository:Repository;
	private var chapters:Array = new Array();
	private var videos:Array = new Array();
	private var metainfo:Metainfo;

	private var trailer		:PlaylistVideoItem;
	private var trailerLoop	:PlaylistVideoItem;
	private var uebergang	:PlaylistVideoItem;

	private var wallpaper:String;
	private var pfadWallpaper:String;	// siehe oben

	public function Chapter()
	{
		this.ID = 1;
		this.author = "author";
		this.repository = null;
		this.chapters 	= new Array();
		this.videos 	= new Array();
		this.metainfo 	= null;

		this.trailer 		= null;
		this.trailerLoop 	= null;
		this.uebergang 		= null;

		this.wallpaper = "";
		this.pfadWallpaper = "";
	}

	public function setPfadWallpaper(pfadWallpaper:String):Void
	{
		this.pfadWallpaper = pfadWallpaper;
	}

	public function getPfadWallpaper():String
	{
		return this.pfadWallpaper;
	}
	public function setWallpaper(wallpaper:String):Void
	{
		this.wallpaper = wallpaper;
	}

	public function getWallpaper():String
	{
		return this.wallpaper;
	}

	public function setTrailer(trailer:PlaylistVideoItem):Void
	{
		this.trailer = trailer;
	}

	public function getTrailer():PlaylistVideoItem
	{
		return this.trailer;
	}

	public function setTrailerLoop(value:PlaylistVideoItem):Void
	{
		this.trailerLoop = value;
	}

	public function getTrailerLoop():PlaylistVideoItem
	{
		return this.trailerLoop;
	}

	public function setUebergang(value:PlaylistVideoItem):Void
	{
		this.uebergang = value;
	}

	public function getUebergang():PlaylistVideoItem
	{
		return this.uebergang;
	}



	public function getTrailers():Array
	{
		// Not yet implemented
		return null;
	}

	public function addChapters(chapters:Chapter):Void
	{
		this.chapters.push(chapters);
	}

	public function removeChapters(chapters:Chapter):Void
	{
		for (var i:Number = 0; i < this.chapters.length; i++)
		{
			if (this.chapters[i] == chapters)
			{
				this.chapters.splice(i, 1);
			}
		}
	}

	public function toChaptersArray():Array
	{
		return this.chapters;
	}

	public function addVideos(videos):Void
	{
		this.videos.push(videos);
	}

	public function removeVideos(videos):Void
	{
		for (var i:Number = 0; i < this.videos.length; i++)
		{
			if (this.videos[i] == videos)
			{
				this.videos.splice(i, 1);
			}
		}
	}

	public function toVideosArray():Array
	{
		return this.videos;
	}

	public function setMetainfo(metainfo:Metainfo):Void
	{
		this.metainfo = metainfo;
	}

	public function getMetainfo():Metainfo
	{
		return this.metainfo;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setAuthor(author:String):Void
	{
		this.author = author;
	}

	public function getAuthor():String
	{
		return this.author;
	}

	public function setActive(active:Boolean):Void
	{
		this.active = active;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	public function setRepository(repository:Repository):Void {
		this.repository = repository;
	}

	public function getRepository():Repository {
		return this.repository;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.ea.nextlevel.model.beans.Chapter " + this.getID();
		return str;
	}

	public function debugTrace () : String {
		var ret:String = toString();

		ret = ret + " | " + this.getID();
		ret = ret + " | " + this.getAuthor();
		ret = ret + " | " + this.isActive();

		return ret;
	}
}