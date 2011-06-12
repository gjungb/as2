import com.adgamewonderland.duden.sudoku.challenge.beans.User;
import com.adgamewonderland.duden.sudoku.challenge.beans.Statistics;
import com.adgamewonderland.duden.sudoku.challenge.beans.Preference;
import com.adgamewonderland.duden.sudoku.challenge.beans.Address;
import mx.remoting.Service;
import mx.remoting.debug.NetDebug;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import com.meychi.MD5;
import mx.remoting.Connection;

class com.adgamewonderland.duden.sudoku.challenge.connectors.UserConnector
{

	private static var myGatewayURL:String = "http://webbox/flashservices/gateway.php";

	private static var myRemoteObject:String = "com.adgamewonderland.duden.sudoku.challenge.connectors.UserConnector";

	private static var myService:Service;

	public static function registerUser(user:User, caller:Object, callback:String ):Void
	{
		// registrierung senden
		var pc:PendingCall = getService().registerUser(user);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function finishRegistration(email:String, hashkey:String, caller:Object, callback:String ):Void
	{
		// registrierung abschliessen
		var pc:PendingCall = getService().finishRegistration(email, hashkey);
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

	public static function loadOpponent(email:String, caller:Object, callback:String ):Void
	{
		// gegner laden
		var pc:PendingCall = getService().loadOpponent(email);
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

	public static function loadStatistics(email:String, caller:Object, callback:String ):Void
	{
		// statistics laden
		var pc:PendingCall = getService().loadStatistics(email);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function updatePreference(preference:Preference, caller:Object, callback:String ):Void
	{
		// preference updaten
		var pc:PendingCall = getService().updatePreference(preference);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function updateAddress(address:Address, caller:Object, callback:String ):Void
	{
		// address updaten
		var pc:PendingCall = getService().updateAddress(address);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function updateUser(newnickname:String, newpassword:String, uid:Number, password:String, caller:Object, callback:String ):Void
	{
		// address updaten
		var pc:PendingCall = getService().updateUser(newnickname, newpassword, uid, password);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	public static function sendPassword(email:String, caller:Object, callback:String):Void
	{
		// passwort an user senden
		var pc:PendingCall = getService().sendPassword(email);
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