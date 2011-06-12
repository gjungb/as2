import de.kruesch.event.EventBroadcaster;

// MovieClip des Ballgebers
class de.kruesch.torwandschiessen.ui.BallGiver extends MovieClip
{
	private var _event:EventBroadcaster;
	
	function BallGiver()
	{
		_event = new EventBroadcaster();
	}
	
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }
	
	function wait() : Void
	{
		this.gotoAndStop(1);
	}
	
	function giveBall() : Void
	{
		this.gotoAndPlay("give");
	}
	
	function onBallGivenPlayed() : Void
	{
		_event.send("onBallGiven");
	}
}

