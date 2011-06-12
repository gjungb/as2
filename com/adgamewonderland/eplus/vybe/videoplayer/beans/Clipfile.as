class com.adgamewonderland.eplus.vybe.videoplayer.beans.Clipfile
{
	private var url:String;

	private var application:String;

	private var file:String;

	public function Clipfile()
	{
		// url
		this.url = "";
		// application (streaming-server)
		this.application = "";
		// file (pfad zum video auf streaming-server)
		this.file = "";
	}

	public function setUrl(aUrl:String):Void
	{
		this.url = aUrl;
	}

	public function getUrl():String
	{
		return this.url;
	}

	public function setApplication(aApplication:String):Void
	{
		this.application = aApplication;
	}

	public function getApplication():String
	{
		return this.application;
	}

	public function setFile(aFile:String):Void
	{
		this.file = aFile;
	}

	public function getFile():String
	{
		return this.file;
	}
}
