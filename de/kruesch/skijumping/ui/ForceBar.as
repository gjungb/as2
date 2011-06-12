class de.kruesch.skijumping.ui.ForceBar
{
	private var bar:MovieClip;
	private var arrows:MovieClip;
	
	function ForceBar()
	{
		this.reset();
	}
	
	function setBar(percent:Number) : Void
	{
		if (percent<0) percent = 0;
		if (percent>100) percent = 100;
		
		this.arrows._x = 160 * percent/100;
		this.bar._xscale = percent;
	}
	
	function reset() : Void
	{
		this.setBar(0);
	}
}