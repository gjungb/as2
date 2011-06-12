class com.adgamewonderland.ea.bat.util.StringFormatter
{
	static function formatMoney(amount:Number) : String
	{
		if (isNaN(amount)) amount = 0;
		amount = Math.round(amount*100)/100;
		
		var str:String = amount.toString();
		var arr:Array = str.split(".");
		
		var n:String = arr[0];
		var c:String = (arr.length>1 ? arr[1] : "") + "00";

		var txt:String = "";
		var last:Number = n.length - 1;
		for (var i:Number=0; i<n.length; i++)
		{			
			var chr:String = n.substr(last - i,1); // i-te Stelle von hinten
			if ( (i%3==0) && (chr!="-") && (i!=0) ) txt = "." + txt;
			txt = chr + txt;			

			// if ((i%3==2)&&(i!=(n.length-1))&&(chr!="-")) txt = "." + txt;
		}

		txt += "," + c.substr(0,2) + " €";

		return txt;
	}

	// hidden
	private function StringFormatter() {}
}