class com.adgamewonderland.aldi.aldilivery.ui.Clock extends MovieClip
{
	function setTime(t:Number) : Void
	{
		if (t>=1.0) t = 0.999999999999999;
		
		var frames:Number = this._totalframes;
		this.gotoAndStop(1+Math.floor(t*frames));
	}
	
	function Clock()
	{
		this.stop();
	}
}
