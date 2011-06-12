import com.adgamewonderland.agw.util.InputUI;
import mx.utils.Delegate;
import com.adgamewonderland.agw.Formprocessor;
import com.adgamewonderland.eplus.basecasting.interfaces.IVotingConnectorListener;
import com.adgamewonderland.eplus.basecasting.connectors.VotingConnector;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.eplus.basecasting.controllers.VideoController;
import com.adgamewonderland.eplus.basecasting.ui.VotingstarUI;
import com.adgamewonderland.eplus.basecasting.util.Tracking;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.VotingUI extends InputUI implements IVotingConnectorListener {

	private static var STATE_INPUT:String = "frInput";

	private static var STATE_SENT:String = "frSent";

	private static var STATE_ERROR:String = "frError";

	private var score:Number = 0;

	private var email_txt:TextField;

	private var send_btn:Button;

	public function VotingUI() {
	}

	public function onLoad():Void
	{
		// als listener bei connector anmelden
		VotingConnector.getInstance().addListener(this);
		// senden button
		send_btn.onRelease = Delegate.create(this, doSend);
		// ausblenden
		send_btn._visible = false;
	}

	public function onUnload():Void
	{
		// als listener bei connector abmelden
		VotingConnector.getInstance().removeListener(this);
	}

	public function doScore(aScore:Number ):Void
	{
		// punktzahl
		this.score = aScore;
		// sterne einfaerben
		var star:VotingstarUI;
		// schleife ueber sterne
		for (var i : String in this) {
			// nur sterne
			if (this[i] instanceof VotingstarUI == false)
				continue;
			// stern gefunden
			star = VotingstarUI(this[i]);
			// einfaerben
			star.setColor(aScore);
		}
		// senden button einblenden
		send_btn._visible = true;

		// tracking
		var contentgroup = "Voting";
		// aufrufen
		Tracking.getInstance().doTrack(contentgroup, contentgroup, "Voting");
	}

	public function onVoteSaved(aSuccess:Boolean):Void
	{
		// weiter je nach erfolg
		if (aSuccess) {
			gotoAndStop(STATE_SENT);
		} else {
			gotoAndStop(STATE_ERROR);
		}

		// tracking
		var contentgroup = "Voting Danke";
		// aufrufen
		Tracking.getInstance().doTrack(contentgroup, contentgroup, "Voting");
	}

	private function doSend():Void
	{
		// fehlermeldung ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// validierung
		var errors:Array = getErrors();
		// testen, ob ohne fehler
		if (errors.length > 0) {
			// fehler anzeigen
			showErrors(errors);
			// nachricht fehlerhafte angaben
			showMessage("Deine Angaben sind nicht korrekt!");
			// abbrechen
			return;
		}
		// textfelder deaktivieren
		setEditable(false);
		// button ausblenden
		send_btn._visible = false;

		// clip, fuer den gestimmt werden soll
		var clip:VotableClip = VideoController.getInstance().getVotableclip();
		// senden
		VotingConnector.getInstance().saveVote(email_txt.text, clip.getID(), this.score);
	}

	private function getErrors():Array
	{
		// sind die attribute alle korrekt befuellt
		var errors:Array = new Array();
		// parameter zur uebergabe an den formprocessor
		var params:Array = new Array();
		params.push(Formprocessor.TYPE_EMAIL, "email", email_txt.text);
		// validieren
		errors = new Formprocessor().checkForm(params);
		// zurueck geben
		return errors;
	}

}