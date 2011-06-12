/* Shutter
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Shutter
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		08.07.2004
zuletzt bearbeitet:	08.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.Shutter extends MovieClip {

	// Attributes
	
	private var myCaller:Object;
	
	private var myCallback:String;
	
	private var myParam;
	
	// Operations
	
	public  function Shutter()
	{
		// global verfuegbar
		_global.Shutter = this;
	}
	
	public function closeShutter(caller:Object, callback:String, param ):Void
	{
		// aufrufendes object
		myCaller = caller;
		// callback sobald geschlossen
		myCallback = callback;
		// parameter fuer callback
		myParam = param;
		// schliessen
		gotoAndPlay("frClose");
	}
	
	private function onCloseShutter():Void
	{
		// callback aufrufen
		myCaller[myCallback](myParam);
	}

} /* end class Shutter */
