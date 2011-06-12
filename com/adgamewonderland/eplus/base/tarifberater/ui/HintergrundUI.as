import mx.transitions.Tween;

import com.adgamewonderland.eplus.base.tarifberater.ui.RahmenUI;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.ui.HintergrundUI extends MovieClip {

	private var _ysize : Number;

	private var oben_mc : RahmenUI;

	private var mitte_mc : RahmenUI;

	private var unten_mc : RahmenUI;

	public function HintergrundUI() {
	}

	public function onLoad() : Void {
		// hoehe
		setYsize(_ysize);
	}

	/**
	 * Ändert die Höhe des Rahmens
	 * @param aYsize
	 */
	public function setYsize(aYsize : Number ) : Void {
		// abbrechen, wenn leer
		if (aYsize == null)
			return;
		// mitte skalieren
		var h1 : Number = aYsize - oben_mc._height - unten_mc._height;
		// skalieren
		mitte_mc._height = h1;
		// unten verschieben
		var p1 : Number = aYsize - unten_mc._height;
		// verschieben
		unten_mc._y = p1;
	}		public function getYsize() : Number {
		return (unten_mc._y + unten_mc._height);
	}

	/**
	 * Ändert die Größe des Rahmens mittels Tweening
	 * @param aStart Starthöhe
	 * @param aEnd Endhöhe
	 * @param aDuration Dauer in s
	 */
	public function doTween(aStart : Number, aEnd : Number, aFunction : Function, aDuration : Number ) : Void {
		//		trace("HintergrundUI >>> doTween: " + this + " # " + aStart + " # " + aEnd);
		// mitte skalieren
		var h1 : Number = aStart - oben_mc._height - unten_mc._height;
		var h2 : Number = aEnd - oben_mc._height - unten_mc._height;
		// tween fur hoehe
		var t1 : Tween = new Tween(mitte_mc, "_height", aFunction, h1, h2, aDuration, true);
		// start melden
		mitte_mc.onTweenStarted();
		// callback am ende
		t1.onMotionFinished = function():Void {
			mitte_mc.onTweenFinished();
		};
		
		// unten verschieben
		var p1 : Number = aStart - unten_mc._height;
		var p2 : Number = aEnd - unten_mc._height;
		// tween fur y-position
		var t2 : Tween = new Tween(unten_mc, "_y", aFunction, p1, p2, aDuration, true);
		// start melden
		unten_mc.onTweenStarted();
		// callback am ende
		t2.onMotionFinished = function():Void {
			unten_mc.onTweenFinished();
		};
	}
}