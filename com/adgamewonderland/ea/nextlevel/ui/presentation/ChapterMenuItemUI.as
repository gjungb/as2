import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.ea.nextlevel.interfaces.IChapterMenuListener;
import com.adgamewonderland.ea.nextlevel.util.TextScrambler;
/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuItemUI extends MovieClip {

	private var _listener:IChapterMenuListener;

	private var _index:Number;

	private var _indexpos:Number;

	private var _title:String;

	private var _titlepos:Number;

	private var _titlewidth:Number;

	private var _showback:Boolean;

	private var _scale:Number;

	private var index_txt:TextField;

	private var title_txt:TextField;

	private var back_mc:MovieClip;

	public function ChapterMenuItemUI() {
		// index linksbuendig
		index_txt.autoSize = "left";
		// eins addieren
		var showindex:Number = _index + 1;
		// index anzeigen
		index_txt.text = (showindex < 10 ? "0" : "") + showindex + ".";
		// index positionieren
		if (_indexpos != undefined) index_txt._x = _indexpos;

		// textscrambler fuer title
		var ts:TextScrambler = new TextScrambler(title_txt, _title);
		// title anzeigen
		ts.showScrambledText();
		// title positionieren
		if (_titlepos != undefined) title_txt._x = _titlepos;
		// title breite
		if (_titlewidth != undefined) title_txt._width = _titlewidth;

		// hintergrund ein- / ausblenden
		back_mc._alpha = _showback ? 100 : 0;

		// komplett skalieren
		if (_scale != undefined) _xscale = _yscale = _scale;

		// deaktivieren
		enabled = false;
	}

	public function onRelease():Void
	{
		// listener informieren
		_listener.onChapterMenuItemSelected(_index);
	}

	/**
	 * reinfahren
	 * @param delay verzoegerung [ms] bis zum start des tweens
	 * @param func function des tweens @see mx.transitions.easing.*
	 * @param duration dauer des tweens [s]
	 */
	public function tweenInMenuitem(delay:Number, func:Function, duration:Number ):Void
	{
		// interval
		var interval:Number;
		// nach pause reinfahren
		var doTween:Function = function(func:Function, mc:ChapterMenuItemUI, duration:Number ):Void {
			// reinfahren
			mc.tweenIn(func, mc, duration);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause reinfahren
		interval = setInterval(doTween, delay, func, this, duration);
	}

	/**
	 * rausfahren
	 * @param func function des tweens @see mx.transitions.easing.*
	 * @param delay verzoegerung [ms] bis zum start des tweens
	 * @param duration dauer des tweens [s]
	 */
	public function tweenOutMenuitem(func:Function, delay:Number, duration:Number ):Void
	{
		// deaktivieren
		toggleState();
		// interval
		var interval:Number;
		// nach pause reinfahren
		var doTween:Function = function(func:Function, mc:ChapterMenuItemUI, duration:Number ):Void {
			// rausfahren
			mc.tweenOut(func, mc, duration);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause rausfahren
		interval = setInterval(doTween, delay, func, this, duration);
	}

	/**
	 * schaltet den status nach erfolgtem tween um
	 */
	public function toggleState():Void
	{
		// de- / aktivieren
		enabled = !enabled;
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
		var prop:String = "_x";
		// startwert
		var begin:Number = mc._x;
		// endwert
		var finish:Number = 0;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		tween.onMotionFinished = Delegate.create(this, toggleState);
	}

	/**
	 * ein movieclip rausfahren
	 * (hier bitte parameter anpassen)
	 * @param func
	 * @param mc
	 * @param index
	 */
	private function tweenOut(func:Function, mc:MovieClip, duration:Number ):Void
	{
		// was soll gewteent werden
		var prop:String = "_x";
		// startwert
		var begin:Number = mc._x;
		// endwert
		var finish:Number = mc._x - mc._width;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		tween.onMotionFinished = Delegate.create(this, removeMovieClip);
	}

}