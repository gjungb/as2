/*
 * Generated by ASDT
*/

/*
klasse:			UserConnector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			ssk ddorf
erstellung: 		06.09.2005
zuletzt bearbeitet:	14.09.2005
durch			gj
status:			in bearbeitung
*/

import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

import com.adgamewonderland.sskddorf.slotmachine.beans.*;

class com.adgamewonderland.sskddorf.slotmachine.connectors.UserConnector {

	private static var myGatewayURL:String = "http://webbox/flashservices/gateway.php";

//	private static var myGatewayURL:String = "http://agentur.sskduesseldorf.de/flashservices/gateway.php";

	private static var myRemoteObject:String = "com.adgamewonderland.sskddorf.slotmachine.connectors.UserConnector";

	private static var myService:Service;

	public static function registerUser(user:User, caller:Object, callback:String ):Void
	{
		trace(user);
		// registrierung senden
		var pc:PendingCall = getService().registerUser(user);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function loginUser(email:String, password:String, caller:Object, callback:String ):Void
	{
		// login testen
		var pc:PendingCall = getService().loginUser(email, password);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	private static function getService():Service
	{
		// testen, ob service schon instantiiert
		if (myService instanceof Service == false) {
			// debugger
//			NetDebug.initialize();
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