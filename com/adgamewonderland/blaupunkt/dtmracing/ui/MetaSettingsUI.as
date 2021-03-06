/* 
 * Generated by ASDT 
*/ 

/*
klasse:			MetaSettingsUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			blaupunkt
erstellung: 		25.06.2005
zuletzt bearbeitet:	25.06.2005
durch			gj
status:			in bearbeitung
*/

import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.meychi.*;

import com.adgamewonderland.agw.*;

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

import com.adgamewonderland.blaupunkt.dtmracing.remoting.*;

import com.adgamewonderland.blaupunkt.dtmracing.ui.*;

class com.adgamewonderland.blaupunkt.dtmracing.ui.MetaSettingsUI extends MetaContentUI {
	
	private static var STATE_MIN:Number = 0;
	
	private static var STATE_MAX:Number = 2;
	
	private var myUser:User;
	
	private var myState:Number = STATE_MIN;
	
	private var email_txt:TextField;
	
	private var nickname_txt:TextField;
	
	private var password1_txt:TextField;
	
	private var password2_txt:TextField;
	
	private var message_txt:TextField;
	
	private var address_mc:AddressUI;
	
	private var send_btn:Button;
	
	public function MetaSettingsUI()
	{
		// vererbung
		super();
		// eingeloggter user
		myUser = ChallengeController.getInstance().getUser();
	}
	
	public function init():Void
	{
		// vererbung
		super.init();
		// textfelder
		initTextFields();
	 	// button send
	 	send_btn.onRelease = function () {
	 		this._parent.sendSettings();
	 	};
		// tabsetter
		var index:Number = 0;
		nickname_txt.tabIndex = ++index;
		password1_txt.tabIndex = ++index;
		password2_txt.tabIndex = ++index;
	}
	
	public function sendSettings():Void
	{
		// nickname
		var nickname:String = nickname_txt.text;
		// password
		var password:String = password1_txt.text;
		// address
		var address:UserAddress = address_mc.getAddress();
		// abbrechen, wenn adresse fehlerhaft
		if (address == null) return;
		
		// validieren, ob 1. nicht leerer nickname, 2. nicht leeres passwort
		var errors:Array = (new Formprocessor()).checkForm([1, "Nickname", nickname, 1, "Passwort 1", password]);
		// testen, ob fehler gefunden
		if (errors.length != 0 || password1_txt.text != password2_txt.text) {
			// nachricht
			message_txt.text = "Eingaben nicht korrekt!";
			// abbrechen
			return;
		}
		// meldung anzeigen
		message_txt.text = "Daten werden gesendet!";
		// button ausblenden
		send_btn._visible = false;
		
		// neuer user
		var user:User = new User(myUser.getUid(), myUser.getEmail(), MD5.calculate(password), nickname, address);
		// user aendern lassen
		ChallengeConnector.updateUser(user, this, "onUserUpdated");
		// adresse aendern lassen
		ChallengeConnector.updateAddress(myUser.getUid(), address, this, "onAddressUpdated");
	}
	
	public function onUserUpdated(re:ResultEvent ):Void
	{
		// testen, ob update erfolgreich
		if (Number(re.result) != User.STATUS_SUCCESS) {
			// meldung anzeigen
			message_txt.text = "Änderung fehlgeschlagen!";
			// button einblenden
			send_btn._visible = true;
			// abbrechen
			return;	
		}
		// nicknamen aendern
		myUser.setNickname(nickname_txt.text);
		// status updaten
		updateState();
	}
	
	public function onAddressUpdated(re:ResultEvent ):Void
	{
		// testen, ob update erfolgreich
		if (Number(re.result) != User.STATUS_SUCCESS) {
			// meldung anzeigen
			message_txt.text = "Änderung fehlgeschlagen!";
			// button einblenden
			send_btn._visible = true;
			// abbrechen
			return;	
		}
		// status updaten
		updateState();
	}
	
	private function initTextFields():Void
	{
		// email
		email_txt.text = myUser.getEmail();
		// nickname
		nickname_txt.text = myUser.getNickname();
	}
	
	private function updateState():Void
	{
		// meldung anzeigen
		message_txt.text = "Änderung erfolgreich!";
		// ladestatus hochzaehlen
		myState++;
		// testen, ob alles durch
		if (myState == STATE_MAX) {
			// schliessen
			closeContent();
		}
	}
}