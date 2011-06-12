/* 
 * Generated by ASDT 
*/ 

/*
klasse:			VehicleController
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		20.05.2005
zuletzt bearbeitet:	20.05.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.racing.race.*;

import com.adgamewonderland.agw.racing.track.*;

import com.adgamewonderland.agw.racing.vehicle.*;

class com.adgamewonderland.agw.racing.race.VehicleController {
	
	public static var TRACKPIECE_PREV:Number = 0;
	
	public static var TRACKPIECE_CURRENT:Number = 1;
	
	public static var TRACKPIECE_NEXT:Number = 2;
	
	private var myVehicle:Vehicle;
	
	private var myTrackpieces:Array;
	
	public function VehicleController(vobj:Vehicle )
	{
		// gesteuertes fahrzeug
		myVehicle = vobj;
		// streckenteile
		myTrackpieces = new Array(3);
	}
	
	public function setTrackpiece(type:Number, tobj:TrackPiece ):Void
	{
		// speichern
		myTrackpieces[type] = tobj;
	}
	
	public function getTrackpiece(type:Number ):TrackPiece
	{
		//  zurueck geben
		return myTrackpieces[type];
	}
}