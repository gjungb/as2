import de.kruesch.torwandschiessen.geom.*;

class de.kruesch.torwandschiessen.geom.Point
{
	public var x:Number,y:Number;

	function Point(x:Number,y:Number)
	{
		this.x = x;
		this.y = y;				
	}
	
	function clone() : Point
	{
		return new Point(x,y);
	}
	
	function toString() : String
	{
		return "[Point("+[x,y]+")]";
	}
};
