import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.remoting.debug.NetDebug;
/**
 * @author gerd
 */
class com.adgamewonderland.ricola.sudoku.connectors.SudokuConnector {
	
	private static var myGatewayURL:String = "http://webbox/flashservices/gateway.php";
	
	private static var myRemoteObject:String = "com.adgamewonderland.ricola.sudoku.connectors.SudokuConnector";
	
	private static var myService:Service;
		
	// solution laden	
	public static function loadSudoku(difficulty:Number, caller:Object, callback:String ):Void
	{
		// senden
		var pc:PendingCall = getService().loadSudoku(difficulty);
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