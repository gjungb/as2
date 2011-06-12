/* Depthchecker
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Depthchecker
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		16.06.2004
zuletzt bearbeitet:	16.06.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.Depthchecker {

	// Attributes
	
	private var myDepth:Object;
	
	private var myUsed:Array;
	
	// Operations
	
	public  function Depthchecker(min:Number , max:Number )
	{
		// minimal und maximal gewuenschte depth
		myDepth = {min : min, max : max, act : min};
		// uebersicht ueber depth, die in verwendung sind
		myUsed = [];
		// alle depths erst mal frei
		for (var i:Number = min; i <= max; i ++) {
			// nicht in verwendung
			myUsed[i] = false;
		}
	}
	
	public  function getFreeDepth():Number
	{
		// freien index nach oben suchen
		var index:Number = getFreeIndex(myDepth.act, myDepth.max);
		// keiner gefunden
		if (index == -1) {
			// nach unten suchen
			index = getFreeIndex(myDepth.min, myDepth.act);
		}
		// immer noch keiner gefunden
		if (index == -1) {
			// was nun?
			trace("getFreeDepth gescheitert");
			// abbrechen
			return (null);
		}
		// aktuelle merken
		myDepth.act = index;
		// in verwendung
		myUsed[myDepth.act] = true;
		// zurueck geben
		return (myDepth.act);
	}
	
	private function getFreeIndex(min:Number, max:Number ):Number
	{
		// gesuchter index (-1 bedeutet keiner gefunden)
		var index:Number = -1;
		// schleife
		for (var i:Number = min; i <= max; i ++) {
			// testen, ob aktuelle frei ist
			if (myUsed[i] == false) index = i;
		}
		// zurueck geben
		return (index);
	}
	
	public function setDepthFree(depth:Number ):Void
	{
		// nicht mehr in verwendung
		myUsed[depth] = false;
	}

} /* end class Depthchecker */
