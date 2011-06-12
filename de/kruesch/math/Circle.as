import de.kruesch.math.*;

class de.kruesch.math.Circle
{
	var pos:Vector;
	var r:Number;

	function Circle(p:Vector,r:Number)
	{
		this.pos = p.clone();
		this.r = r;
	}

	// Berechne ersten Schnittpunkt mit Linie
	function intersectLine(l:Line) : Vector
	{
		var x1:Number	 = l.a.x - pos.x;
		var y1:Number	 = l.a.y - pos.y;

		var x2:Number	 = l.b.x - pos.x;
		var y2:Number	 = l.b.y - pos.y;

		var dx:Number	 = x2 - x1;
		var dy:Number	 = y2 - y1;

		var dr:Number	 = Math.sqrt(dx*dx + dy*dy);
		var d:Number	 = x1*y2 - x2*y1;

		var dr2:Number	 = dr*dr;
		var delta:Number = r*r * dr2 - d*d;

		if (delta<0) return null;

		var sgn_dy:Number = dy<0 ? -1 : 1;		
		var sqrtDelta:Number = Math.sqrt(delta);

		var _x1:Number = d*dy;
		var _x2:Number = sgn_dy * dx * sqrtDelta;

		var _y1:Number = -d*dx;		
		var _y2:Number = Math.abs(dy) * sqrtDelta;
		
		var result = [];
		var p1 = new Vector( pos.x + (_x1+_x2) / dr2,
						     pos.y + (_y1+_y2)/dr2 );

		var p2 = new Vector( pos.x + (_x1-_x2) / dr2,
							 pos.y + (_y1-_y2)/dr2 );

		var n1:Number = l.getPosFactor(p1);
		var n2:Number = l.getPosFactor(p2);

		var inside1 = (n1>=0)&&(n1<=1);
		var inside2 = (n2>=0)&&(n2<=1);

		if (inside1)
		{
			if (inside2) 
			{
				return n1<n2 ? p1 : p2;
			}
			else 
			{
				return p1;
			}
		} 
		else 
		{
			return inside2 ? p2 : null;
		}
	}

	function toString() : String
	{
		return "[Circle( ("+[pos.x,pos.y]+"), "+r+")]";
	}
};
