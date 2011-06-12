import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;

class com.adgamewonderland.ea.nextlevel.model.beans.Playlist
{
	private var ID:Number;
	private var items:Array = new Array();
	private var metainfo:Metainfo;

	// Neu
	private var warteLoop	:PlaylistVideoItem;
	private var uebergang	:PlaylistVideoItem;
	private var trailer		:PlaylistVideoItem;
	private var trailerLoop	:PlaylistVideoItem;
	private var pfadWallpaper:String;	// siehe oben
	private var infoText:String;		// Copyright usw.
	private var wallpaper:String;		// Wallpaper

	public function Playlist()
	{
		this.items 			= new Array();
		this.metainfo 		= new Metainfo();
		this.warteLoop 		= null;
		this.uebergang		= null;
		this.trailer		= null;
		this.trailerLoop	= null;

		this.pfadWallpaper 	= "";
		this.infoText 		= "";
		this.wallpaper		= "";
	}

	public function addItems(items:PlaylistItem):Void
	{
		this.items.push(items);
	}

	public function removeItems(items:PlaylistItem):Void
	{
		for (var i:Number = 0; i < this.items.length; i++)
		{
			if (this.items[i] == items)
			{
				this.items.splice(i, 1);
			}
		}
	}

	public function toItemsArray():Array
	{
		return this.items;
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
	public function setInfoText(infoText:String):Void
	{
		this.infoText = infoText;
	}

	public function getInfoText():String
	{
		return this.infoText;
	}

	// getter und setter für Loop und Uebergang
	public function setWarteLoop(value:PlaylistVideoItem):Void
	{
		this.warteLoop = value;
	}

	public function getWarteLoop():PlaylistVideoItem
	{
		return this.warteLoop;
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



	public function toString() : String {
		return "com.adgamewonderland.ea.nextlevel.model.beans.Playlist";
	}
}