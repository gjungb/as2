/* 
 * Generated by ASDT 
*/ 

/*
klasse:			Movable
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			aldi
erstellung: 		06.03.2005
zuletzt bearbeitet:	06.03.2005
durch			gj
status:			final
*/

interface com.adgamewonderland.aldi.interfaces.Movable {
	
	function setPosition(xpos:Number, ypos:Number ):Void;
	
	function onMove():Void;
	
	function onStopMove():Void;
}