import mx.utils.Delegate;
import com.adgamewonderland.agw.util.InputUI;
import com.adgamewonderland.eplus.basecasting.view.beans.Tellafriend;
import mx.rpc.ResultEvent;
import com.adgamewonderland.eplus.basecasting.ui.TellafriendaniUI;
import com.adgamewonderland.eplus.basecasting.connectors.TellafriendConnector;
import com.adgamewonderland.eplus.basecasting.interfaces.ITellafriendConnectorListener;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.ui.LayerUI;
import com.adgamewonderland.eplus.basecasting.controllers.VideoController;
import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.util.Tracking;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.TellafriendUI extends InputUI implements ITellafriendConnectorListener {

	private var headline_txt:TextField;

	private var line_mc:MovieClip;

	private var copy_txt:TextField;

	private var sendername_txt:TextField;

	private var senderemail_txt:TextField;

	private var receivername_txt:TextField;

	private var receiveremail_txt:TextField;

	private var sendermessage_txt:TextField;

	private var send_btn:Button;

	private var close_btn:Button;

	private var dates_btn:Button;

	private var state:String;

	private var clip:Clip;

	private var city:CityImpl;

	public function TellafriendUI() {
		// headline linksbuendig
		headline_txt.autoSize = "left";
	}

	public function onLoad():Void
	{
		// als listener bei connector anmelden
		TellafriendConnector.getInstance().addListener(this);
		// unterscheidung, was empfohlen werden soll
		this.state = ApplicationController.getInstance().getState();
		// clip, der empfohlen werden soll
		this.clip = VideoController.getInstance().getTellafriendclip();
		// pruefen, ob clip empfohlen werden soll
		if (this.clip == null) {
			// website empfehlen
			if (this.state == ApplicationController.STATE_START)
				this.city = new CityImpl();
			// stadt empfehlen
			if (this.state == ApplicationController.STATE_CITY)
				this.city = CitiesController.getInstance().getCurrentcity();

			// headline
			var headline:String = "Wer ist die Stimme der Stadt?";
			// stadtname in copy
			var cityname:String = this.city.getName() == "" ? "seiner Stadt" : this.city.getName();
			// headline splitten
			var copies:Array = copy_txt.text.split("#");
			// stadtname einfuegen
			var copy:String = copies[0] + cityname + copies[1];
			// anzeigen
			showHead(headline, copy);

			// tracking
			var contentgroup = (this.city.getName() == "" ? "BASE Casting-Tour" : this.city.getName()) + " Weiterempfehlen";
			// aufrufen
			Tracking.getInstance().doTrack(contentgroup, contentgroup, "Weiterempfehlen");

		} else {
			// headline
			var headline:String = "Du möchtest diesen Clip weiterempfehlen?";
			// copy
			var copy:String = "Prima. Trage einfach die folgenden Angaben ein, und los geht's!";
			// anzeigen
			showHead(headline, copy);

			// tracking
			var contentgroup = "Clip Weiterempfehlen";
			// aufrufen
			Tracking.getInstance().doTrack(contentgroup, contentgroup, "Weiterempfehlen");
		}

		// nachricht linksbuendig
		message_txt.autoSize = "left";
		// tabsetter
		var index:Number = 0;
		sendername_txt.tabIndex = ++index;
		senderemail_txt.tabIndex = ++index;
		receivername_txt.tabIndex = ++index;
		receiveremail_txt.tabIndex = ++index;
		sendermessage_txt.tabIndex = ++index;
		Selection.setFocus(sendername_txt);
		// button senden
		send_btn.onRelease = Delegate.create(this, doSend);
		// button schliessen
		close_btn.onRelease = Delegate.create(this, doClose);
	}

	public function onUnload():Void
	{
		// als listener bei connector abmelden
		TellafriendConnector.getInstance().removeListener(this);
	}

	private function doSend():Void
	{
		// tellafriend bean
		var tellafriend:Tellafriend = new Tellafriend();
		// bean befuellen
		tellafriend.setSendername(sendername_txt.text);
		tellafriend.setSenderemail(senderemail_txt.text);
		tellafriend.setReceivername(receivername_txt.text);
		tellafriend.setReceiveremail(receiveremail_txt.text);
		tellafriend.setMessage(sendermessage_txt.text);
		// fehlermeldung ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// validierung
		var errors:Array = tellafriend.getErrors();
		// testen, ob ohne fehler
		if (errors.length > 0) {
			// fehler anzeigen
			showErrors(errors);
			// nachricht fehlerhafte angaben
			showMessage("Deine Angaben sind nicht korrekt!");
			// abbrechen
			return;
		}
		// fehlermeldung ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// textfelder deaktivieren
		setEditable(false);
		// button ausblenden
		send_btn._visible = false;

		// pruefen, ob clip empfohlen werden soll
		if (this.clip == null) {
			// website empfehlen
			if (this.state == ApplicationController.STATE_START)
				TellafriendConnector.getInstance().recommendWebsite(tellafriend);
			// stadt empfehlen
			if (this.state == ApplicationController.STATE_CITY)
				TellafriendConnector.getInstance().recommendCity(tellafriend, this.city.getID());

		} else {
			// clip empfehlen
			TellafriendConnector.getInstance().recommendClip(tellafriend, this.clip.getID());
		}
	}

	public function onTellafriendSent(success:Boolean ):Void
	{
		// je nach erfolg
		if (success) {
			// abspielen
			gotoAndStop("frSent");
			// pruefen, ob clip empfohlen werden soll
			if (this.clip == null) {
				// headline
				var headline:String = "Deine Stimme wird erhört!";
				// copy
				var copy:String = "Danke, dass du die BASE Casting Tour weiterempfohlen hast. Und wann nimmst du teil?";
				// anzeigen
				showHead(headline, copy);

				// tracking
				var contentgroup = (this.city.getName() == "" ? "BASE Casting-Tour" : this.city.getName()) + " Weiterempfehlen Danke";
				// aufrufen
				Tracking.getInstance().doTrack(contentgroup, contentgroup, "Weiterempfehlen");

			} else {
				// headline
				var headline:String = "Vielen Dank ...";
				// copy
				var copy:String = "... dass du diesen Clip weiterempfohlen hast. Hast du eigentlich selbst schon deine Stimme abgegeben?";
				// anzeigen
				showHead(headline, copy);

				// tracking
				var contentgroup = "Clip Weiterempfehlen Danke";
				// aufrufen
				Tracking.getInstance().doTrack(contentgroup, contentgroup, "Weiterempfehlen");
			}
			// button daten
			dates_btn.onRelease = Delegate.create(this, doClose);

		} else {
			// nachricht anzeigen
			showMessage("Es ist ein Fehler aufgetreten. Bitte versuche es später noch einmal.");
		}
	}

	private function showHead(aHeadline:String, aCopy:String ):Void
	{
		// headline
		headline_txt.text = aHeadline;
		// unterstrich
		line_mc._width = headline_txt._width;
		// copy
		copy_txt.text = aCopy;
	}

	private function doClose():Void
	{
		// keinen clip empfehlen
		VideoController.getInstance().setTellafriendclip(null);
		// schliessen
		LayerUI(_parent).hideLayer();
	}

}