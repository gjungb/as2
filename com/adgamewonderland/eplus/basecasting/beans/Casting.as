import com.adgamewonderland.eplus.basecasting.beans.City;
import com.adgamewonderland.eplus.basecasting.beans.Location;

class com.adgamewonderland.eplus.basecasting.beans.Casting
{
	private var iD:Number;
	private var date:Date;
	private var active:Boolean;
	private var city:City;
	private var location:Location;
	private var clips:Array = new Array();

	public function Casting() {
		this.iD = 0;
		this.date = null;
		this.active = false;
		this.city = null;
		this.location = null;
	}

	public function setCity(aCity:City ):Void
	{
		this.city = aCity;
	}

	public function getCity():City
	{
		return this.city;
	}

	public function setLocation(aLocation:Location ):Void
	{
		this.location = aLocation;
	}

	public function getLocation():Location
	{
		return this.location;
	}

	public function toClipsArray():Array
	{
		return this.clips;
	}

	public function setID(aID:Number):Void
	{
		this.iD = aID;
	}

	public function getID():Number
	{
		return this.iD;
	}

	public function setDate(aDate:Date):Void
	{
		this.date = aDate;
	}

	public function getDate():Date
	{
		return this.date;
	}

	public function setActive(aActive:Boolean):Void
	{
		this.active = aActive;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	public function toString() : String {
		return "Casting: " + getID() + ", " + isActive() + ", " + getCity() + ", " + getLocation();
	}
}
