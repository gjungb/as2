import mx.utils.Delegate;

import com.adgamewonderland.eplus.baseclip.interfaces.ISendable;
import flash.net.FileReference;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.connectors.Phase1Connector {

	private static var BASEURL:String = "http://tripto.adgame-wonderland.de:8080/baseclip/servlets/";

	private static var DEBUG:Boolean = false;

	public static function sendParticipation(participant:ISendable, caller:Object, callback:Function ):Void
	{
		// servlet an url haengen
		var url:String = BASEURL + "Participation";
		// load vars klasse erzeugen lassen
		var sender:LoadVars = participant.getLoadVars();
		// empfaenger der vom server gesendeten daten
		var receiver:LoadVars = new LoadVars();
		// callback
		receiver.onLoad = function(success:Boolean ):Void {
			callback.apply(caller, [this]);
		};
		// senden
		if (DEBUG) {
			sender.send(url, "_blank", "GET");
		} else {
			sender.sendAndLoad(url, receiver, "POST");
		}
	}

	public static function uploadFile(file:FileReference, title:String, caller:Object, callback:Function )
	{
		// servlet an url haengen
		var url:String = BASEURL + "Upload?title=" + title;
		// hochladen (callback entfaellt, da an FileReference gebunden)
		var success:Boolean = file.upload(url);
	}

	public static function sendTellafriend(tellafriend:ISendable, caller:Object, callback:Function ):Void
	{
		// servlet an url haengen
		var url:String = BASEURL + "Tellafriend";
		// load vars klasse erzeugen lassen
		var sender:LoadVars = tellafriend.getLoadVars();
		// empfaenger der vom server gesendeten daten
		var receiver:LoadVars = new LoadVars();
		// callback
		receiver.onLoad = function(success:Boolean ):Void {
			callback.apply(caller, [this]);
		};
		// senden
		if (DEBUG) {
			sender.send(url, "_blank", "GET");
		} else {
			sender.sendAndLoad(url, receiver, "POST");
		}
	}

	public static function sendContact(contact:ISendable, caller:Object, callback:Function ):Void
	{
		// servlet an url haengen
		var url:String = BASEURL + "Contact";
		// load vars klasse erzeugen lassen
		var sender:LoadVars = contact.getLoadVars();
		// empfaenger der vom server gesendeten daten
		var receiver:LoadVars = new LoadVars();
		// callback
		receiver.onLoad = function(success:Boolean ):Void {
			callback.apply(caller, [this]);
		};
		// senden
		if (DEBUG) {
			sender.send(url, "_blank", "GET");
		} else {
			sender.sendAndLoad(url, receiver, "POST");
		}
	}

}