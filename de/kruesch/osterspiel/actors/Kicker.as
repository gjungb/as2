class de.kruesch.osterspiel.actors.Kicker extends MovieClip
{
	function Kicker()
	{
	}

	function setKicking() : Void
	{
		this.gotoAndPlay("kicking");
	}

	function setKO() : Void
	{
		this.gotoAndPlay("ko");
	}

	function kickoff() : Void
	{
		this.gotoAndPlay("kickoff");
	}
}
