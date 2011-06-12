/*
klasse:			Movable
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		06.03.2005
zuletzt bearbeitet:	06.03.2005
durch			gj
status:			final
*/

interface com.adgamewonderland.eplus.baseclip.interfaces.Movable {

	function setPosition(xpos:Number, ypos:Number ):Void;

	function onMove():Void;

	function onStopMove():Void;
}