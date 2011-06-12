/*
 * Pfeildarstellung */
class de.kruesch.torwandschiessen.ui.DirectionPointer extends MovieClip
{
	private var _arrow:MovieClip;
	private static var MAX_DISTANCE = 340;

	function DirectionPointer()
	{		
	}

	function show()
	{
		_arrow._visible = true;
	}

	function hide()
	{
		_arrow._visible = false; 
	}

	function pointTo(dx:Number,dy:Number) : Void
	{
		var a = Math.atan2( -dy, -dx ) * 180/Math.PI;		
		_arrow.target._rotation = 90 + a;		

		var ratio = Math.abs(dy/MAX_DISTANCE);
		if (ratio<0.3) ratio = 0.3;
		if (ratio>1) ratio = 1;
		
		var ys:Number = 100*ratio;
			
		_arrow._yscale = ys;
		_arrow._y = -10+ys*0.1;
	}
};
