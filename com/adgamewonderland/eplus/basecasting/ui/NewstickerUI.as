import mx.transitions.easing.None;
import mx.transitions.Tween;
import mx.utils.Delegate;
import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.NewstickerUI extends MovieClip implements IApplicationControllerListener {

	private var WIDTH:Number = 846;

	private var DIGITSPERSECOND:Number = 10;

	private var news:String;

	private var news_mc:MovieClip;

	private var news_txt:TextField;

	private var mask_txt:MovieClip;

	private var mask_mc:MovieClip;

	function NewstickerUI() {
		// textfeld fuer ticker
		news_txt = news_mc.news_txt;
		// textfeld linksbuendig
		news_txt.autoSize = "left";
	}

	public function onLoad():Void
	{
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);
	}

	public function showNews(aNews:String ):Void
	{
		// text doppelt in textfeld
		news_txt.text = aNews + aNews;
		// maske loeschen
		mask_mc.removeMovieClip();
		// maske fuer ticker
		var mask:Mask = new Mask(this, news_mc, new com.adgamewonderland.agw.math.Rectangle(news_mc._x, news_mc._y, WIDTH, news_txt._height));
		// maskieren
		mask.drawMask();
		// ticker resetten und starten
		doReset();
	}

	public function onStateChanged(aState:String, aNewstate:String):Void
	{
		// je nach neuem state
		switch (aNewstate) {
			// startseite
			case ApplicationController.STATE_START :
				// alle castings (mit stadtnamen)
				showNews(CitiesController.getInstance().getCitiesTicker(true));

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// castings einer stadt (ohne stadtnamen)
				showNews(CitiesController.getInstance().getCityTicker(false));

				break;
		}
	}

	public function onStateChangeInited(aState : String, aNewstate : String) : Void {
	}

	/**
	 * schaltet den status nach erfolgtem tween um
	 */
	public function doReset():Void
	{
		// zurueck zum start
		news_txt._x = 0;
		// tweenen
		tweenIn(None.easeNone, news_txt, news_txt.text.length / DIGITSPERSECOND);
	}

	/**
	 * ein movieclip reinfahren
	 * (hier bitte parameter anpassen)
	 * @param func
	 * @param txt
	 * @param index
	 */
	private function tweenIn(func:Function, txt:TextField, duration:Number ):Void
	{
		// was soll gewteent werden
		var prop:String = "_x";
		// startwert
		var begin:Number = txt._x;
		// endwert
		var finish:Number = txt._x - txt._width / 2;
		// neuer tween
		var tween:Tween = new Tween(txt, prop, func, begin, finish, duration, true);
		// callback am ende
		tween.onMotionFinished = Delegate.create(this, doReset);
	}

}