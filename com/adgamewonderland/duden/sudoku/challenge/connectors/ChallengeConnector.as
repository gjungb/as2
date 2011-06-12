import mx.remoting.debug.NetDebug;
import mx.remoting.PendingCall;
import mx.remoting.Service;
import mx.rpc.RelayResponder;

import com.adgamewonderland.duden.sudoku.challenge.beans.Result;
import com.adgamewonderland.duden.sudoku.challenge.beans.Sudoku;
import com.adgamewonderland.duden.sudoku.challenge.beans.Term;
import com.adgamewonderland.duden.sudoku.challenge.beans.User;

class com.adgamewonderland.duden.sudoku.challenge.connectors.ChallengeConnector
{

	private static var myGatewayURL:String = "http://webbox/flashservices/gateway.php";

	private static var myRemoteObject:String = "com.adgamewonderland.duden.sudoku.challenge.connectors.ChallengeConnector";

	private static var myService:Service;

	public static function loadSudoku(difficulty:Number, caller:Object, callback:String ):Void
	{
		// sudoku laden
		var pc:PendingCall = getService().loadSudoku(difficulty);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function initChallenge(user:User, opponentemail:String, sudoku:Sudoku, term:Term, result:Result, caller:Object, callback:String ):Void
	{
		// herausforderung speichern
		var pc:PendingCall = getService().initChallenge(user, opponentemail, sudoku, term, result);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function loadChallenge(hashkey:String, caller:Object, callback:String ):Void
	{
		// herausforderung laden
		var pc:PendingCall = getService().loadChallenge(hashkey);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function finishChallenge(user:User, hashkey:String, result:Result, caller:Object, callback:String ):Void
	{
		// herausforderung beenden
		var pc:PendingCall = getService().finishChallenge(user, hashkey, result);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

//	public static function loadBuddylist(userid:Number, caller:Object, callback:String):Void
//	{
//		// buddyliste laden
//		var pc:PendingCall = getService().loadBuddylist(userid);
//		// rueckgabe von rmi auswerten
//		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
//	}

	private static function getService():Service
	{
		// testen, ob service schon instantiiert
		if (myService instanceof Service == false) {
			// debugger
			NetDebug.initialize();
			// offline / online
			if (_root._url.indexOf("http://") == -1) {
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