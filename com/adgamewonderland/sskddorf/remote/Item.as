/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.sskddorf.remote.Item {
	
	private var myId:Number;
	
	private var myLabel:String;
	
	private var myDescription:String;
	
	private var myPath:String;
	
	public function Item()
	{
		// eindeutige id
		myId = 0;
		// label auf button
		myLabel = "";
		// beschreibung in display
		myDescription = "";
		// pfad auf website
		myPath = "";
	}
	
	public function get id():Number
	{
		return myId;
	}
	
	public function set id(id:Number ):Void
	{
		this.myId = id;
	}
	
	public function get label():String
	{
		return myLabel;
	}
	
	public function set label(label:String ):Void
	{
		this.myLabel = label;
	}
	
	public function get description():String
	{
		return myDescription;
	}
	
	public function set description(description:String ):Void
	{
		this.myDescription = description;
	}
	
	public function get path():String
	{
		return myPath;
	}
	
	public function set path(path:String ):Void
	{
		this.myPath = path;
	}
	
}