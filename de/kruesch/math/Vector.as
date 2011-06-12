class de.kruesch.math.Vector
{
	var x:Number;
	var y:Number;

	function Vector(x:Number,y:Number) 
	{
		this.x = x;
		this.y = y;
	}

	function dot(v:Vector) : Number
	{
		return x*v.x + y*v.y;
	}

	function plus(v:Vector) : Vector
	{
		return new Vector( x + v.x, y + v.y );
	}

	function minus(v:Vector) : Vector
	{
		return new Vector(x-v.x,y-v.y);
	}

	function normalize() : Vector
	{
		var d:Number = Math.sqrt(x*x+y*y);

		return new Vector(x/d,y/d);
	}

	function multiply(n:Number) : Vector
	{
		return new Vector(x*n,y*n);
	}

	function clone() : Vector
	{
		return new Vector(x,y);
	}

	function length() : Number
	{
		return Math.sqrt(x*x+y*y);
	}

	function distanceTo(v:Vector) : Number
	{
		var dx:Number = v.x - x;
		var dy:Number = v.y - y;

		return Math.sqrt(dx*dx + dy*dy);
	}

	function toString() : String
	{
		return "[Vector("+[x,y]+")]";
	}
}

