/* 
 * Generated by ASDT 
*/ 

/*
klasse:			VehicleSound
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		01.06.2005
zuletzt bearbeitet:	03.06.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.racing.vehicle.*;

class com.adgamewonderland.agw.racing.vehicle.VehicleSound {
	
	private static var BASENAME:String = "gearsound";
	
	private static var LOOPS:Number = 2e15; // 2e15;
	
	private var myVehicle:Vehicle;
	
	private var myLastGear:Number;
	
	private var myLastDir:Number;
	
	private var myLastVelocity:Number;
	
	private var mySounds:Array;
	
	private var myCurrentSound:Sound;
	
	public function VehicleSound(vobj:Vehicle )
	{
		// fahrzeug, zu dem der sound gehoert
		myVehicle = vobj;
		// gang, in dem das fahrzeug zuletzt gefahren ist
		myLastGear = 1;
		// letzter schaltvorgang
		myLastDir = 0;
		// geschwindigkeit, mit der das fahrzeug zuletzt gefahren ist
		myLastVelocity = 0;
		// alle sounds
		mySounds = new Array();
		// attachen
		for (var gear:Number = 1; gear <= Vehicle.GEARS; gear++) {
			// schneller
			var soundin:Sound = new Sound(vobj.movieclip);
			soundin.attachSound(BASENAME + gear + "_in");
			// langsamer
			var soundout:Sound = new Sound(vobj.movieclip);
			soundout.attachSound(BASENAME + gear + "_out");
			// konstant
			var soundconst:Sound = new Sound(vobj.movieclip);
			soundconst.attachSound(BASENAME + gear + "_const");
			// als object in array
			mySounds[gear] = {soundin : soundin, soundout : soundout, soundconst : soundconst};
		}
		// aktueller sound
		myCurrentSound = mySounds[1].soundconst;
		// leerlauf
		myCurrentSound.start(0, LOOPS);
	}
	
	public function controlSound()
	{
		// aktueller gang
		var gear:Number = myVehicle.getGear();
		// aktuelle geschwindigkeit
//		var velocity:Number = myVehicle.velocity.getLength();
		// richtung, in die der gang gewechselt wurde
		var dir:Number = myVehicle.velocitydir;
		// testen, ob geschaltet wurde
		if (gear != myLastGear) {
			// richtung
			dir = myVehicle.velocitydir; // ((gear - myLastGear) / Math.abs(gear - myLastGear));
		} else {
			// nicht geschaltet
			dir = 0;
		}
		// neuer sound
		var newsound:Sound = myCurrentSound;
		// je nach richtung
		switch (dir) {
			// hochgeschaltet
			case 1 :
				// neuer sound
				newsound = mySounds[gear].soundin;
				trace("up to: " + gear);
				// aktuellen sound stoppen
				myCurrentSound.stop();
				// sound spielen
				newsound.start(0, 1);
				// letzter schaltvorgang
				myLastDir = 1;
				
				break;
			// runtergeschaltet
			case -1 :
				// abbrechen, wenn zuletzt runter geschaltet, aber sound noch nicht zu ende
//				if (myLastDir == -1 && myCurrentSound.position < myCurrentSound.duration) break;
				// neuer sound
				newsound = mySounds[gear + 1].soundout;
				trace("down to: " + gear);
				// position, an der der sound gestartet werden soll
				var ms:Number;
				// anteil, der vom aktuellen sound abgespielt wurde
				var share:Number = myCurrentSound.position / myCurrentSound.duration;
				// je nach letztem schaltvorgang
				if (myLastDir == 1) {
					ms = (1 - share) * newsound.duration;
				} else if (myLastDir == -1) {
					ms = share * newsound.duration;
				} else {
					ms = 0;
				}
				// aktuellen sound stoppen
				myCurrentSound.stop();
				// sound spielen
				newsound.start(ms / 1000, 1);
				// letzter schaltvorgang
				myLastDir = -1;
			
				break;
			// nicht geschaltet
			case 0 :
				// testen, ob sound noch nicht am spielen
				if (myCurrentSound != mySounds[gear].soundconst) {
					// testen, ob schaltsound zu ende
					if (myCurrentSound.position != undefined && myCurrentSound.position == myCurrentSound.duration) {
						// neuer sound
						newsound = mySounds[gear].soundconst;
						// aktuellen sound stoppen
						myCurrentSound.stop();
						// sound spielen
						newsound.start(0, LOOPS);
						trace("loop: " + gear);
						// letzter schaltvorgang
						myLastDir = 0;
					}
				}
				break;
		}
		// aktueller sound
		myCurrentSound = newsound;
		// referenz auf controller
		myCurrentSound["controller"] = this;
		// updaten, wenn zu ende
		myCurrentSound.onSoundComplete = function() {
			this.controller.controlSound();
		};
		// gang, in dem das fahrzeug zuletzt gefahren ist
		myLastGear = gear;
	}
	
//	public function controlSound():Void
//	{
//		// aktueller gang
//		var gear:Number = myVehicle.getGear();
//		// neuer sound
//		var newsound:Sound = myCurrentSound;
//		// testen, ob sound noch nicht am spielen
//		if (myCurrentSound != mySounds[gear].soundconst) {
//			// neuer sound
//			newsound = mySounds[gear].soundconst;
//			// aktuellen sound stoppen
//			myCurrentSound.stop();
//			// sound spielen
//			newsound.start(0, LOOPS);
//			trace("loop: " + gear);
//		}
//		// aktueller sound
//		myCurrentSound = newsound;
//		// referenz auf controller
//		myCurrentSound["controller"] = this;
//		// updaten, wenn zu ende
//		myCurrentSound.onSoundComplete = function() {
//			this.controller.controlSound();
//		};
//	}
	
//	public function controlSound():Void
//	{
//		// aktueller gang
//		var gear:Number = myVehicle.getGear();
//		// abbrechen, wenn nicht geschaltet wurde
//		if (gear == myLastGear) return;
//		// gang, in dem das fahrzeug zuletzt gefahren ist
//		myLastGear = gear;
//		trace("gear: " + gear);
//		// scheife ueber alle gaenge
//		for (var i:Number = 1; i <= Vehicle.GEARS; i++) {
//			// soundloop fuer diesen gang
//			var loop:Sound = mySounds[i].soundconst;
//			// testen, ob gang zu niedrig
//			if (i > gear) {
//				// stoppen
//				loop.stop();
//				trace("stop: " + i);
////				loop["playing"] = false;
//			} else {
//				// starten, wenn noch nicht gestartet
////				if (loop["playing"] != true) {
//					loop.start(0, LOOPS);
////					loop["playing"] = true;
//					trace("start: " + i);
////				}
//			}
//		}
//	}
}