/**
 * @author gerd
 */
 
import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.meychi.MD5;

class com.adgamewonderland.digitalbanal.elfmeterduell.connectors.ChallengeC {
	
	private static var myGatewayURL:String = "http://plasticbox:8080/itsyourgame_tvblemgo/gateway";
	
	private static var myRemoteObject:String = "com.adgamewonderland.digitalbanal.elfmeterduell.connectors.ChallengeConnector";
	
	private static var myService:Service;
	
	public static function registerUser(user:User, caller:Object, callback:String ):Void
	{
		// registrierung senden
		var pc:PendingCall = getService().registerUser(user);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loginUser(email:String, password:String, caller:Object, callback:String ):Void
	{
		// login testen
		var pc:PendingCall = getService().loginUser(email, MD5.calculate(password));
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadAddress(uid:Number, caller:Object, callback:String ):Void
	{
		// adresse laden
		var pc:PendingCall = getService().loadAddress(uid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadPreference(uid:Number, caller:Object, callback:String ):Void
	{
		// preference laden
		var pc:PendingCall = getService().loadPreference(uid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadStatistics(uid:Number, caller:Object, callback:String ):Void
	{
		// statistics laden
		var pc:PendingCall = getService().loadStatistics(uid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function updateUser(user:User, caller:Object, callback:String ):Void
	{
		// user updaten
		var pc:PendingCall = getService().updateUser(user);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function saveGame(detail:GameDetail, email:String, caller:Object, callback:String ):Void
	{
		// spiel speichern
		var pc:PendingCall = getService().saveGame(detail, email);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadGame(mailid:String, caller:Object, callback:String ):Void
	{
		// spiel laden
		var pc:PendingCall = getService().loadGame(mailid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function updateGame(gameid:Number, detail:GameDetail, caller:Object, callback:String ):Void
	{
		// spiel updaten
		var pc:PendingCall = getService().updateGame(gameid, detail);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadBuddylist(userid:Number, caller:Object, callback:String):Void
	{
		// buddyliste laden
		var pc:PendingCall = getService().loadBuddylist(userid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadRank(userid:Number, caller:Object, callback:String):Void
	{
		// platzierung laden
		var pc:PendingCall = getService().loadRank(userid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadHighscorelist(rankstart:Number, count:Number, caller:Object, callback:String):Void
	{
		// highscoreliste laden
		var pc:PendingCall = getService().loadHighscorelist(rankstart, count);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadResultlist(userid:Number, caller:Object, callback:String):Void
	{
		// resultliste laden
		var pc:PendingCall = getService().loadResultlist(userid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	public static function loadGamelist(userid:Number, caller:Object, callback:String):Void
	{
		// gameliste laden
		var pc:PendingCall = getService().loadGamelist(userid);
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