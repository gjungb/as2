﻿/* * Generated by ASDT*//*klasse:			RegisterUIautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			ssk ddorferstellung: 		06.09.2005zuletzt bearbeitet:	06.09.2005durch			gjstatus:			in bearbeitung*/import mx.rpc.ResultEvent;import com.adgamewonderland.agw.Formprocessor;import com.adgamewonderland.agw.util.CheckboxUI;import com.adgamewonderland.agw.util.TimelineFollower;import com.adgamewonderland.sskddorf.slotmachine.beans.User;import com.adgamewonderland.sskddorf.slotmachine.connectors.UserConnector;import com.adgamewonderland.sskddorf.slotmachine.ui.SlotmachineUI;import com.meychi.MD5;class com.adgamewonderland.sskddorf.slotmachine.ui.RegisterUI extends MovieClip {	private var mySlotmachineUI:SlotmachineUI;	private var myLso:SharedObject;	private var salutation1_mc:MovieClip;	private var salutation2_mc:MovieClip;	private var firstname_txt:TextField;	private var lastname_txt:TextField;	private var street_txt:TextField;	private var postcode_txt:TextField;	private var city_txt:TextField;	private var email_txt:TextField;	private var password1_txt:TextField;	private var password2_txt:TextField;	private var optin_mc:CheckboxUI;	private var message_txt:TextField;	private var register_btn:Button;	private var back_btn:Button;	public function RegisterUI()	{		// hauptzeitleiste		mySlotmachineUI = SlotmachineUI(_parent);		// lso zum speichern / laden der email		myLso = SharedObject.getLocal("slotmachine");		// abspielen verfolgen		var follower:TimelineFollower = new TimelineFollower(this, "init");		// abspielen verfolgen		onEnterFrame = function() {			follower.followTimeline();		};	}	public function init():Void	{	 	// button register	 	register_btn.onRelease = function () {	 		this._parent.sendRegister();	 	};	 	// button zurueck	 	back_btn.onRelease = function () {	 		this._parent.stopRegister();	 	};		// tabsetter		var index:Number = 0;		firstname_txt.tabIndex = ++index;		lastname_txt.tabIndex = ++index;		street_txt.tabIndex = ++index;		postcode_txt.tabIndex = ++index;		city_txt.tabIndex = ++index;		email_txt.tabIndex = ++index;		password1_txt.tabIndex = ++index;		password2_txt.tabIndex = ++index;	}	public function stopRegister():Void	{		// abspielen verfolgen		var follower:TimelineFollower = new TimelineFollower(this, "onRegisterFinished");		// abspielen verfolgen		onEnterFrame = function() {			follower.followTimeline();		};		// abspielen		gotoAndPlay("frClose");	}	public function resetRadiobuttons():Void	{		// radionbuttons fuer anrede resetten		salutation1_mc.gotoAndStop(1);		salutation2_mc.gotoAndStop(1);	}	public function sendRegister():Void	{		// salutation		var salutation:String = "";		// herr		if (salutation1_mc._currentframe == 2) salutation = "Herr";		// frau		if (salutation2_mc._currentframe == 2) salutation = "Frau";		// firstname		var firstname:String = firstname_txt.text;		// lastname		var lastname:String = lastname_txt.text;		// street		var street:String = street_txt.text;		// postcode		var postcode:String = postcode_txt.text;		// city		var city:String = city_txt.text;		// email		var email:String = email_txt.text.toLowerCase();		// password		var password:String = password1_txt.text;		// optin		var optin:Boolean = optin_mc.status;		// validieren		var errors:Array = (new Formprocessor()).checkForm([1, "Anrede", salutation, 1, "Vorname", firstname, 1, "Nachname", lastname, 1, "postcode", postcode, 1, "city", city, 1, "street", street, 3, "E-Mail", email, 1, "Passwort 1", password]);		// testen, ob fehler gefunden		if (errors.length != 0 || password1_txt.text != password2_txt.text || optin != true) {			// nachricht			message_txt.text = "Eingaben nicht korrekt!";			// abbrechen			return;		}		// meldung anzeigen		message_txt.text = "Daten werden gesendet!";		// button ausblenden		register_btn._visible = false;		// neuer user		var user:User = new User();		// salutation		user.setSalutation(salutation);		// firstname		user.setFirstname(firstname);		// lastname		user.setLastname(lastname);		// street		user.setStreet(street);		// postcode		user.setPostcode(postcode);		// city		user.setCity(city);		// email		user.setEmail(email);		// password		user.setPassword(MD5.calculate(password));		// optin		user.setOptin(optin);		// user registrieren lassen		UserConnector.registerUser(user, this, "onUserRegistered");	}	public function onUserRegistered(re:ResultEvent ):Void	{		// testen, ob register erfolgreich		if (re.result == false) {			// meldung anzeigen			message_txt.text = "Registrierung fehlgeschlagen!";			// button einblenden			register_btn._visible = true;			// abbrechen			return;		}		// meldung anzeigen		message_txt.text = "Registrierung erfolgreich!";		// email lokal speichern		myLso.data.email = email_txt.text;		// speichern		myLso.flush();		// abspielen verfolgen		var follower:TimelineFollower = new TimelineFollower(this, "onRegisterFinished");		// abspielen verfolgen		onEnterFrame = function() {			follower.followTimeline();		};		// abspielen		gotoAndPlay("frClose");	}	public function onRegisterFinished():Void	{		// zum login		mySlotmachineUI.showLogin();	}}