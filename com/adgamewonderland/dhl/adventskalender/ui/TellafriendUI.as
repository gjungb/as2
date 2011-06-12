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

class com.adgamewonderland.dhl.adventskalender.ui.TellafriendUI extends MovieClip {
	
	private var myCalendarUI:CalendarUI;
	
	private var sendername_txt:TextField;
	
	private var senderemail_txt:TextField;
	
	private var receivername_txt:TextField;
	
	private var receiveremail_txt:TextField;
	
	private var message_txt:TextField;
	
	private var error_txt:TextField;
	
	private var send_btn:Button;
	
	private var close_btn:Button;
	
	public function TellafriendUI() {
		myCalendarUI = CalendarUI(_parent);
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
		message_txt.tabIndex = ++index;
	}
	
	public function stopTellafriend():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onTellafriendFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frClose");
	}
	
	public function sendTellafriend():Void
	{
		// sender
		var sender:User = new User();
		sender.setName(sendername_txt.text);
		sender.setEmail(senderemail_txt.text);
		// receiver
		var receiver:User = new User();
		receiver.setName(receivername_txt.text);
		receiver.setEmail(receiveremail_txt.text);
		// message
		var message:String = escape(message_txt.text);
		
		// abbrechen, wenn fehlerhaft
		if (!checkForm(sender, receiver)) {
			// meldung
			error_txt.text = "Angaben nicht korrekt!";
			// abbrechen
			return;
		}
		// meldung anzeigen
		error_txt.text = "Nachricht wird gesendet!";
		// button ausblenden
		send_btn._visible = false;
		
		// neues tellafriend
		var tellafriend:Tellafriend = new Tellafriend();
		// sender
		tellafriend.setSender(sender);
		// receiver
		tellafriend.setReceiver(receiver);
		// message
		tellafriend.setMessage(message);
		// tellafriend senden lassen
		CalendarConnector.sendTellafriend(tellafriend, this, "onTellafriendSent");
	}
	
	public function onTellafriendSent(re:ResultEvent ):Void
	{
		// testen, ob senden erfolgreich
		if (re.result == false) {
			// meldung anzeigen
			error_txt.text = "Senden fehlgeschlagen!";
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
		}
		// abspielen
		gotoAndPlay("frClose");
	}
	
	public function onTellafriendFinished():Void
	{
		// zum kalender
		myCalendarUI.showCalendar();
	}
	
	private function checkForm(sender:User, receiver:User ):Boolean
	{
		// eingaben valide
		var valid:Boolean = false;
		// formprocessor
		var fp:Formprocessor = new Formprocessor();
		// fehler
		var errors:Array = fp.checkForm([1, "sendername", sender.getName(), 3, "senderemail", sender.getEmail(), 1, "receivername", receiver.getName(), 3, "receiveremail", receiver.getEmail()]);
		// valide, wenn keine fehler
		valid = (errors.length == 0);
		// zureuck geben
		return valid;
	}
	
}