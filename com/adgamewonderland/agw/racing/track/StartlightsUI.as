/* 
 * Generated by ASDT 
*/ 

/*
klasse:			StartlightsUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		19.06.2005
zuletzt bearbeitet:	19.06.2005
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.racing.track.StartlightsUI extends MovieClip {
	
	private static var PAUSE_START:Number = 1000;
	
	private static var PAUSE_LIGHT:Number = 1000;
	
	private var myCaller:Object;
	
	private var myCallback:Function;
	
	private var myInterval:Number;
	
	public function StartlightsUI()
	{
		// interval 
		myInterval = 0;
	}
	
	public function startLights(caller:Object, callback:Function ):Void
	{
		// caller, der die ampel startet
		myCaller = caller;
		// callback, wenn ampel fertif
		myCallback = callback;
		// nach pause erstes licht
		myInterval = setInterval(this, "onLightsStarted", PAUSE_START);
	}
	
	public function onLightsStarted():Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// regelmaessig naechstes licht
		myInterval = setInterval(this, "nextLight", PAUSE_LIGHT);
	}
	
	public function nextLight():Void
	{
		// eins weiter
		nextFrame();
		// testen, ob am ende
		if (_currentframe == _totalframes) {
			// interval loeschen
			clearInterval(myInterval);
			// callback aufrufen
			myCallback.apply(myCaller, []);
		}
	}
	
}