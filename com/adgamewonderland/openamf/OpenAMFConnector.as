/*
klasse:			OpenAMFConnector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		05.02.2005
zuletzt bearbeitet:	14.05.2005
durch			gj
status:			final
*/

import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

import com.adgamewonderland.agw.math.Point;

class com.adgamewonderland.openamf.OpenAMFConnector {
	
	static private var myGatewayURL:String = "http://localhost:8080/OpenAMFTest/gateway";
	
	static private var myRemoteObject:String = "com.adgamewonderland.openamf.TestBean";
	
	static private var myService:Service;
	
	static public function testOpenAMF(count:Number, name:String, caller:Object, callback:String ):Void
	{
		var p:Point = new Point(Math.random() * 100, 39);
		// service
		var service:Service = getService();
		// autor speichern
		var pc:PendingCall = service.setPoint(p);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static private function getService():Service
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
	
} /* end class OpenAMFConnector */