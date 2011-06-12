import com.adgamewonderland.eplus.basecasting.beans.Casting;

class com.adgamewonderland.eplus.basecasting.beans.Clip
{
	private var iD:Number;
	private var timestamp:Date;
	private var filename:String;
	private var thumbnail:String;
	private var path:String;
	private var active:Boolean;
	private var casting:Casting;

	public function Clip() {

	}

	public function setID(aID:Number):Void
	{
		this.iD = aID;
	}

	public function getID():Number
	{
		return this.iD;
	}

	public function setTimestamp(aTimestamp:Date):Void
	{
		this.timestamp = aTimestamp;
	}

	public function getTimestamp():Date
	{
		return this.timestamp;
	}

	public function setFilename(aFilename:String):Void
	{
		this.filename = aFilename;
	}

	public function getFilename():String
	{
		return this.filename;
	}

	public function setThumbnail(aThumbnail:String):Void
	{
		this.thumbnail = aThumbnail;
	}

	public function getThumbnail():String
	{
		return this.thumbnail;
	}

	public function setPath(aPath:String):Void
	{
		this.path = aPath;
	}

	public function getPath():String
	{
		return this.path;
	}

	public function setActive(aActive:Boolean):Void
	{
		this.active = aActive;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	public function setCasting(aCasting:Casting):Void
	{
		this.casting = aCasting;
	}

	public function getCasting():Casting
	{
		return this.casting;
	}

	public function toString() : String {
		return "Clip " + getID() + ": " + getPath() + getFilename() + ", " + getCasting();
	}
}
