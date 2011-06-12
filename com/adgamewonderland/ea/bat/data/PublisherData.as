class com.adgamewonderland.ea.bat.data.PublisherData
{
	private static var _idCounter:Number = 0;

	// ---------------------------------------------------------

	// Basisdaten
	private var _id:Number;
	private var _name:String;
	private var _share:Number;	
	private var _avgPrice:Number;

	// Properties
	public function get id():Number { return _id; }
	public function get name():String { return _name; }
	public function get share():Number { return _share; }
	public function get avgPrice():Number { return _avgPrice; }

	// ---------------------------------------------------------

	// Konstruktor
	function PublisherData( name:String, share:Number, avgPrice:Number )
	{
		_id = _idCounter++;
		_name = name;
		_share = share;
		_avgPrice = avgPrice;
	}

	function toString() : String
	{
		return "PublisherData {name:"+name+",share:"+share+",avgPrice:"+avgPrice+"}";
	}
}
