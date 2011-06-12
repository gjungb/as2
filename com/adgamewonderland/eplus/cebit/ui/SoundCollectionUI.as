/* 
 * Generated by ASDT 
*/ 

/*
klasse:			SoundCollectionUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		02.03.2005
zuletzt bearbeitet:	02.03.2005
durch			gj
status:			final
*/

import com.adgamewonderland.eplus.cebit.ui.SoundPlayer;

class com.adgamewonderland.eplus.cebit.ui.SoundCollectionUI extends MovieClip {
	
	private var _mySounds:Array;
	
	private var _myFrequencies:Array;
	
	private var mySoundPlayers:Array;
	
	private var isPlaying:Boolean;
	
	public function SoundCollectionUI()
	{
		// global ansprechbar
		_global.SoundCollection = this;
		// array mit sound playern
		mySoundPlayers = [];
		// schleife ueber alle sounds
		for (var i:String in _mySounds) {
			// aktueller sound (verknuepfung in library)
			var snd:String = _mySounds[i];
			// aktuelle frequenz
			var freq:Number = (_myFrequencies[i] != undefined ? _myFrequencies[i] : 0);
			// neuer player
			mySoundPlayers.push(new SoundPlayer(snd, freq));
		}
		// spielen alle sounds oder nicht
		isPlaying = false;
		// alle starten
		startCollection();
	}
	
	public function startCollection():Void
	{
		// abbrechen, wenn schon am spielen
		if (isPlaying == true) return;
		// schleife ueber alle player
		for (var i:String in mySoundPlayers) mySoundPlayers[i].startSound();
		// spielt
		isPlaying = true;
	}
	
	public function stopCollection():Void
	{
		// schleife ueber alle player
		for (var i:String in mySoundPlayers) mySoundPlayers[i].stopSound();
		// spielt nicht
		isPlaying = false;
	}
	
	public function togglePlaying():Void
	{
		// starten / stoppen
		var fcn:String = (isPlaying ? "stopCollection" : "startCollection");
		// aufrufen
		this[fcn]();
	}
}