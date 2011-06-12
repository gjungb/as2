﻿/** * @author gerd */import mx.rpc.ResultEvent;import com.adgamewonderland.agw.Formprocessor;import com.adgamewonderland.agw.util.CheckboxUI;import com.adgamewonderland.agw.util.TimelineFollower;import com.adgamewonderland.dhl.adventsgewinnspiel.beans.User;import com.adgamewonderland.dhl.adventsgewinnspiel.connectors.UserConnector;import com.adgamewonderland.dhl.adventsgewinnspiel.ui.CalendarUI;import com.meychi.MD5;import com.adgamewonderland.agw.util.InputUI;class com.adgamewonderland.dhl.adventsgewinnspiel.ui.WinUI extends InputUI {	private var myCalendarUI:CalendarUI;	private var security:String;	private var lastname_txt:TextField;	private var firstname_txt:TextField;	private var email_txt:TextField;	private var postcode_txt:TextField;	private var city_txt:TextField;	private var street_txt:TextField;	private var postno_txt:TextField;	private var code_txt:TextField;	private var optin_mc:CheckboxUI;	private var reminder_mc:CheckboxUI;	private var newsletter_mc:CheckboxUI;	private var send_btn:Button;	private var close_btn:Button;	public function WinUI() {		myCalendarUI = CalendarUI(_parent);		// abspielen verfolgen		var follower:TimelineFollower = new TimelineFollower(this, "init");		// abspielen verfolgen		onEnterFrame = function() {			follower.followTimeline();		};	}	public function init():Void	{	 	// button send	 	send_btn.onRelease = function () {	 		this._parent.sendWin();	 	};	 	// button zurueck	 	close_btn.onRelease = function () {	 		this._parent.stopWin();	 	};		// gespeicherte eingaben anzeigen		showStoredData();		// tabsetter		var index:Number = 0;		lastname_txt.tabIndex = ++index;		firstname_txt.tabIndex = ++index;		email_txt.tabIndex = ++index;		postno_txt.tabIndex = ++index;		postcode_txt.tabIndex = ++index;		city_txt.tabIndex = ++index;		street_txt.tabIndex = ++index;	 	// sicherheitscode	 	security = MD5.calculate(Math.random().toString()).substr(0, 5).toUpperCase();	 	// eingabe ziffern und grossbuchstaben	 	code_txt.restrict = "A-Z0-9";	 	// einzelne zeichen anzeigen	 	for (var i:Number = 0; i < security.length; i++) {	 		// aktuelles zeichen	 		var char:String = security.split("")[i];	 		// neues textfeld	 		this.createTextField("char" + i + "_txt", (i + 1), code_txt._x - 100 + (i * 15), code_txt._y, 20, 20);	 		var char_txt:TextField = this["char" + i + "_txt"];	 		// dynamisch	 		char_txt.selectable = false;	 		// rahmen//	 		char_txt.border = true;	 		// font	 		char_txt.embedFonts = true;	 		// zeichen	 		char_txt.text = char;	 		// font, size	 		char_txt.setTextFormat(new TextFormat("Arial", 12));	 		// drehen	 		char_txt._rotation += (Math.round(Math.random() * 15 * (Math.random() < 0.5 ? -1 : 1)));	 	}	}	public function stopWin():Void	{		// abspielen verfolgen		var follower:TimelineFollower = new TimelineFollower(this, "onWinFinished");		// abspielen verfolgen		onEnterFrame = function() {			follower.followTimeline();		};		// abspielen		gotoAndPlay("frClose");	}	public function sendWin():Void	{		// lastname		var lastname:String = lastname_txt.text;		// firstname		var firstname:String = firstname_txt.text;		// email		var email:String = email_txt.text.toLowerCase();		// postcode		var postcode:String = postcode_txt.text;		// city		var city:String = city_txt.text;		// street		var street:String = street_txt.text;		// postno		var postno:String = postno_txt.text;		// optin		var optin:Boolean = optin_mc.status;		// reminder		var reminder:Boolean = reminder_mc.status;		// newsletter		var newsletter:Boolean = newsletter_mc.status;		// fehler ausblenden		showErrors([]);		// nachricht ausblenden		showMessage("");		// validieren		var errors:Array = (new Formprocessor()).checkForm([1, "lastname", lastname, 1, "firstname", firstname, 3, "email", email, 1, "postcode", postcode, 1, "city", city, 1, "street", street]);		// optin		if (optin != true)			errors.push("optin");		// security		if (security != code_txt.text)			errors.push("code");		// testen, ob fehler gefunden		if (errors.length != 0) {			// nachricht			showMessage("Eingaben nicht korrekt!");			// fehler anzeigen			showErrors(errors);			// abbrechen			return;		}		// meldung anzeigen		showMessage("Daten werden gesendet!");		// button ausblenden		send_btn._visible = false;		// speichern, dass heute gespielt		myCalendarUI.finishGame();		// neuer winner		var winner:User = myCalendarUI.getUser();		// lastname		winner.setLastname(lastname);		// firstname		winner.setFirstname(firstname);		// email		winner.setEmail(email);		// postcode		winner.setPostcode(postcode);		// city		winner.setCity(city);		// street		winner.setStreet(street);		// postno		winner.setPostno(postno);		// optin		winner.setOptin(optin);		// reminder		winner.setReminder(reminder);		// newsletter		winner.setNewsletter(newsletter);		// winner lokal speichern		myCalendarUI.saveUserLocal();		// winner auf server speichern		UserConnector.saveWinner(winner, this, "onWinnerSaved");		// meldung anzeigen		showMessage("Daten gespeichert!");	}	public function onWinnerSaved(re:ResultEvent ):Void	{		// userid in datenbank		var id:Number = Number(re.result);		// testen, ob speichern erfolgreich		if (id == 0 || isNaN(id)) {			// meldung anzeigen			showMessage("Speichern fehlgeschlagen!");			// button einblenden			send_btn._visible = true;			// abbrechen			return;		}		// userid speichern		myCalendarUI.updateUser(id);				// captcha entfernen	 	for (var i:Number = 0; i < security.length; i++) {	 		// aktuelles textfeld	 		var char_txt:TextField = this["char" + i + "_txt"];	 		// entfernen			char_txt.removeTextField();		}		// abspielen verfolgen		var follower:TimelineFollower = new TimelineFollower(this, "onWinFinished");		// abspielen verfolgen		onEnterFrame = function() {			follower.followTimeline();		};		// abspielen		gotoAndPlay("frClose");	}	public function onWinFinished():Void	{		// trackpoint	  	_root.getReportingProcessor().setTrackpoint(24 + myCalendarUI.getToday().getDate(), "win" + myCalendarUI.getToday().getDate());		// zum kalender		myCalendarUI.showCalendar();	}	private function showStoredData():Void	{		// user		var user:User = myCalendarUI.getUser();		// felder befuellen		lastname_txt.text = user.getLastname();		firstname_txt.text = user.getFirstname();		email_txt.text = user.getEmail();		postcode_txt.text = user.getPostcode();		city_txt.text = user.getCity();		street_txt.text = user.getStreet();		postno_txt.text = user.getPostno();		optin_mc.status = user.getOptin();		reminder_mc.status = user.getReminder();		newsletter_mc.status = user.getNewsletter();	}}