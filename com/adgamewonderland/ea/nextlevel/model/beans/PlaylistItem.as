class com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem
{
	public static var LOOPS_INFINITE:Number = -1;
	private var ID:Number;
	private var pause:Number;
	private var loops:Number;
	private var stopmarks:String;
	private var fullScreen:Boolean;

	private function PlaylistItem()
	{
		this.ID = 0;
		this.pause = 0;
		this.loops = 0;
		this.stopmarks = "";
		this.fullScreen = false;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setFullScreen(value:Boolean):Void
	{
		this.fullScreen = value;
	}

	public function isFullScreen():Boolean
	{
		return this.fullScreen;
	}

	public function setPause(pause:Number):Void
	{
		this.pause = pause;
	}

	public function getPause():Number
	{
		return this.pause;
	}

	public function setLoops(loops:Number):Void
	{
		this.loops = loops;
	}

	public function getLoops():Number
	{
		return this.loops;
	}

	public function setStopmarks(stopmarks:String):Void
	{
		this.stopmarks = stopmarks;
	}

	public function getStopmarks():String
	{
		return this.stopmarks;
	}
}