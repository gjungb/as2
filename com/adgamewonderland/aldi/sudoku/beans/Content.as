/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.aldi.sudoku.beans.Content {
	
	public static var CONTENT_EMPTY:Number = -1;
	
	private var id:Number;
	
	public function Content(id:Number ) {
		this.id = id;
	}
	
	public function toString():String
	{
		return ("Content: " + getId());
	}
	
	public function equals(c:Content ):Boolean
	{
		return (c.getId() == this.getId());
	}
	
	public function getId():Number {
		return id;
	}

	public function setId(id:Number):Void {
		this.id = id;
	}

}