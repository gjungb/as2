class de.kruesch.torwandschiessen.ui.BallReserve extends MovieClip
{	
	private var _count:Number;
	
	function reset() : Void
	{
		setBalls(6);
	}
	
	function setBalls(n:Number) : Void
	{
		switch(n)
		{
			case 6: this.gotoAndPlay("6balls"); _count = 6; break;			
			case 5: this.gotoAndPlay("5balls"); _count = 5; break;			
			case 4: this.gotoAndPlay("4balls"); _count = 4; break;			
			case 3: this.gotoAndPlay("3balls"); _count = 3; break;
			case 2: this.gotoAndPlay("2balls"); _count = 2; break;
			case 1: this.gotoAndPlay("1ball"); _count = 1; break;
			case 0: this.gotoAndPlay("noballs"); _count = 0; break;
		}
	}
	
	function dec() : Void
	{
		setBalls(_count-1);
	}
	
	function BallReserve()
	{
		_count = 6;
	}
}
