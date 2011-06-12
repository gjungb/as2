class com.adgamewonderland.test.Ball extends MovieClip {
	var mySpeed:Number = 4;
	var myDir:Object = {x : 0, y : 0};

	function showSpeed():Number {
		trace(mySpeed + 20);
		return(mySpeed);
	}
}
