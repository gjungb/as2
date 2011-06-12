/* 
 * Generated by ASDT 
*/ 
 
import mx.remoting.debug.NetDebug;
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.meychi.*;

import com.adgamewonderland.agw.*;

import com.adgamewonderland.agw.net.*;

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.connectors.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.UserdataUI extends InputUI {
	
	private var user:User;
	
	private var sex1_mc:MovieClip;
	
	private var sex2_mc:MovieClip;
	
	private var firstname_txt:TextField;
	
	private var lastname_txt:TextField;
	
	private var nickname_txt:TextField;
	
	private var email_txt:TextField;
	
	private var password1_txt:TextField;
	
	private var password2_txt:TextField;
	
	private var save_btn:Button;
	
	private var newsletter_mc:CheckboxUI;
	
	public function UserdataUI() {
		// nickname linksbuendig
		nickname_txt.autoSize = "left";
		
	}
	
	public function init():Void
	{
		// eingeloggter user
		user = GameController.getInstance().getUser();
		// nickname
		nickname_txt.text = user.getNickname();
		// email
		email_txt.text = user.getEmail();
		// adresse laden
		ChallengeC.loadAddress(user.getUserID(), this, "onAddressLoaded");
	}
	
	public function resetRadiobuttons():Void
	{
		// radionbuttons fuer anrede resetten
		sex1_mc.gotoAndStop(1);
		sex2_mc.gotoAndStop(1);
	}
	
	public function onAddressLoaded(re:ResultEvent ):Void
	{
		// neue adresse
		var address:Address = Address(RemotingBeanCaster.getCastedInstance(new Address(), re.result));
		// speichern
		GameController.getInstance().getUser().setAddress(address);
		// sex
		sex1_mc.gotoAndStop(address.getSex() == Address.SEX_MALE ? 2 : 1);
		sex2_mc.gotoAndStop(address.getSex() == Address.SEX_FEMALE ? 2 : 1);
		// firstname
		firstname_txt.text = address.getFirstname();
		// lastname
		lastname_txt.text = address.getLastname();
		// preference laden
		ChallengeC.loadPreference(user.getUserID(), this, "onPreferenceLoaded");
	}
	
	public function onPreferenceLoaded(re:ResultEvent ):Void
	{
		// neue preference
		var preference:Preference = Preference(RemotingBeanCaster.getCastedInstance(new Preference(), re.result));
		// speichern
		GameController.getInstance().getUser().setPreference(preference);
		// newsletter
		newsletter_mc.status = preference.getNewsletter();
		
	 	// button save
	 	save_btn.onRelease = function () {
	 		this._parent.sendUserdata();
	 	};
		// tabsetter
		var index:Number = 0;
		firstname_txt.tabIndex = ++index;
		lastname_txt.tabIndex = ++index;
		nickname_txt.tabIndex = ++index;
		password1_txt.tabIndex = ++index;
		password2_txt.tabIndex = ++index;
	}
	
	public function sendUserdata():Void
	{
		// sex
		var sex:Number;
		// herr
		if (sex1_mc._currentframe == 2) sex = Address.SEX_MALE;
		// frau
		if (sex2_mc._currentframe == 2) sex = Address.SEX_FEMALE;
		// firstname
		var firstname:String = firstname_txt.text;
		// lastname
		var lastname:String = lastname_txt.text;
		// nickname
		var nickname:String = nickname_txt.text;
		// password
		var password:String = password1_txt.text;
		// newsletter
		var newsletter:Boolean = newsletter_mc.status;
		
		// validieren
		var errors:Array = (new Formprocessor()).checkForm([1, "sex", sex, 1, "firstname", firstname, 1, "lastname", lastname, 1, "nickname", nickname, 1, "password1", password]);
		// passwoerter nicht identisch
		if (password1_txt.text != password2_txt.text) errors.push("password2");
		// testen, ob fehler gefunden
		if (errors.length != 0) {
			// fehler anzeigen
			showErrors(errors);
			// abbrechen
			return;
		}
		// button ausblenden
		save_btn._visible = false;
		
		// user
		var user:User = GameController.getInstance().getUser();
		// adresse
		var address:Address = user.getAddress();
		// preference
		var preference:Preference = user.getPreference();
		// sex
		address.setSex(sex);
		// firstname
		address.setFirstname(firstname);
		// lastname
		address.setLastname(lastname);
		// nickname
		user.setNickname(nickname);
		// password
		user.setPassword(MD5.calculate(password));
		// newsletter
		preference.setNewsletter(newsletter);
		// user updaten lassen
		ChallengeC.updateUser(user, this, "onUserUpdated");
		// user intern updaten
		GameController.getInstance().updateUser(user);
	}
	
	public function onUserUpdated(re:ResultEvent ):Void
	{
		// testen, ob update erfolgreich
		if (re.result == false) {
			// meldung anzeigen
			trace("Update fehlgeschlagen!");
			// button einblenden
			save_btn._visible = true;
			// abbrechen
			return;	
		}
		// meldung anzeigen
		trace("Update erfolgreich!");
	}
}