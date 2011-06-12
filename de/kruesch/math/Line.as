import de.kruesch.math.*;

class de.kruesch.math.Line
{
	var a:Vector;
	var b:Vector;

	// c'tor
	function Line(a:Vector,b:Vector)
	{
		this.a = a.clone();
		this.b = b.clone();
	}
	
	// Distanz Punkt-Gerade
	function distanceTo(c:Vector) : Number
	{
		var dx:Number = b.x - a.x;
		var dy:Number = b.y - a.y;
		var dr:Number = Math.sqrt(dx*dx + dy*dy);

		var n:Number = (b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x);		
		var d:Number = Math.abs(n)/dr;

		var x:Number = c.x + n * dy/(dr*dr);
		var y:Number = c.y - n * dx/(dr*dr);
		
		return d;
	}

	function setToDistance(c:Vector,dn:Number) : Vector
	{
		var dx:Number = b.x - a.x;
		var dy:Number = b.y - a.y;
		var dr:Number = Math.sqrt(dx*dx + dy*dy);

		var n:Number = (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x);	
		var sgn:Number = n<0 ? -1 : 1;
		var d:Number = Math.abs(n)/dr;

		// Projektion auf Linie
		var xl:Number = c.x + n * dy/(dr*dr);
		var yl:Number = c.y - n * dx/(dr*dr);

		return new Vector( xl - sgn*dn*dy/dr, yl + sgn*dn*dx/dr);
	}

	// Positionsfaktor
	function getPosFactor(c:Vector) : Number
	{
		var dx:Number = b.x - a.x;
		var dy:Number = b.y - a.y;

		if (dx==0) 
		{
			if (dy==0)
			{
				return 0;
			}

			return (c.y-a.y) / dy;
		} 
		else 
		{
			return (c.x-a.x) / dx;
		}
	}

	// liegt Geraden-Punkt innerhalb der Line
	function contains(c:Vector) : Boolean
	{
		var dx:Number = b.x - a.x;
		var dy:Number = b.y - a.y;

		if (dx==0) 
		{
			if (dy==0)
			{
				return (c.x==a.x) && (c.y==a.y);
			}

			var n:Number = (c.y-a.y) / dy;
			return (n>=0) && (n<=1);
		} 
		else 
		{
			var n:Number = (c.x-a.x) / dx;
			return (n>=0) && (n<=1);
		}
	}

	function toString() : String
	{
		return "[Line ("+[a.x,a.y]+") ("+[b.x,b.y]+")]";
	}
};

