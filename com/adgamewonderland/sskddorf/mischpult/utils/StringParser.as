class com.adgamewonderland.sskddorf.mischpult.utils.StringParser
{
	static function formatMoney(amount:Number) : String
	{
		if ((amount<0)||isNaN(amount)) amount = 0;
		amount = Math.round(amount);
		
		var str:String = amount.toString();
		var txt:String = "";
		for (var i:Number=0; i<str.length; i++)
		{			
			txt = str.substr(str.length-i-1,1) + txt;			
			if ((i%3==2)&&(i!=(str.length-1))) txt = "." + txt;
		}
		
		return txt + ",-";
	}
	
	// hidden c'tor
	private function StringParser() {}
}
