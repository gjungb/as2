import com.adgamewonderland.eplus.vybe.videoplayer.beans.Artist;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.Clipfile;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.Thumbnail;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.Minitvlist;
class com.adgamewonderland.eplus.vybe.videoplayer.beans.Asset
{
	private var id:Number;

	private var recordpartner:Number;

	private var created:Date;

	private var modified:Date;

	private var title:String;

	private var artist:Artist;

	private var clipfile:Clipfile;

	private var thumbnail:Thumbnail;

	private var minitvlist:Minitvlist;

	public function Asset()
	{
		// id
		this.id = 0;
		// recordpartner
		this.recordpartner = 0;
		// created
		this.created = null;
		// modified
		this.modified = null;
		// title
		this.title = "";
		// artist
		this.artist = new Artist();
		// clipfile
		this.clipfile = new Clipfile();
		// thumbnail
		this.thumbnail = new Thumbnail();
		// minitvlist
		this.minitvlist = null;
	}

	public function getArtist():Artist
	{
		return this.artist;
	}

	public function getClipfile():Clipfile
	{
		return this.clipfile;
	}

	public function getThumbnail():Thumbnail
	{
		return this.thumbnail;
	}

	public function getId():Number
	{
		return this.id;
	}

	public function getRecordpartner():Number
	{
		return this.recordpartner;
	}

	public function getCreated():Date
	{
		return this.created;
	}

	public function getModified():Date
	{
		return this.modified;
	}

	public function getTitle():String
	{
		return this.title;
	}

	public function setMinitvlist(aMinitvlist:Minitvlist):Void
	{
		this.minitvlist = aMinitvlist;
	}

	public function getMinitvlist():Minitvlist
	{
		return this.minitvlist;
	}
}
