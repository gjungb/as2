/**
 * @author gerd
 */

import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

import com.adgamewonderland.dhl.adventsgewinnspiel.beans.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.connectors.TaskConnector {

	private static var myGatewayURL:String = "http://blackbox:8080/dhl_adventsgewinnspiel/gateway";

	private static var myRemoteObject:String = "com.adgamewonderland.dhl.adventsgewinnspiel.connectors.TaskConnector";

	private static var myService:Service;

	public static function loadTask(date:Date, caller:Object, callback:String ):Void
	{
		// task laden
		var pc:PendingCall = getService().loadTask(date);
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
			if (_root._url.indexOf("://") == -1) {
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