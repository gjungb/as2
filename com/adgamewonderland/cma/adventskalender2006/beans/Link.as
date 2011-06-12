/**
 * ein Link zu weiterführenden Informationen zum Quiz des Tages */
class com.adgamewonderland.cma.adventskalender2006.beans.Link 
{
	private var day:com.adgamewonderland.cma.adventskalender2006.beans.Day;
	private var url:String;

	public function Link(day:com.adgamewonderland.cma.adventskalender2006.beans.Day, url:String)
	{
		// kalendertag
		this.day = day;
		// url zur information
		this.url = url;
	}

	public function getDay():com.adgamewonderland.cma.adventskalender2006.beans.Day
	{
		return this.day;
	}

	public function getUrl():String
	{
		return this.url;
	}
	
	public function toString(Void) : String {
		return "Link " + getDay().getDate().getDate() + ": " + this.getUrl();
	}
}