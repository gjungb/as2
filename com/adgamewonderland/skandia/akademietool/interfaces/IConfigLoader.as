/*
klasse:			IConfigLoader
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			skandia
erstellung: 		03.12.2004
zuletzt bearbeitet:	06.12.2004
durch			gj
status:			final
*/

import com.adgamewonderland.skandia.akademietool.interfaces.*;

interface com.adgamewonderland.skandia.akademietool.interfaces.IConfigLoader {

	// Attributes
	
	// Operations
	
	public function addConsumer(con:IConfigConsumer ):Void;
	
	public function setLoadParams(params:Object ):Void;
	
	public function loadConfig():Void;
	
} /* end interface IConfigLoader */
