/**
 * ein Rezept mit Link zu weiterführenden Informationen
 */
 class com.adgamewonderland.cma.adventskalender2006.beans.Recipe 
{
	private var day:com.adgamewonderland.cma.adventskalender2006.beans.Day;
	private var name:String;
	private var url:String;

	public function Recipe(day:com.adgamewonderland.cma.adventskalender2006.beans.Day, name:String, url:String)
	{
		// kalendertag
		this.day = day;
		// name des rezepts
		this.name = name;
		// url zum rezept
		this.url = url;
	}

	public function getDay():com.adgamewonderland.cma.adventskalender2006.beans.Day
	{
		return this.day;
	}

	public function getName():String
	{
		return this.name;
	}

	public function getUrl():String
	{
		return this.url;
	}
	
	public function toString(Void) : String {
		return "Recipe: " + getDay().getId() + ", " + getName();
	}
}