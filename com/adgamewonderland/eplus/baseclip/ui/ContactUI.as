import mx.utils.Delegate;

import com.adgamewonderland.agw.interfaces.IRadiobuttonListener;
import com.adgamewonderland.agw.util.RadiobuttonUI;
import com.adgamewonderland.eplus.baseclip.beans.Contact;
import com.adgamewonderland.eplus.baseclip.connectors.Phase1Connector;
import com.adgamewonderland.eplus.baseclip.controllers.ContactController;
import com.adgamewonderland.eplus.baseclip.ui.InputUI;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.ContactUI extends InputUI implements IRadiobuttonListener {

	private var contact:Contact;

	private var salutation1_mc:RadiobuttonUI;

	private var salutation2_mc:RadiobuttonUI;

	private var firstname_txt:TextField;

	private var lastname_txt:TextField;

	private var mobile_txt:TextField;

	private var email_txt:TextField;

	private var sendermessage_txt:TextField;

	private var send_btn:Button;

	public function ContactUI() {
		// user, der teilnehmen moechte
		this.contact = new Contact();
	}

	public function getContact():Contact
	{
		return this.contact;
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
		// tabsetter
		var index:Number = 0;
		firstname_txt.tabIndex = ++index;
		lastname_txt.tabIndex = ++index;
		mobile_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		sendermessage_txt.tabIndex = ++index;
		Selection.setFocus(mobile_txt);
		// button senden
		send_btn.onRelease = Delegate.create(this, doSend);
		// als ui beim controller registrieren
		ContactController.getInstance().addUI(this, ContactController.STATUS_CONTACT);
	}

	private function doSend():Void
	{
		// bean befuellen
		if (salutation1_mc.status) this.contact.setSalutation(Contact.SALUTATION_MALE);
		if (salutation2_mc.status) this.contact.setSalutation(Contact.SALUTATION_FEMALE);
		this.contact.setFirstname(firstname_txt.text);
		this.contact.setLastname(lastname_txt.text);
		this.contact.setMobile(mobile_txt.text);
		this.contact.setEmail(email_txt.text);
		this.contact.setMessage(sendermessage_txt.text);
		// validierung
		var errors:Array = this.contact.getErrors();
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
		Phase1Connector.sendContact(this.contact, this, onContactSent);
	}

	private function onContactSent(receiver:LoadVars ):Void
	{
		// status
		var status:Number = Number(receiver["status"]);
		// datei-upload starten
		if (status == 1) {
			// controller informieren
			ContactController.getInstance().onFinishStatus(ContactController.STATUS_CONTACT);

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
		// als ui beim controller deregistrieren
		ContactController.getInstance().removeUI(this, ContactController.STATUS_CONTACT);
	}

}