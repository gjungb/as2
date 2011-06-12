import com.adgamewonderland.cma.adventskalender2006.beans.*;
import mx.utils.Delegate;

/**
 * Darstellung eines Users / Teilnehmers auf der Bühne, Eingabeformular
 */
class com.adgamewonderland.cma.adventskalender2006.ui.UserUI extends MovieClip
{
	private var user:com.adgamewonderland.cma.adventskalender2006.beans.User;
	private var vname_txt:TextField;
	private var name_txt:TextField;
	private var email_txt:TextField;
	private var strasse_txt:TextField;
	private var plz_txt:TextField;
	private var ort_txt:TextField;
	private var teilnahme_mc:com.adgamewonderland.cma.adventskalender2006.ui.CheckboxUI;
	private var datenschutz_mc:com.adgamewonderland.cma.adventskalender2006.ui.CheckboxUI;
	private var newsletter_mc:com.adgamewonderland.cma.adventskalender2006.ui.CheckboxUI;
	private var message_txt:TextField;
	private var send_btn:Button;

	public function UserUI()
	{
	}

	/**
	 * User anzeigen
	 * @param user User gekapselt in entsprechendem Bean
	 */
	public function showUser(user:com.adgamewonderland.cma.adventskalender2006.beans.User):Void
	{
		// userdaten anzeigen
		vname_txt.text = user.getVname();
		name_txt.text = user.getName();
		email_txt.text = user.getEmail();
		strasse_txt.text = user.getStrasse();
		plz_txt.text = user.getPlz();
		ort_txt.text = user.getOrt();
		// tabsetter
		var index:Number = 0;
		vname_txt.tabIndex = ++index;
		name_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		strasse_txt.tabIndex = ++index;
		plz_txt.tabIndex = ++index;
		ort_txt.tabIndex = ++index;
		Selection.setFocus(vname_txt);
		// eingabebeschraenkungen
		plz_txt.restrict = "0-9";
	}

	public function onLoad():Void
	{
		// in flashcookie gespeicherten user anzeigen
		showUser(Adventcalendar.getInstance().getUser());
		// button absenden
		send_btn.onRelease = Delegate.create(this, onPressSend);
	}

	/**
	 * Callback nach Klicken auf Absenden
	 */
	public function onPressSend():Void
	{
		// neuer user
		var user:User = new User();
		// eingegebene werte uebernehemn
		user.setVname(vname_txt.text);
		user.setName(name_txt.text);
		user.setEmail(email_txt.text);
		user.setStrasse(strasse_txt.text);
		user.setPlz(plz_txt.text);
		user.setOrt(ort_txt.text);
		user.setTeilnahme(teilnahme_mc.isStatus());
		user.setDatenschutz(datenschutz_mc.isStatus());
		user.setNewsletter(newsletter_mc.isStatus());
		// validieren
		switch (user.isValid()) {
			// nickt korrekt
			case false :
				// meldung anzeigen
				message_txt.text = "Ihre Angaben sind nicht korrekt!";

				break;
			// korrekt
			case true :
				// button ausblenden
				send_btn._visible = false;
				// userdaten senden
				Adventcalendar.getInstance().saveUser(user);
				// TODO: zur bestaetigung
				_parent.showConfirmation();

				break;
		}
	}

	public function setUser(user:com.adgamewonderland.cma.adventskalender2006.beans.User):Void
	{
		this.user = user;
	}

	public function getUser():com.adgamewonderland.cma.adventskalender2006.beans.User
	{
		return this.user;
	}
}