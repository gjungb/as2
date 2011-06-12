﻿/*  * Generated by ASDT */ /*klasse:			BarrelUIautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			ssk ddorferstellung: 		09.09.2005zuletzt bearbeitet:	12.09.2005durch			gjstatus:			in bearbeitung*/import com.adgamewonderland.sskddorf.slotmachine.ui.*;class com.adgamewonderland.sskddorf.slotmachine.ui.BarrelUI extends MovieClip {		public static var FIELDS_NUM:Number = 10;		private static var FIELDS_HEIGHT:Number = 50;		private static var FIELDS_YDIFF:Number = 10;		private static var VELOCITY_MIN:Number = 20;		private static var VELOCITY_MAX:Number = 200;		private static var VELOCITY_DIR:Number = -1;		private var myFields:Array;		private var myHeight:Number;		private var myYStart:Number;		private var myFieldCurrent:Number;		private var myFieldStop:Number;		public function BarrelUI()	{		// auf buehne angezeigte felder		myFields = [];		// hoehe auf buehne		myHeight = FIELDS_NUM * (FIELDS_HEIGHT + FIELDS_YDIFF);		// startposition		myYStart = _y;		// aktuell reinrollendes feld		myFieldCurrent = 0;		// feld, bei dem gestoppt werden soll		myFieldStop = 0;	}		public function initFields(numlogos:Number, start:Number ):Void	{		// zaehler zum verteilen der logos		var counter:Number = 0;		// id des logos		var id:Number = 0;		// neues feld auf buehne		var field:FieldUI;		// logos in dreierabstand verteilen		do {			// zaehler zum verteilen der logos hochzaehlen			counter += 3;			// id hochzaehlen			id ++;			// umschlagen			if (counter > FIELDS_NUM) counter -= FIELDS_NUM;			// neues feld			field = FieldUI(attachMovie("fieldUI", "field" + counter + "_mc", counter));			// feld speichern			myFields[counter] = field;			// logo laden			field.loadLogo(id);					} while (--numlogos > 0);		// restliche felder mit statischen motiven fuellen		for (var i:Number = 1; i <= FIELDS_NUM; i++) {			// testen, ob noch nicht vorhanden			if (myFields[i] == undefined) {				// neues feld				field = FieldUI(attachMovie("fieldUI", "field" + i + "_mc", i));				// feld speichern				myFields[i] = field;				// motiv anzeigen				field.showMotif(i);			}			// positionieren			myFields[i]._y = (i - 1) * (FIELDS_HEIGHT + FIELDS_YDIFF);		}		// auf startposition		showField(start);	}		public function startBarrel():Void	{		// aktuell reinrollendes feld		myFieldCurrent = 0;		// feld, bei dem gestoppt werden soll		myFieldStop = 0;		// bewegen		onEnterFrame = moveBarrel;	}		public function stopBarrelAtField(field:Number ):Void	{		// feld, bei dem gestoppt werden soll		myFieldStop = field;	}		public function stopBarrelAtLogo(logoid:Number ):Void	{		// schleife ueber alle felder		for (var i:String in myFields) {			// testen, ob logo in diesem feld			if (myFields[i].logoid == logoid) {				// stoppen				stopBarrelAtField(i);				// abbrechen				break;			}		}	}		private function showField(field:Number ):Void	{		// positionieren		_y = myYStart - (field - 1) * (FIELDS_HEIGHT + FIELDS_YDIFF);	}		private function moveBarrel():Void	{		// geschwindigkeit		var v:Number = VELOCITY_MIN;		// neue position		var ypos:Number = _y + VELOCITY_DIR * v;		// abstand zur startposition		var ydiff:Number = Math.abs(ypos - myYStart);		// testen, ob raus		if (ydiff >= myHeight) {			// an start			ypos = myYStart;			// abstand 0			ydiff = 0;		}		// bewegen		_y = ypos;		// ist das erste feld sichtbar		var first:Boolean = (ydiff < (FIELDS_HEIGHT + FIELDS_YDIFF));		// erstes feld oben / unten positionieren		if (first) {			myFields[1]._y = 0;			} else {			myFields[1]._y = myFields[FIELDS_NUM]._y + FIELDS_HEIGHT + FIELDS_YDIFF;		}				// aktuell reinrollendes feld		myFieldCurrent = Math.ceil(ydiff / (FIELDS_HEIGHT + FIELDS_YDIFF)) + 1;		// testen, ob gestoppt werden soll		if (myFieldCurrent == myFieldStop) {			// erstes feld oben positionieren			myFields[1]._y = 0;				// anzeigen			showField(myFieldStop);			// stoppen			onStopBarrel();		}	}		private function onStopBarrel():Void	{		// stoppen		delete(onEnterFrame);	}		}