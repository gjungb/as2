/**
 * ein Tag des Adventskalenders
 */
class com.adgamewonderland.cma.adventskalender2006.beans.Day 
{
	private var id:Number;
	private var date:Date;

	public function Day(id:Number)
	{
		// id (entspricht dem tag im dezember)
		this.id = id;
		// datum (tag im dezember)
		this.date = new Date(2006, 11, id);
	}

	public function setId(id:Number):Void
	{
		this.id = id;
	}

	public function getId():Number
	{
		return this.id;
	}

	public function setDate(date:Date):Void
	{
		this.date = date;
	}

	public function getDate():Date
	{
		return this.date;
	}
}