/* Previewnavi
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Previewnavi
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		04.05.2004
zuletzt bearbeitet:	04.05.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.eplus.soccer.microsite.Previewnavi extends MovieClip{

	// Attributes
	
	private var _myTarget:String, myTarget:MovieClip;
	
	private var _myXRight:Number, myXdiff:Number = 20;
	
	private var myButtons:Array;
	
	private var bu_mc:MovieClip;
	
	// Operations
	
	public  function Previewnavi()
	{
		// movieclip, das gesteuert werden soll
		myTarget = _parent[_myTarget];
		// anzahl der frames => anzahl der buttons
		var frames:Number = myTarget._totalframes;
		// buttons auf buehne
		for (var i:Number = 1; i <= frames; i ++) {
			// dummy duplizieren
			var mc:MovieClip = bu_mc.duplicateMovieClip("bu" + i + "_mc", i, {myNum : i});
			// x-position
			mc._x = bu_mc._x + (i - 1) * myXdiff;
			// callback
			mc.onRelease = function () {
				// nummer uebergeben
				this._parent.swapPreview(this.myNum);
			}
		}
		// dummy loeschen
		bu_mc.unloadMovie();
		// ausrichten
		this._x = myTarget._x + (myTarget._width - this._width) - _myXRight;
	}
	
	public  function swapPreview(num:Number)
	{
		// zu uebergebenem frame springen lassen
		myTarget.gotoAndStop(num);
	}

} /* end class Previewnavi */
