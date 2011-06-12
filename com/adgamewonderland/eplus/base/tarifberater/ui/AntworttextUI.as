
/**
 * @author gerd
 */
import mx.transitions.Tween;
import mx.transitions.easing.None;

import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;

class com.adgamewonderland.eplus.base.tarifberater.ui.AntworttextUI extends MovieClip {

	private var antwort_txt : TextField;

	public function AntworttextUI() {
		// ausblenden
		this._alpha = 0;
	}

	/**
	 * Zeigt den Text zu der übergebenen Antwort an
	 * @param aAntwort Antwort
	 */
	public function zeigeText(aAntwort : Antwort ) : Void {
		// hinspringen
//		this.gotoAndPlay(aAntwort.getName());
		// anzeigen
		this.antwort_txt.text = aAntwort.getText();
		// einblenden
		tweenIn(None.easeIn, this, 5);
	}

	/**
	 * ein movieclip reinfahren
	 * (hier bitte parameter anpassen)
	 * @param func
	 * @param mc
	 * @param index
	 */
	private function tweenIn(func:Function, mc:MovieClip, duration:Number ):Void
	{
		// was soll gewteent werden
		var prop:String = "_alpha";
		// startwert
		var begin:Number = _alpha;
		// endwert
		var finish:Number = 100;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, false);
	}
}