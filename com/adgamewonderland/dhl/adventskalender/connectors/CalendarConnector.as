/**
 * @author gerd
 */

import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

import com.adgamewonderland.dhl.adventskalender.beans.*;
 
class com.adgamewonderland.dhl.adventskalender.connectors.CalendarConnector {
	
	private static var myGatewayURL:String = "http://plasticbox/flashservices/gateway.php";
	
	private static var myRemoteObject:String = "com.adgamewonderland.dhl.adventskalender.connectors.CalendarConnector";
	
	private static var myService:Service;
	
	public static function saveScore(score:Score, caller:Object, callback:String ):Void
	{
		// score senden
		var pc:PendingCall = getService().saveScore(score);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadHighscore(gid:Number, count:Number, caller:Object, callback:String ):Void
	{
		// highscoreliste laden
		var pc:PendingCall = getService().loadHighscore(gid, count);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function saveWinner(winner:Winner, caller:Object, callback:String ):Void
	{
		// winner senden
		var pc:PendingCall = getService().saveWinner(winner);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function sendTellafriend(tellafriend:Tellafriend, caller:Object, callback:String ):Void
	{
		// tellafriend senden
		var pc:PendingCall = getService().sendTellafriend(tellafriend);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	private static function getService():Service
	{
		// testen, ob service schon instantiiert
		if (myService instanceof Service == false) {
			// debugger
			NetDebug.initialize();
			// offline / online
			if (_url.indexOf("http://") == -1) {
				// remoting service mit url
				myService = new Service(myGatewayURL, null, myRemoteObject, null, null);
			} else {
				// remoting service ohne url
				myService = new Service("", null, myRemoteObject, null, null);
			}
		}
		// zurueck geben
		return myService;
	}
}