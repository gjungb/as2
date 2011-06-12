/**
 * @author gerd
 */
 
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.adgamewonderland.agw.*;

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventskalender.beans.*;

import com.adgamewonderland.dhl.adventskalender.connectors.*;

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.WinUI extends MovieClip {
	
	private var myCalendarUI:CalendarUI;
	
	private var myLso:SharedObject;
	
	private var lastname_txt:TextField;
	
	private var firstname_txt:TextField;
	
	private var email_txt:TextField;
	
	private var postcode_txt:TextField;
	
	private var city_txt:TextField;
	
	private var street_txt:TextField;
	
	private var postno_txt:TextField;
	
	private var error_txt:TextField;
	
	private var optin_mc:CheckboxUI;
	
	private var send_btn:Button;
	
	private var close_btn:Button;
	
	public function WinUI() {
		myCalendarUI = CalendarUI(_parent);
		// lso zum speichern / laden der eingaben
		myLso = SharedObject.getLocal("dhl_adventskalender");
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
	}
	
	public function init():Void
	{
	 	// button send
	 	send_btn.onRelease = function () {
	 		this._parent.sendWin();
	 	};
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.stopWin();
	 	};
		// gespeicherte eingaben anzeigen
		showStoredData();
		// tabsetter
		var index:Number = 0;
		lastname_txt.tabIndex = ++index;
		firstname_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		postcode_txt.tabIndex = ++index;
		city_txt.tabIndex = ++index;
		street_txt.tabIndex = ++index;
		postno_txt.tabIndex = ++index;
	}
	
	public function stopWin():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onWinFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frClose");
	}
	
	public function sendWin():Void
	{
		// lastname
		var lastname:String = lastname_txt.text;
		// firstname
		var firstname:String = firstname_txt.text;
		// email
		var email:String = email_txt.text.toLowerCase();
		// postcode
		var postcode:String = postcode_txt.text;
		// city
		var city:String = city_txt.text;
		// street
		var street:String = street_txt.text;
		// postno
		var postno:String = postno_txt.text;
		// optin
		var optin:Boolean = optin_mc.status;
		
		// validieren
		var errors:Array = (new Formprocessor()).checkForm([1, "Nachname", lastname, 1, "Vorname", firstname, 3, "E-Mail", email, 1, "Postleitzahl", postcode, 1, "Ort", city, 1, "Strasse", street]);
		// testen, ob fehler gefunden
		if (errors.length != 0 || optin != true) {
			// nachricht
			error_txt.text = "Eingaben nicht korrekt!";
			// abbrechen
			return;
		}
		// meldung anzeigen
		error_txt.text = "Daten werden gesendet!";
		// button ausblenden
		send_btn._visible = false;
		
		
		// neuer winner
		var winner:Winner = new Winner();
		// lastname
		winner.setLastname(lastname);
		// firstname
		winner.setFirstname(firstname);
		// email
		winner.setEmail(email);
		// postcode
		winner.setPostcode(postcode);
		// city
		winner.setCity(city);
		// street
		winner.setStreet(street);
		// postno
		winner.setPostno(postno);
		// optin
		winner.setOptin(optin);
		// daten lokal speichern
		myLso.data.winner = winner;
		myLso.flush();
		// gid
		winner.setGid(myCalendarUI.getGid());
		// winner speichern lassen
		CalendarConnector.saveWinner(winner, this, "onWinnerSaved");
	}
	
	public function onWinnerSaved(re:ResultEvent ):Void
	{
		// testen, ob speichern erfolgreich
		if (re.result == false) {
			// meldung anzeigen
			error_txt.text = "Speichern fehlgeschlagen!";
			// button einblenden
			send_btn._visible = true;
			// abbrechen
			return;	
		}
		// meldung anzeigen
		error_txt.text = "Speichern erfolgreich!";
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onWinFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frClose");
	}
	
	public function onWinFinished():Void
	{
		// zum kalender
		myCalendarUI.showCalendar();
	}
	
	private function showStoredData():Void
	{
		// winner
		var winner:Winner = myLso.data.winner;
		if (winner != null) {
			lastname_txt.text = winner["lastname"];
			firstname_txt.text = winner["firstname"];
			email_txt.text = winner["email"];
			postcode_txt.text = winner["postcode"];
			city_txt.text = winner["city"];
			street_txt.text = winner["street"];
			postno_txt.text = winner["postno"];
			optin_mc.status = winner["optin"];
		}
	}
	
	
}