import com.adgamewonderland.eplus.baseclip.interfaces.ITweener;
import mx.transitions.easing.Strong;
import mx.transitions.Tween;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.util.TweenHelper implements ITweener {

	public function tweenIn(mc : MovieClip) : Void
	{
		// einblenden
		mc._visible = true;
		// was soll gewteent werden
		var prop:String = "_alpha";
		// wie soll gewteent werden
		var func:Function = Strong.easeOut;
		// startwert
		var begin:Number = 0;
		// endwert
		var finish:Number = 100;
		// dauer [s]
		var duration:Number = 2;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
	}

	public function tweenOut(mc : MovieClip) : Void
	{
		// was soll gewteent werden
		var prop:String = "_alpha";
		// wie soll gewteent werden
		var func:Function = Strong.easeIn;
		// startwert
		var begin:Number = 100;
		// endwert
		var finish:Number = 0;
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
		// nach tween ausblenden
		tween.onMotionFinished = function():Void {
			mc._visible = false;
		};
	}

}