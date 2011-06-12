/**
 * @author gerd
 */

import mx.rpc.ResultEvent;

import com.adgamewonderland.agw.Formprocessor;
import com.adgamewonderland.agw.util.TimelineFollower;
import com.adgamewonderland.dhl.adventsgewinnspiel.beans.User;
import com.adgamewonderland.dhl.adventsgewinnspiel.connectors.UserConnector;
import com.adgamewonderland.dhl.adventsgewinnspiel.ui.CalendarUI;
import com.adgamewonderland.agw.util.InputUI;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.TellafriendUI extends InputUI {

	private var myCalendarUI:CalendarUI;

	private var sendername_txt:TextField;

	private var senderemail_txt:TextField;

	private var receivername_txt:TextField;

	private var receiveremail_txt:TextField;

	private var tellafriend_txt:TextField;

	private var send_btn:Button;

	private var close_btn:Button;

	public function TellafriendUI() {
		myCalendarUI = CalendarUI(_parent);
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
	}

	public function showTellafriend():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frOpen");
	}

	public function init():Void
	{
	 	// button send
	 	send_btn.onRelease = function () {
	 		this._parent.sendTellafriend();
	 	};
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.stopTellafriend();
	 	};
		// tabsetter
		var index:Number = 0;
		sendername_txt.tabIndex = ++index;
		senderemail_txt.tabIndex = ++index;
		receivername_txt.tabIndex = ++index;
		receiveremail_txt.tabIndex = ++index;
		tellafriend_txt.tabIndex = ++index;
	}

	public function stopTellafriend():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onTellafriendFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frClose");
	}

	public function sendTellafriend():Void
	{
		// sender
		var sender:User = new User();
		sender.setLastname(sendername_txt.text);
		sender.setEmail(senderemail_txt.text);
		// receiver
		var receiver:User = new User();
		receiver.setLastname(receivername_txt.text);
		receiver.setEmail(receiveremail_txt.text);
		// message
		var message:String = (tellafriend_txt.text);

		// fehler ausblenden
		showErrors([]);
		// nachricht fehlerhaftes login ausblenden
		showMessage("");

		// validieren
		var errors:Array = (new Formprocessor()).checkForm([1, "sendername", sender.getLastname(), 3, "senderemail", sender.getEmail(), 1, "receivername", receiver.getLastname(), 3, "receiveremail", receiver.getEmail()]);
		// testen, ob fehler gefunden
		if (errors.length != 0) {
			// nachricht
			showMessage("Eingaben nicht korrekt!");
			// fehler anzeigen
			showErrors(errors);
			// abbrechen
			return;
		}
		// meldung anzeigen
		showMessage("Nachricht wird gesendet!");
		// button ausblenden
		send_btn._visible = false;

		// tellafriend senden lassen
		UserConnector.sendTellafriend(sender, receiver, message, this, "onTellafriendSent");
	}

	public function onTellafriendSent(re:ResultEvent ):Void
	{
		// testen, ob senden erfolgreich
		if (re.result == false) {
			// meldung anzeigen
			showMessage("Senden fehlgeschlagen!");
			// button einblenden
			send_btn._visible = true;
			// abbrechen
			return;
		}
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onTellafriendFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frClose");
	}

	public function onTellafriendFinished():Void
	{
		// trackpoint
	 	_root.getReportingProcessor().setTrackpoint(73, "tellafriend");
		// zum kalender
		myCalendarUI.showCalendar();
	}

	public function closeTellafriend():Void
	{
		// abspielen
		gotoAndPlay("frClose");
	}

}