class de.kruesch.torwandschiessen.ui.Ball extends MovieClip
{
	// c'tor
	function Ball()
	{
	}
	
	function playGoal() : Void
	{
		this.gotoAndPlay("goal");
	}
	
	function playReady() : Void
	{
		this.gotoAndPlay("ready");
	}
	
	function playKicked() : Void
	{
		this.gotoAndPlay("kicked");
	}
}
