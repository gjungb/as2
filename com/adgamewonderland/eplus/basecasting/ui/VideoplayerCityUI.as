import com.adgamewonderland.eplus.basecasting.ui.VideoplayerUI;
import com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.controllers.VideoController;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.eplus.basecasting.connectors.ClipConnector;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.VideoplayerCityUI extends VideoplayerUI implements IApplicationControllerListener {

	public function VideoplayerCityUI() {
		super();
	}

	public function onLoad():Void
	{
		super.onLoad();
		// als listener registrieren
		VideoController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		super.onUnload();
		// als listener deregistrieren
		VideoController.getInstance().removeListener(this);
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
				// als listener deregistrieren
				ClipConnector.getInstance().removeListener(this);
				// video resetten
				resetVideo();

				break;
			// cityseite
			case ApplicationController.STATE_CITY :
				// stadt
				this.city = CitiesController.getInstance().getCurrentcity();
				// pruefen, ob es schon aktive castings fuer diese stadt gibt
				if (getCity().hasActiveCastings()) {
					// countdown ausblenden
					hideCountdown();
					// als listener registrieren
					ClipConnector.getInstance().addListener(this);
					// pruefen, ob ein bestimmer clip angezeigt werden soll
					if (ApplicationController.getInstance().getClipid() != null) {
						// clip laden
						ClipConnector.getInstance().loadClip(ApplicationController.getInstance().getClipid());
						// nur einmal
						ApplicationController.getInstance().setClipid(null);

					} else {
						// topclip laden
						ClipConnector.getInstance().loadTopclip(this.city.getID());
					}

				} else {
					// countdown anzeigen
					showCountdown();
				}

				break;
		}

		super.onStateChanged(aState, aNewstate);
	}

}