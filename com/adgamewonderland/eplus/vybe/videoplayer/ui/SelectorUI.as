import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoassetsController;
import mx.transitions.Tween;
import mx.utils.Delegate;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
import flash.geom.Point;
import flash.geom.Rectangle;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.ui.SelectorUI extends MovieClip {

	private var _category:String;

	private var category:String;

	private var minitvlist:MinitvlistImpl;

	private var bounds:Rectangle;

	private var comingsoon_mc:MovieClip;

	private var category_txt:TextField;

	public function SelectorUI() {
		// category
		this.category = _category;
		// minitvlist
		this.minitvlist = VideoassetsController.getInstance().getVideoassets().getMinitvlistByCategory(_category);
		// name und anzahl
		category_txt.text = this.minitvlist.getName() + " (" + this.minitvlist.getAssetsCount() + ")";
		// mauszeiger nur wenn liste nicht leer
		useHandCursor = (this.minitvlist.getAssetsCount() > 0);
		// umrandung
		this.bounds = new Rectangle(0, 0, _width, _height);
		// nachricht ausblenden
		comingsoon_mc._visible = false;
		// deaktivieren
		enabled = false;
	}

	public function onEnterFrame():Void
	{
		// testen, ob liste leer
		if (this.minitvlist.getAssetsCount() == 0) {
			// mausposition
			var mousepos:Point = new Point(_xmouse,_ymouse);
			// testen, ob maus innerhalb
			if (this.bounds.containsPoint(mousepos)) {
				// nachricht einblenden
				comingsoon_mc._visible = true;
				// nachricht positionieren
				comingsoon_mc._x = mousepos.x;
				comingsoon_mc._y = mousepos.y;

			} else {
				// nachricht ausblenden
				comingsoon_mc._visible = false;
			}
		}
	}

	public function onRelease():Void
	{
		// kategorie auswaehlen
		if (this.minitvlist.getAssetsCount() > 0)
			VideoassetsController.getInstance().selectMinitvlist(getCategory());
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

	public function getCategory():String
	{
		return this.category;
	}

}