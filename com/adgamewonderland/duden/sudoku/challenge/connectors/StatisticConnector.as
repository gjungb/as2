import mx.remoting.Service;
import mx.remoting.debug.NetDebug;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
class com.adgamewonderland.duden.sudoku.challenge.connectors.StatisticConnector
{

	private static var myGatewayURL:String = "http://webbox/flashservices/gateway.php";

	private static var myRemoteObject:String = "com.adgamewonderland.duden.sudoku.challenge.connectors.StatisticConnector";

	private static var myService:Service;

	/**
	 * Lädt die Highscoreliste aus der Datenbank.
	 * @param startat Ab welcher Platzierung soll die Highscoreliste geladen werden
	 * @param count Wie viele Platzierungen sollen geladen werden
	 */
	public static function loadHighscoreList(startat:Number, count:Number, caller:Object, callback:String ):Void
	{
		// highscoreliste laden
		var pc:PendingCall = getService().loadHighscoreList(startat, count);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	/**
	 * Lädt die Platzierung, die ein User mit dieser Puntkzahl in der Highscoreliste hat. Die Platzierung entspricht der Anzahl der Datensätze in der View Highscore, bei denen die Punktzahl höher ist als der übergebene Wert
	 * @param score Punktzahl des Users
	 */
	public static function loadRank(score:Number, caller:Object, callback:String ):Void
	{
		// herausforderungs- / siegerehrungsliste laden
		var pc:PendingCall = getService().loadRank(score);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

	/**
	 * Lädt die Herausforderungs- / Siegerehrungsliste Als Rückgabe wird das unverarbeitete ResultSet genommen, das durch ein SELECT auf die View ChallengeList generiert wird.
	 * @access remote
	 * @param userid ID des Users, für den die Liste geladen wird
	 * @param mode Modus der ChallengeDetails (siehe statische Felder MODE_)
	 * @param status Status der Challenge (siehe statische Felder STATUS_)
	 */
	public static function loadChallengeList(userid:Number, mode:Number, status:Number, caller:Object, callback:String ):Void
	{
		// herausforderungs- / siegerehrungsliste laden
		var pc:PendingCall = getService().loadChallengeList(userid, mode, status);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}

    /**
     * Schaltet Sichtbarkeit einer Herausforderung in der Liste der Herausforderungen / Siegerehrungen um
     * @access remote
     * @param integer did ChallengeDetail ID
     * @param integer uid User ID
     * @param boolean show gewünschte Sichtbarkeit
     */
    public static function setShowinlist(did:Number, userid:Number, show:Boolean, caller:Object, callback:String ) {
		// sichtbarkeit umschalten
		var pc:PendingCall = getService().setShowinlist(did, userid, show);
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