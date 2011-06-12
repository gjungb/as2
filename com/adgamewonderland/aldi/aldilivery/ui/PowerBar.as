class com.adgamewonderland.aldi.aldilivery.ui.PowerBar extends MovieClip
{
	private var bar:MovieClip;
	
	function setPower(n:Number) : Void
	{
		if (n<0) n = 0;
		if (n>1) n = 1;
		
		this.bar._x = -97 + 97*n;
	}
	
	function PowerBar()
	{		
		this.setPower(0);
	}
}
