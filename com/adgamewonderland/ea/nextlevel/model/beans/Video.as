import com.adgamewonderland.ea.nextlevel.model.beans.Chapter;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;

class com.adgamewonderland.ea.nextlevel.model.beans.Video
{
	private var ID:Number;
	private var active:Boolean = true;
	private var filename:String;
	private var thumbnail:String;
	private var duration:Number;
	private var trailer:Boolean = false;
	private var chapter:Chapter;
	private var metainfo:Metainfo;

	private var pfadFilme:String;
	private var pfadThumbnails:String;

	public function Video()
	{
		this.ID = 0;
		this.filename 	= "";
		this.thumbnail 	= "";
		this.duration 	= 0;
		this.chapter 	= null;
		this.metainfo 	= null;
		this.pfadFilme = "";
		this.pfadThumbnails = "";
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


	public function setChapter(chapter:Chapter):Void
	{
		this.chapter = chapter;
	}

	public function getChapter():Chapter
	{
		return this.chapter;
	}

	public function setMetainfo(metainfo:Metainfo):Void
	{
		this.metainfo = metainfo;
	}

	public function getMetainfo():Metainfo
	{
		return this.metainfo;
	}

	public function setActive(active:Boolean):Void
	{
		this.active = active;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	public function setFilename(filename:String):Void
	{
		this.filename = filename;
	}

	public function getFilename():String
	{
		return this.filename;
	}

	public function setThumbnail(thumbnail:String):Void
	{
		this.thumbnail = thumbnail;
	}

	public function getThumbnail():String
	{
		return this.thumbnail;
	}

	public function setDuration(duration:Number):Void
	{
		this.duration = duration;
	}

	public function getDuration():Number
	{
		return Number(this.duration);
	}

	public function setTrailer(trailer:Boolean):Void
	{
		this.trailer = trailer;
	}

	public function isTrailer():Boolean
	{
		return this.trailer;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.ea.nextlevel.model.beans.Video " + getID();
		return str;
	}

	public function debugTrace () : String {
		var ret:String = toString();

		ret = ret + " | " + this.getID();
		ret = ret + " | " + this.getPfadFilme();
		ret = ret + " | " + this.getFilename();
		ret = ret + " | " + this.getThumbnail();
		ret = ret + " | " + this.isActive();
		ret = ret + " | " + this.isTrailer();
		ret = ret + " | " + this.getDuration();

		ret = ret + " | Metainfo :  " + this.getMetainfo().debugTrace();
		return ret;
	}

}