import mx.utils.Collection;

import com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl;
import com.adgamewonderland.eplus.basecasting.connectors.ClipConnector;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.controllers.TweenController;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.interfaces.IClipConnectorListener;
import com.adgamewonderland.eplus.basecasting.interfaces.ITweenable;
import com.adgamewonderland.eplus.basecasting.ui.TweenControllerUI;
import com.adgamewonderland.eplus.basecasting.ui.VideoplayerUI;

import flash.geom.Point;
import mx.utils.Delegate;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.VideoplayerStartUI extends VideoplayerUI implements IApplicationControllerListener, ITweenable {

	private var _cityId;

	private var tweencontroller_mc:TweenControllerUI;

	public function VideoplayerStartUI() {
		super();
	}

	public function onLoad():Void
	{
		super.onLoad();
		// als tweenable registrieren
		TweenController.getInstance().addTweenable(this);
		// controller nur bei groesstem player einblenden
		tweencontroller_mc._visible = (getScale() > 90);
//		// verlinkung zur stadt
//		this.player.onRelease = Delegate.create(this, doRelease);
//		this.countdown_mc.onRelease = Delegate.create(this, doRelease);
	}

	public function getPosition():Point
	{
		return new Point(_x, _y);
	}

	public function getScale():Number
	{
		return _xscale;
	}

	public function onTweenStarted():Void
	{
		// stoppen
		if (this.player.playing)
			this.player.stop();
		// controller deaktivieren
		tweencontroller_mc.setActive(false);
		// controller ausblenden
		tweencontroller_mc._visible = false;
		// tweenen verfolgen
		onEnterFrame = onTweening;
	}

	public function onTweening():Void
	{
		// depth aktualisieren lassen
		TweenController.getInstance().updateDepth(this);
	}

	public function onTweenFinished():Void
	{
		// skalierung aufrunden
		_xscale = _yscale = Math.ceil(getScale());
		// controller aktivieren
		tweencontroller_mc.setActive(true);
		// controller nur bei groesstem player einblenden
		tweencontroller_mc._visible = (getScale() > 90);
		// tweenen verfolgen beenden
		delete (onEnterFrame);
	}

	public function onStateChangeInited(aState:String, aNewstate:String ):Void
	{
	}

	public function onStateChanged(aState:String, aNewstate:String ):Void
	{
		// je nach neuem state
		switch (aNewstate) {
			// startseite
			case ApplicationController.STATE_START :
				// stadt
				this.city = CitiesController.getInstance().getCity(_cityId);
				// pruefen, ob es schon aktive castings fuer diese stadt gibt
				if (getCity().hasActiveCastings()) {
					// countdown ausblenden
					hideCountdown();
					// als listener registrieren
					ClipConnector.getInstance().addListener(this);
					// topclip laden
					ClipConnector.getInstance().loadTopclip(_cityId);

				} else {
					// countdown anzeigen
					showCountdown();
				}

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// als listener deregistrieren
				ClipConnector.getInstance().removeListener(this);
				// video resetten
				resetVideo();

				break;
		}

		super.onStateChanged(aState, aNewstate);
	}

	private function doRelease():Void
	{
		// stadt auswaehlen
		ApplicationController.getInstance().selectCity(this.city);
	}

}