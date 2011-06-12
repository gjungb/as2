class com.adgamewonderland.agw.util.StringHelper
{
	static function replace(str:String,chunk:String,repl:String) : String
	{
		if (repl==null) repl = "";
		return str.split(chunk).join(repl);
	}

	static function reverse(str:String) : String
	{
		if (str==null) str = "";
		var arr:Array = str.split("");
		arr.reverse();
		return arr.join("");
	}

	// -------------------------------

	private function StringHelper() {}
};