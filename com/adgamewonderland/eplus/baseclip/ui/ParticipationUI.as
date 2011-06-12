import mx.utils.Delegate;

import com.adgamewonderland.agw.interfaces.IRadiobuttonListener;
import com.adgamewonderland.agw.util.CheckboxUI;
import com.adgamewonderland.agw.util.RadiobuttonUI;
import com.adgamewonderland.eplus.baseclip.beans.Participant;
import com.adgamewonderland.eplus.baseclip.connectors.Phase1Connector;
import com.adgamewonderland.eplus.baseclip.controllers.ParticipationController;
import com.adgamewonderland.eplus.baseclip.ui.InputUI;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.ParticipationUI extends InputUI implements IRadiobuttonListener {

	private var participant:Participant;

	private var salutation1_mc:RadiobuttonUI;

	private var salutation2_mc:RadiobuttonUI;

	private var firstname_txt:TextField;

	private var lastname_txt:TextField;

	private var street_txt:TextField;

	private var postcode_txt:TextField;

	private var city_txt:TextField;

	private var birthday_day_txt:TextField;

	private var birthday_month_txt:TextField;

	private var birthday_year_txt:TextField;

	private var mobile_txt:TextField;

	private var email_txt:TextField;

	private var nickname_txt:TextField;

	private var optin1_mc:CheckboxUI;

	private var optin2_mc:CheckboxUI;

	private var send_btn:Button;

	public function ParticipationUI() {
		// user, der teilnehmen moechte
		this.participant = new Participant();
	}

	public function getParticipant():Participant
	{
		return this.participant;
	}

	public function onRadiobuttonChecked(mc:RadiobuttonUI, status:Boolean ):Void
	{
		// je nach radiobutton
		switch (mc) {
			case salutation1_mc :
				salutation2_mc.status = false;
				break;
			case salutation2_mc :
				salutation1_mc.status = false;
				break;
		}
	}

	private function onLoad():Void
	{
		// ausblenden
		_visible = false;
		// zahlenfelder
		postcode_txt.restrict = "0-9";
		birthday_day_txt.restrict = "0-9";
		birthday_month_txt.restrict = "0-9";
		birthday_year_txt.restrict = "0-9";
		// tabsetter
		var index:Number = 0;
		firstname_txt.tabIndex = ++index;
		lastname_txt.tabIndex = ++index;
		street_txt.tabIndex = ++index;
		postcode_txt.tabIndex = ++index;
		city_txt.tabIndex = ++index;
		birthday_day_txt.tabIndex = ++index;
		birthday_month_txt.tabIndex = ++index;
		birthday_year_txt.tabIndex = ++index;
		mobile_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		nickname_txt.tabIndex = ++index;
		Selection.setFocus(firstname_txt);
		// button senden
		send_btn.onRelease = Delegate.create(this, doSend);
		// als listener bei radiobuttons registrieren
		salutation1_mc.addListener(this);
		salutation2_mc.addListener(this);
		// salutation vorauswaehlen
		salutation1_mc.status = true;
		// als ui beim controller registrieren
		ParticipationController.getInstance().addUI(this, ParticipationController.STATUS_PARTICIPATION);
	}

	private function doSend():Void
	{
		// bean befuellen
		if (salutation1_mc.status) this.participant.setSalutation(Participant.SALUTATION_MALE);
		if (salutation2_mc.status) this.participant.setSalutation(Participant.SALUTATION_FEMALE);
		this.participant.setFirstname(firstname_txt.text);
		this.participant.setLastname(lastname_txt.text);
		this.participant.setStreet(street_txt.text);
		this.participant.setPostcode(postcode_txt.text);
		this.participant.setCity(city_txt.text);
		this.participant.setBirthday(new Date(Number(birthday_year_txt.text), Number(birthday_month_txt.text) - 1, Number(birthday_day_txt.text)));
		this.participant.setMobile(mobile_txt.text);
		this.participant.setEmail(email_txt.text);
		this.participant.setNickname(nickname_txt.text);
		this.participant.setOptin1(optin1_mc.status);
		this.participant.setOptin2(optin2_mc.status);
		// validierung
		var errors:Array = this.participant.getErrors();
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
		// senden
		Phase1Connector.sendParticipation(this.participant, this, onParticipantSent);
	}

	private function onParticipantSent(receiver:LoadVars ):Void
	{
		// status
		var status:Number = Number(receiver["status"]);
		// datei-upload starten
		if (status == 1) {
			// TODO: blind button / vorhang einblenden

			// controller informieren
			ParticipationController.getInstance().onFinishStatus(ParticipationController.STATUS_PARTICIPATION);

		} else {
			// textfelder aktivieren
			setEditable(true);
			// button einblenden
			send_btn._visible = true;
			// fehlermeldung anzeigen
			showMessage("Es ist ein Fehler aufgetreten!");
		}
	}

	private function onUnload():Void
	{
		// als listener bei radiobuttons deregistrieren
		salutation1_mc.removeListener(this);
		salutation2_mc.removeListener(this);
		// als ui beim controller deregistrieren
		ParticipationController.getInstance().removeUI(this, ParticipationController.STATUS_PARTICIPATION);
	}

}