class de.kruesch.torwandschiessen.geom.Vector3D
{
	public var x:Number,y:Number,z:Number;

	public function Vector3D(x:Number,y:Number,z:Number)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	function normalize() : Void
	{
		var n:Number = Math.sqrt(x*x + y*y + z*z);

		x = x/n;
		y = y/n;
		z = z/n;
	}
};
