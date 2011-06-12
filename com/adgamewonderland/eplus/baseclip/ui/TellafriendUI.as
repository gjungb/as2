import mx.utils.Delegate;

import com.adgamewonderland.agw.util.CheckboxUI;
import com.adgamewonderland.eplus.baseclip.beans.Tellafriend;
import com.adgamewonderland.eplus.baseclip.connectors.Phase1Connector;
import com.adgamewonderland.eplus.baseclip.ui.InputUI;
import com.adgamewonderland.eplus.baseclip.controllers.TellafriendController;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.TellafriendUI extends InputUI {

	private var tellafriend:Tellafriend;

	private var sendername_txt:TextField;

	private var senderemail_txt:TextField;

	private var receivername_txt:TextField;

	private var receiveremail_txt:TextField;

	private var sendermessage_txt:TextField;

	private var send_btn:Button;

	public function TellafriendUI() {
		// user, der teilnehmen moechte
		this.tellafriend = new Tellafriend();
	}

	public function getTellafriend():Tellafriend
	{
		return this.tellafriend;
	}

	private function onLoad():Void
	{
		// ausblenden
		_visible = false;
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
		// als ui beim controller registrieren
		TellafriendController.getInstance().addUI(this, TellafriendController.STATUS_TELLAFRIEND);
	}

	private function doSend():Void
	{
		// bean befuellen
		this.tellafriend.setSendername(sendername_txt.text);
		this.tellafriend.setSenderemail(senderemail_txt.text);
		this.tellafriend.setReceivername(receivername_txt.text);
		this.tellafriend.setReceiveremail(receiveremail_txt.text);
		this.tellafriend.setMessage(sendermessage_txt.text);
		// validierung
		var errors:Array = this.tellafriend.getErrors();
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
		Phase1Connector.sendTellafriend(this.tellafriend, this, onTellafriendSent);
	}

	private function onTellafriendSent(receiver:LoadVars ):Void
	{
		// status
		var status:Number = Number(receiver["status"]);
		// datei-upload starten
		if (status == 1) {
			// controller informieren
			TellafriendController.getInstance().onFinishStatus(TellafriendController.STATUS_TELLAFRIEND);

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
		TellafriendController.getInstance().removeUI(this, TellafriendController.STATUS_TELLAFRIEND);
	}

}