/* 
 * Generated by ASDT 
*/ 

/*
klasse:			MetaContestUI
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

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

import com.adgamewonderland.blaupunkt.dtmracing.remoting.*;

import com.adgamewonderland.blaupunkt.dtmracing.ui.*;

class com.adgamewonderland.blaupunkt.dtmracing.ui.MetaContestUI extends MetaContentUI {
	
	private var address_mc:AddressUI;
	
	private var send_btn:Button;
	
	public function MetaContestUI()
	{
		// vererbung
		super();
	}
	
	public function init():Void
	{
		// vererbung
		super.init();
	 	// button send
	 	send_btn.onRelease = function () {
	 		this._parent.sendSettings();
	 	};
	}
	
	public function sendSettings():Void
	{
		// address
		var address:UserAddress = address_mc.getAddress();
		// abbrechen, wenn adresse fehlerhaft
		if (address == null) return;
		
		// meldung anzeigen
		address_mc.message_txt.text = "Daten werden gesendet!";
		// button ausblenden
		send_btn._visible = false;
		
		// adresse aendern lassen
		ChallengeConnector.updateAddress(ChallengeController.getInstance().getUser().getUid(), address, this, "onAddressUpdated");
	}
	
	public function onAddressUpdated(re:ResultEvent ):Void
	{
		// testen, ob update erfolgreich
		if (Number(re.result) != User.STATUS_SUCCESS) {
			// meldung anzeigen
			address_mc.message_txt.text = "Änderung fehlgeschlagen!";
			// button einblenden
			send_btn._visible = true;
			// abbrechen
			return;	
		}
		// schliessen
		closeContent();
	}
}