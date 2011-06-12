import com.adgamewonderland.eplus.basecasting.beans.Promotor;
class com.adgamewonderland.eplus.basecasting.beans.City
{
	private var iD:Number;
	private var name:String;
	private var castings:Array = new Array();
	private var promotor:Promotor;

	public function City() {
		this.iD = 0;
		this.name = "";
		this.castings = new Array();
		this.promotor = null;
//		Object.registerClass("City", com.adgamewonderland.eplus.basecasting.beans.City);
	}

	public function toCastingsArray():Array
	{
		return this.castings;
	}

	public function setID(aID:Number):Void
	{
		this.iD = aID;
	}

	public function getID():Number
	{
		return this.iD;
	}

	public function setName(aName:String):Void
	{
		this.name = aName;
	}

	public function getName():String
	{
		return this.name;
	}

	public function toString() : String {
		return "City: " + getID() + ", " + getName();
	}
}
