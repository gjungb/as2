import com.adgamewonderland.ea.nextlevel.model.beans.Chapter;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;

class com.adgamewonderland.ea.nextlevel.model.beans.Repository
{
	private var ID:Number;
	private var publisher:String;
	private var chapters:Array = new Array();
	private var warteLoop:Video;
	private var trailer:Video;
	private var trailerLoop:Video;
	private var uebergang:Video;
	private var metainfo:Metainfo;
	private var pfadFilme:String;		// Pfad für die Videos
	private var pfadThumbnails:String;	// siehe oben
	private var pfadWallpaper:String;	// siehe oben
	private var infoText:String;		// Copyright usw.
	private var wallpaper:String;		// Wallpaper

	public function Repository()
	{
		this.ID 			= 0;
		this.publisher 		= "";
		this.warteLoop		= null;
		this.trailer 		= null;
		this.trailerLoop 	= null;
		this.uebergang 		= null;
		this.metainfo 		= null;
		this.pfadFilme 		= "";
		this.pfadThumbnails = "";
		this.pfadWallpaper 	= "";
		this.infoText 		= "";
		this.wallpaper		= "";
	}

	public function setWarteLoop(value:Video):Void
	{
		this.warteLoop = value;
	}

	public function getWarteLoop():Video
	{
		return this.warteLoop;
	}

	public function setTrailerLoop(value:Video):Void
	{
		this.trailerLoop = value;
	}

	public function getTrailerLoop():Video
	{
		return this.trailerLoop;
	}

	public function setUebergang(value:Video):Void
	{
		this.uebergang = value;
	}

	public function getUebergang():Video
	{
		return this.uebergang;
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

	public function setTrailer(trailer:Video):Void
	{
		this.trailer = trailer;
	}

	public function getTrailer():Video
	{
		return this.trailer;
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

	public function setPfadFilme(pfadFilme:String):Void
	{
		this.pfadFilme = pfadFilme;
	}

	public function getPfadFilme():String
	{
		return this.pfadFilme;
	}
	public function setPfadThumbnails(pfadThumbnails:String):Void
	{
		this.pfadThumbnails = pfadThumbnails;
	}

	public function getPfadThumbnails():String
	{
		return this.pfadThumbnails;
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

	public function setInfoText(infoText:String):Void
	{
		this.infoText = infoText;
	}

	public function getInfoText():String
	{
		return this.infoText;
	}


	public function setPublisher(publisher:String):Void
	{
		this.publisher = publisher;
	}

	public function getPublisher():String
	{
		return this.publisher;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.ea.nextlevel.model.beans.Repository " + getID();
		return str;
	}

	public function debugTrace () : String {
		var ret:String = toString();

		ret = ret + " | " + this.getID();
		ret = ret + " | " + this.getPublisher();
		ret = ret + " | Metainfo :  " + this.getMetainfo().debugTrace();

		return ret;
	}

}