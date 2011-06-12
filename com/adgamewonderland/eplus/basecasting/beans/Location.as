class com.adgamewonderland.eplus.basecasting.beans.Location
{
	private var iD:Number;
	private var name:String;
	private var active:Boolean;
	private var castings:Array = new Array();

	public function Location() {
		this.iD = 0;
		this.name = "";
		this.active = false;
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

	public function setActive(aActive:Boolean):Void
	{
		this.active = aActive;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	public function toString() : String {
		return "Location: " + getID() + ", " + getName();
	}
}
