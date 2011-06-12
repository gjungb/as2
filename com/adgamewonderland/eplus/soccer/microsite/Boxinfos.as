/* Boxinfos
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Boxinfos
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		05.05.2004
zuletzt bearbeitet:	06.05.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.eplus.soccer.microsite.Boxinfos extends MovieClip{

	// Attributes
	
	private var _myPath:String;
	
	private var _myHotspots:String;
	
	private var _myInitframe:Number;
	
	// Operations
	
	public  function Boxinfos()
	{
		// pfad setzen
		_parent.path = _myPath;
		// laden initialisieren
		_parent.initBox(_myInitframe, _myHotspots);
		
		// entfernen
		this.unloadMovie();
	}

} /* end class Boxinfos */
