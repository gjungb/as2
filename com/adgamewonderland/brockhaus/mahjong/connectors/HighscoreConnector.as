/*
 * Generated by ASDT
*/

import mx.remoting.Service;
import mx.remoting.PendingCall;
// import mx.remoting.debug.NetDebug;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

class com.adgamewonderland.brockhaus.mahjong.connectors.HighscoreConnector {

	private static var myGatewayURL:String = "http://webbox/flashservices/gateway.php";

	private static var myRemoteObject:String = "com.adgamewonderland.meyers.mahjong.connectors.HighscoreConnector";

	private static var myService:Service;

	// score speichern
	public static function putScore(gameid:Number, nickname:String, email:String, score:Number, security:String, caller:Object, callback:String ):Void
	{
		// authentifizieren
		getService().connection.setCredentials("player", security);
		// senden
		var pc:PendingCall = getService().putScore(gameid, nickname, email, score);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	// highscoreliste laden
	public static function getHighscore(gameid:Number, caller:Object, callback:String ):Void
	{
		// senden
		var pc:PendingCall = getService().getHighscore(gameid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	private static function getService():Service
	{
		// testen, ob service schon instantiiert
		if (myService instanceof Service == false) {
			// debugger
// 			NetDebug.initialize();
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