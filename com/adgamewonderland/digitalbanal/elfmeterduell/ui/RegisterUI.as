/**
 * @author gerd
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

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.RegisterUI extends InputUI {
	
	private var lso:SharedObject;
	
	private var sex1_mc:MovieClip;
	
	private var sex2_mc:MovieClip;
	
	private var firstname_txt:TextField;
	
	private var lastname_txt:TextField;
	
	private var nickname_txt:TextField;
	
	private var email_txt:TextField;
	
	private var password1_txt:TextField;
	
	private var password2_txt:TextField;
	
	private var register_btn:Button;
	
	private var newsletter_mc:CheckboxUI;
	
	private var optin_mc:CheckboxUI;
	
	private var message_txt:TextField;
	
	public function RegisterUI() {
		// lso zum speichern / laden der email
		lso = SharedObject.getLocal("elfmeterduell");
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// nachricht fehlerhaftes registrieren ausblenden
		showMessage(false);
	}
	
	public function init():Void
	{
		// ggf. email aus herausforderungs- / siegerehrungs mail
		if (_root.email != "null" && _root.email != undefined) {
			// anzeigen
			email_txt.text = _root.email;
			// nicht auswaehlbar
			email_txt.selectable = false;
			// nicht aenderbar
			email_txt.type = "dynamic";
		}
	 	// button register
	 	register_btn.onRelease = function () {
	 		this._parent.sendRegister();
	 	};
		// tabsetter
		var index:Number = 3;
		firstname_txt.tabIndex = ++index;
		lastname_txt.tabIndex = ++index;
		nickname_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		password1_txt.tabIndex = ++index;
		password2_txt.tabIndex = ++index;
		// newsletter angehakt
		newsletter_mc.status = true;
	}
	
	public function resetRadiobuttons():Void
	{
		// radionbuttons fuer anrede resetten
		sex1_mc.gotoAndStop(1);
		sex2_mc.gotoAndStop(1);
	}
	
	public function sendRegister():Void
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
		// email
		var email:String = email_txt.text.toLowerCase();
		// password
		var password:String = password1_txt.text;
		// newsletter
		var newsletter:Boolean = newsletter_mc.status;
		// optin
		var optin:Boolean = optin_mc.status;
		
		// fehler ausblenden
		showErrors([]);
		// nachricht fehlerhaftes login ausblenden
		showMessage(false);
		// validieren
		var errors:Array = (new Formprocessor()).checkForm([1, "sex", sex, 1, "firstname", firstname, 1, "lastname", lastname, 1, "nickname", nickname, 3, "email", email, 1, "password1", password]);
		// keine anrede
		if (sex == undefined) errors.push("sex1", "sex2");
		// passwoerter nicht identisch
		if (password1_txt.text != password2_txt.text) errors.push("password2");
		// optin nicht angekreuzt
		if (optin != true) errors.push("optin");
		// testen, ob fehler gefunden
		if (errors.length != 0) {
			// fehler anzeigen
			showErrors(errors);
			// abbrechen
			return;
		}
		// button ausblenden
		register_btn._visible = false;
		
		// neuer user
		var user:User = new User();
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
		// email
		user.setEmail(email);
		// password
		user.setPassword(MD5.calculate(password));
		// newsletter
		preference.setNewsletter(newsletter);
		// optin
		preference.setOptin(optin);
		// user registrieren lassen
		ChallengeC.registerUser(user, this, "onUserRegistered");
	}
	
	public function onUserRegistered(re:ResultEvent ):Void
	{
		// ergebnis
		var result:Number = Number(re.result);
		// testen, ob register erfolgreich
		if (result < 1) {
			// meldung anzeigen
//			trace("Registrierung fehlgeschlagen!");
			// nachricht fehlerhaftes registrieren einblenden
			showMessage(true);
			// button einblenden
			register_btn._visible = true;
			// abbrechen
			return;	
		}
		// user sofort einloggen
		ChallengeC.loginUser(email_txt.text.toLowerCase(), password1_txt.text, this, "onUserLoaded");
	}
	
	public function onUserLoaded(re:ResultEvent ):Void
	{
		// testen, ob login erfolgreich
		if (re.result.status != 1) {
			// abbrechen
			return;	
		}
		// neuer user
		var user:User = User(RemotingBeanCaster.getCastedInstance(new User(), re.result));
		// email lokal speichern
		lso.data.email = user.getEmail();
		// speichern
		lso.flush();
		// einloggen
		GameController.getInstance().loginUser(user, true);
	}
	
	private function showMessage(bool:Boolean ):Void
	{
		// nachricht fehlerhaftes registrieren ein- / ausblenden
		message_txt._visible = bool;
	}
}