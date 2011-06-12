class com.adgamewonderland.ea.nextlevel.model.beans.Metainfo
{
	private var ID:Number;
	private var title:String;
	private var description:String;
	private var creationdate:Date;
	private var lastmodified:Date;

	// Neue felder 11.07.2007
	private var subtitle:String;
	private var city:String;
	private var presenter:String;
	private var presentationdate:String;

	public function Metainfo()
	{
		this.ID = 1;
		this.title 			= "";
		this.description 	= "";
		this.creationdate 	= new Date();
		this.lastmodified 	= new Date();

		this.subtitle		= "";
		this.city			= "";
		this.presenter 		= "";
		this.presentationdate = "";
	}

	public function setSubtitle(value:String):Void
	{
		this.subtitle = value;
	}
	public function getSubtitle():String
	{
		return this.subtitle;
	}
	public function setCity(value:String):Void
	{
		this.city = value;
	}
	public function getCity():String
	{
		return this.city;
	}
	public function setPresenter(value:String):Void
	{
		this.presenter = value;
	}
	public function getPresenter():String
	{
		return this.presenter;
	}
	public function setPresentationdate(value:String):Void
	{
		this.presentationdate = value;
	}
	public function getPresentationdate():String
	{
		return this.presentationdate;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setTitle(title:String):Void
	{
		this.title = title;
	}

	public function getTitle():String
	{
		return this.title;
	}

	public function setDescription(description:String):Void
	{
		this.description = description;
	}

	public function getDescription():String
	{
		return this.description;
	}

	public function setCreationdate(creationdate:Date):Void
	{
		this.creationdate = creationdate;
	}

	public function getCreationdate():Date
	{
		return this.creationdate;
	}

	public function setLastmodified(lastmodified:Date):Void
	{
		this.lastmodified = lastmodified;
	}

	public function getLastmodified():Date
	{
		return this.lastmodified;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.ea.nextlevel.model.beans.Metainfo " + getID();
		return str;
	}

	public function debugTrace () : String {
		var ret:String = toString();

		ret = ret + " | " + this.getID();
		ret = ret + " | " + this.getTitle();
		ret = ret + " | " + this.getSubtitle();
		ret = ret + " | " + this.getCity();
		ret = ret + " | " + this.getPresenter();
		ret = ret + " | " + this.getPresentationdate();
		ret = ret + " | " + this.getDescription();

		return ret;
	}

}