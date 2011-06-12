class com.adgamewonderland.agw.util.ArrayUtil
{
	static function map(a:Array, f:Function) : Array
	{
		var b:Array = [];

		for (var i:Number=0; i<a.length; i++)
		{
			b.push(f(a[i]));
		}

		return b;
	}

	static function filter(a:Array,f:Function) : Array
	{
		var b:Array = [];
		
		for (var i:Number=0; i<a.length; i++) 
		{
			var o:Object = a[i];
			if (f(o)) b.push(o);
		}

		return b;
	}

	static function reduce(a:Array,f:Function):Object
	{
		if (a.length<1) return [];

		var o:Object = a[0];

		for (var i:Number=1; i<a.length; i++)
		{
			o = f(o,a[i]);
		}
		
		return o;
	}

	function iterate(a:Array,f:Function) : Void
	{
		for (var i:Number=0; i<a.length; i++)
		{
			f(a[i]);
		}
	}

	// versteckt
	private function ArrayUtil() {}
}
