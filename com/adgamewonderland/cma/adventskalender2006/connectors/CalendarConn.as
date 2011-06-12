import com.adgamewonderland.cma.adventskalender2006.beans.*;
import com.adgamewonderland.cma.adventskalender2006.util.*;

class com.adgamewonderland.cma.adventskalender2006.connectors.CalendarConn implements IEventBroadcaster
{
	private static var HOST:String = "http://www.cma.de";
	private static var PATH:String = "/extensions/games/php/getGSE.php";
	private static var instance:com.adgamewonderland.cma.adventskalender2006.connectors.CalendarConn;
	private var event:com.adgamewonderland.cma.adventskalender2006.util.EventBroadcaster;

	private function CalendarConn()
	{
		// event broadcaster
		this.event = new EventBroadcaster();
	}

	/**
	 * gibt eine Singleton-Instanz des Connectors zurück
	 * @return Singleton-Instanz des Connectors
	 */
	public static function getInstance():com.adgamewonderland.cma.adventskalender2006.connectors.CalendarConn
	{
		if (instance == null)
			instance = new CalendarConn();
		return instance;
	}

	/**
	 * initialisiert das Spiel im Gewinnspiel-Backend
	 * @param spielid für den Adventskalender festgelegte eindeutige id
	 */
	public function initGame(spielid:Number):Void
	{
		// sender
		var sender:LoadVars = new LoadVars();
		// action
		sender.action = "initgame";
		// spielid
		sender.SPIELID = spielid;
		// receiver
		var receiver:LoadVars = new LoadVars();
		// referenz auf event broadcaster
		receiver.event = getEvent();
		// callback
		receiver.onLoad = function () {
			// werte durchschleifen, da kein property/value-paar sondern nur der nackte wert zurueck kommt
			for (var i:String in this) {
				// nur strings
				if (typeof this[i] == "string") {
					// event
					event.send("onInitGame", i);
				}
			}
		};
		// senden
		sender.sendAndLoad(getBackendURL(), receiver, "GET");
	}

	/**
	 * speichert die Eingaben des Users im Gewinnspiel-Backend
	 * @param sessionid aktuelle SESSIONID
	 * @param user Eingaben des Users gekapselt in entsprechendem Bean
	 */
	public function saveUser(sessionid:String, user:com.adgamewonderland.cma.adventskalender2006.beans.User):Void
	{
		// sender
		var sender:LoadVars = new LoadVars();
		// action
		sender.action = "saveuser";
		// sessionid
		sender.SESSIONID = sessionid;
		// userdaten
		sender.TYPE = "GSE";
		sender.NAME = user.getName();
		sender.VNAME = user.getVname();
		sender.STRASSE = user.getStrasse();
		sender.PLZ = user.getPlz();
		sender.ORT = user.getOrt();
		sender.LAND = "";
		sender.EMAIL = user.getEmail();
		sender.TEL = "";
		sender.FAX = "";
		sender.GESCHLECHT = "";
		sender.GEBDAT = "";
		sender.OPT1 = "";
		sender.OPT2 = "";
		sender.UNAME = "";
		sender.PASSWORD = "";
		sender.TEILNAHME = user.isTeilnahme() ? "1" : "0";
		sender.DATENSCHUTZ = user.isDatenschutz() ? "1" : "0";
		sender.NEWSLETTER = user.isNewsletter() ? "1" : "0";
		// receiver
		var receiver:LoadVars = new LoadVars();
		// referenz auf event broadcaster
		receiver.event = getEvent();
		// callback
		receiver.onLoad = function () {
			// werte durchschleifen, da kein property/value-paar sondern nur der nackte wert zurueck kommt
			for (var i:String in this) {
				// nur strings
				if (typeof this[i] == "string") {
					// event
					event.send("onSaveUser", i);
				}
			}
		};
		// senden
		sender.sendAndLoad(getBackendURL(), receiver, "GET");
	}

	/**
	 * lädt die Fragen-IDs aus Gewinnspiel-Backend
	 * @param sessionid aktuelle SESSIONID
	 */
	public function getQuestioncount(sessionid:String):Void
	{
		// sender
		var sender:LoadVars = new LoadVars();
		// action
		sender.action = "getquestioncount";
		// sessionid
		sender.SESSIONID = sessionid;
		// receiver
		var receiver:LoadVars = new LoadVars();
		// referenz auf event broadcaster
		receiver.event = getEvent();
		// callback
		receiver.onLoad = function () {
			// werte durchschleifen, da kein property/value-paar sondern nur der nackte wert zurueck kommt
			for (var i:String in this) {
				// nur strings
				if (typeof this[i] == "string") {
					// event
					event.send("onGetQuestioncount", i);
				}
			}
		};
		// senden
		sender.sendAndLoad(getBackendURL(), receiver, "GET");
	}

	/**
	 * lädt eine Frage aus Gewinnspiel-Backend
	 * @param sessionid aktuelle SESSIONID
	 * @param fid ID der zu ladenden Frage
	 */
	public function getQuestion(sessionid:String, fid:Number):Void
	{
		// sender
		var sender:LoadVars = new LoadVars();
		// action
		sender.action = "getquestion";
		// sessionid
		sender.SESSIONID = sessionid;
		// fid
		sender.FID = fid;
		// receiver
		var receiver:LoadVars = new LoadVars();
		// referenz auf event broadcaster
		receiver.event = getEvent();
		// callback
		receiver.onLoad = function () {
			// gewinnspiel-backend liefert kein UTF-8 !!!!!!!!!!!!!!!
			System.useCodepage = false;
			// werte durchschleifen, da kein property/value-paar sondern nur der nackte wert zurueck kommt
			for (var i:String in this) {
				// nur strings
				if (typeof this[i] == "string") {
					// event
					event.send("onGetQuestion", fid, i);
				}
			}
		};
		// gewinnspiel-backend liefert kein UTF-8 !!!!!!!!!!!!!!!
		System.useCodepage = true;
		// senden
		sender.sendAndLoad(getBackendURL(), receiver, "GET");
	}

	public function addListener(l:Object):Void
	{
		// als listener registrieren
		getEvent().addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		// als listener abmelden
		getEvent().removeListener(Object(l));
	}

	public function setEvent(event:com.adgamewonderland.cma.adventskalender2006.util.EventBroadcaster):Void
	{
		this.event = event;
	}

	public function getEvent():com.adgamewonderland.cma.adventskalender2006.util.EventBroadcaster
	{
		return this.event;
	}

	public function toString():String {
		return "com.adgamewonderland.cma.adventskalender2006.connectors.CalendarConn";
	}

	/**
	 * Gibt den vollständigen Pfad zur Gewinnspiel-Engine zurück
	 * @return Pfad zur Gewinnspiel-Engine (im Standalone-Player mit Protokoll und Host)
	 */
	private function getBackendURL():String
	{
		// unterscheidung standalone vs. browser
		return ((_url.indexOf("http") == -1 ? HOST : "") + PATH);
	}
}