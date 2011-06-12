/* Mask
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Mask
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			ksta
erstellung: 		15.09.2004
zuletzt bearbeitet:	16.09.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.ksta.photoclick.*

class com.adgamewonderland.ksta.photoclick.Mask extends MovieClip {

	// Attributes
	
	private var _myPos:Object; // position (x, y)
	
	private var _myDims:Object; // dimensionen (width, height)
	
	private var _mySegments:Object; // gewuenschte segemente (x, y, variance)
	
	private var myRectangle:Rectangle; // rechteck mit maskensegmenten
	
	private var mySegments:Array; // maskensegmente (movieclips)
	
	private var myNumSegments:Object; // anzahl der segmente beim aufdecken (act, max);
	
	private var keyListener:Object;
	
	private var pieces_mc:MovieClip, sponsor_mc:MovieClip;
	
	// Operations
	
	// maske zum maskieren des sponsoren-logo
	public  function Mask()
	{
		// rechteck mit maskensegementen
		myRectangle = new Rectangle(_myPos.x, _myPos.y, _myDims.width, _myDims.height);
		// maskensegmente (movieclips)
		mySegments = [];
		// anzahl der segmente beim aufdecken
		myNumSegments = {act : 0, max : 0};
	}
	
	// maske initialisieren
	public function initMask():Void
	{
		// rechteck mit maskensegementen
		myRectangle = new Rectangle(_myPos.x, _myPos.y, _myDims.width, _myDims.height);
		// rechteck segmentieren
		myRectangle.segmentRectangle(_mySegments.x, _mySegments.y, _mySegments.variance);
		// maskensegmente (movieclips)
		mySegments = myRectangle.buildSegments(pieces_mc, "piece");
		// sponsoren-logo maskieren
		sponsor_mc.setMask(pieces_mc);
		// anzahl der segmente beim aufdecken
		myNumSegments = {act : mySegments.length, max : mySegments.length};
	}
	
	// maske resetten
	public function resetMask():Void
	{
		// maskierung aufheben
		sponsor_mc.setMask(null);
		// maskensegmente loeschen
		for (var i:String in mySegments) mySegments[i].removeMovieClip();
		// rechteck mit maskensegmenten loeschen
		delete (myRectangle);
	}
	
	// eins der segemente zufaellig loeschen
	public function clearSegment()
	{
		// abbrechen, wenn kein segement uebrig
		if (myNumSegments.act <= 0) return (false);
		// verbleibendes segement suchen
		do {
			// eines der segemente
			var num = Math.floor(Math.random()*mySegments.length);
			// bis eins gefunden
		} while (mySegments[num] instanceof MovieClip == false);
		// loeschen
		mySegments[num].removeMovieClip();
		// zurueck geben, wie viele noch uebrig
		return (--myNumSegments.act);
	}
	
	// anzahl der segemente zurueck geben
	public function getNumSegments():Number
	{
		// zurueck geben
		return (myNumSegments.max);
	}
	
} /* end class Mask */
