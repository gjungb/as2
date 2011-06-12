import mx.transitions.Tween;
import mx.utils.Delegate;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.SelectorUI extends MovieClip {

	function SelectorUI() {
	}

	/**
	 * reinfahren
	 * @param delay verzoegerung [ms] bis zum start des tweens
	 * @param func function des tweens @see mx.transitions.easing.*
	 * @param duration dauer des tweens [s]
	 */
	public function tweenInSelector(delay:Number, func:Function, duration:Number ):Void
	{
		// interval
		var interval:Number;
		// nach pause reinfahren
		var doTween:Function = function(func:Function, mc:SelectorUI, duration:Number ):Void {
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
	public function tweenOutSelector(func:Function, delay:Number, duration:Number ):Void
	{
		// deaktivieren
		toggleState();
		// interval
		var interval:Number;
		// nach pause reinfahren
		var doTween:Function = function(func:Function, mc:SelectorUI, duration:Number ):Void {
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
		var begin:Number = _x;
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
		var prop:String = "_alpha";
		// startwert
		var begin:Number = _alpha;
		// endwert
		var finish:Number = 0;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// callback am ende
		tween.onMotionFinished = Delegate.create(this, removeMovieClip);
	}

}