import mx.transitions.easing.Strong;
import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.NavigationUI;
import flash.geom.Point;
import com.adgamewonderland.eplus.basecasting.ui.LayerUI;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.PricesUI extends LayerUI implements IApplicationControllerListener {

	private static var STARTYPOS_BUTTON:Number = 335;

	private static var CITYYPOS_BUTTON:Number = 335;

	private static var STARTPOS_BUBBLE:Point = new Point(706, 156);

	private static var CITYPOS_BUBBLE:Point = new Point(813, 170);

	private var bubble_btn:Button;

	function PricesUI() {
	}

	public function onLoad():Void
	{
		super.onLoad();
		// gewinne bubble
		bubble_btn.onRelease = Delegate.create(this, showLayer);
	}

	public function onStateChangeInited(aState:String, aNewstate:String):Void
	{
	}

	public function onStateChanged(aState:String, aNewstate:String ):Void
	{
		super.onStateChanged(aState, aNewstate);
		// je nach neuem state
		switch (aNewstate) {
			// startseite
			case ApplicationController.STATE_START :
				// button nach pause anzeigen
				showButton(STARTYPOS_BUTTON, NavigationUI.TWEENDURATION * 1000 + CitiesController.getInstance().getCities().getLength() * NavigationUI.TWEENDELAY);
				// bubble anzeigen
				showBubble(STARTPOS_BUBBLE);

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// button ohne pause anzeigen
				showButton(CITYYPOS_BUTTON, 0);
				// bubble anzeigen
				showBubble(CITYPOS_BUBBLE);

				break;
		}
	}

	private function showButton(aYpos:Number, aDelay:Number ):Void
	{
		// button positionieren
		show_btn._y = aYpos;
		// nach pause einblenden
		var interval:Number;
		var doShow:Function = function(mc:MovieClip ):Void  {
			// interval loeschen
			clearInterval(interval);
			// einblenden
			mc._visible = true;
			// was soll gewteent werden
			var prop:String = "_alpha";
			// startwert
			var begin:Number = 0;
			// endwert
			var finish:Number = 100;
			// neuer tween
			var tween:Tween = new Tween(mc, prop, Strong.easeOut, begin, finish, NavigationUI.TWEENDURATION, true);
		};
		interval = setInterval(doShow, aDelay, show_btn);
	}

	private function showBubble(aPos:Point ):Void
	{
		// bubble positionieren
		bubble_btn._x = aPos.x;
		bubble_btn._y = aPos.y;
	}

}