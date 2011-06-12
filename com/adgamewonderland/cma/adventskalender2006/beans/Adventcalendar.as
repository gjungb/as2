import com.adgamewonderland.cma.adventskalender2006.beans.*;

import com.adgamewonderland.cma.adventskalender2006.connectors.*;

import com.adgamewonderland.cma.adventskalender2006.util.*;

/**
 * Singleton zur zentralen Steuerung des Adventskalenders
 */
class com.adgamewonderland.cma.adventskalender2006.beans.Adventcalendar implements IConnectorListener, IEventBroadcaster 
{
	private static var SPIELID:Number = 153;
	private static var instance:Adventcalendar;
	private var event:com.adgamewonderland.cma.adventskalender2006.util.EventBroadcaster;
	private var today:Date;
	private var days:Array;
	private var sessionid:String;
	private var questionids:Array;
	private var selectedday:Day;
	private var user:com.adgamewonderland.cma.adventskalender2006.beans.User;
	private var recipelist:com.adgamewonderland.cma.adventskalender2006.beans.RecipeList;
	private var linklist:com.adgamewonderland.cma.adventskalender2006.beans.LinkList;

	private function Adventcalendar()
	{
		// event broadcaster
		this.event = new EventBroadcaster();
		// aktueller kalendertag
		this.today = new Date();
		// array aller kalendertage
		this.days = new Array();
		// tage befuellen
		for (var i:Number = 1; i <= 24; i++) {
			addDays(new Day(i));
		}
		// sessionid zur kommunikation mit dem gewinnspiel-backend
		this.sessionid = "";
		// ids aller fragen aus dem gewinnspiel-backend
		this.questionids = new Array();
		// kalendertag, an dem der user spielen moechte
		this.selectedday = null;
		// teilnehmer, der aktuell spielt (in lso gespeichert)
		this.user = CalendarUtils.loadUserLocal();
		// liste mit rezepten
		this.recipelist = null;
		// liste mit links zu weiterführenden informationen
		this.linklist = null;
	}

	/**
	 * gibt eine Singleton-Instanz des Adventskalenders zurück
	 * @return Singleton-Instanz des Adventskalenders
	 */
	public static function getInstance():Adventcalendar
	{
		if (instance == null)
			instance = new Adventcalendar();
		return instance;
	}
	
	/**
	 * initialisiert den Kalender auf das aktuelle Datum
	 * @param timestamp aktuelle Timestamp
	 */
	public function initCalendar(timestamp:Number):Void
	{
		// aktuelles datum
		var now:Date = new Date();
		// neues datum
		if (timestamp != undefined) {
			// umwandlung unix timestamp in as millisekunden
			now.setTime(timestamp * 1000); 
		} else {
//			// aktuelles datum, aber im dezember
//			now.setMonth(11);
//			// DEBUG: 22.12.
//			now.setDate(22);
		}
		// aktuelles datum
		setToday(now);
		// liste mit rezepten
		setRecipelist(new RecipeList());
		// liste mit links zu weiterführenden informationen
		setLinklist(new LinkList());
		// als listener beim connector registrieren
		CalendarConn.getInstance().addListener(this);
		// session auf backend starten
		CalendarConn.getInstance().initGame(SPIELID);
	}

	/**
	 * callback nach der Initialisierung im Backend
	 * @param sessionid Session-ID, die als Übergabeparameter für die nachfolgenden Funtionen dient
	 */
	public function onInitGame(sessionid:String):Void
	{
		// sessionid speichern
		setSessionid(sessionid);
		// fragen-anzahl laden
		CalendarConn.getInstance().getQuestioncount(getSessionid());
	}

	/**
	 * callback nach dem Speichern der Userdaten
	 * @param uid User-ID, wird nicht weiter verwendet	 
	*/
	public function onSaveUser(uid:Number):Void
	{
	}

	/**
	 * callback nach der Ermittlung der Fragen-Anzahl im Backend
	 * @param fids Fragen-IDs kommasepariert
	 */
	public function onGetQuestioncount(fids:String):Void
	{
		// ids aller fragen aus dem gewinnspiel-backend
		setQuestionids(fids.split(","));
	}
	
	/**
	 * Quiz des übergebenen Tages starten (Frage laden, QuizUI starten)
	 * @param day Kalendertag, an dem gespielt wird
	 */
	public function startQuiz(day:Day):Void
	{
		// kalendertag, an dem der user spielen moechte
		setSelectedday(day);
		// id der frage
		var fid:Number = getQuestionids()[day.getId() - 1];
		// frage laden
		CalendarConn.getInstance().getQuestion(getSessionid(), fid);
	}

	/**
	 * callback nach der Ermittlung einer Frage im Backend
	 * @param fid Frage-ID
	 * @param csv Frage und Antworten gemäß Dokumentation Backend
	 */
	public function onGetQuestion(fid:Number, csv:String):Void
	{
		// in frage bean umwandeln lassen
		var question:Question = CalendarUtils.parseQuestion(fid, csv);
		// neues quiz
		var quiz:Quiz = new Quiz(question, getSelectedday());
		// event
		getEvent().send("onStartQuiz", quiz);
	}
	
	/**
	 * Beantwortung einer Frage
	 * @param answer gegebene Antwort
	 */
	public function answerQuestion(answer:Answer):Void
	{
		// event
		getEvent().send("onAnswerQuestion", answer);
	}
	
	/**
	 * Gewinnerdaten an Backend übermitteln
	 * @param user Teilnehmerdaten des Spielers
	 */
	public function saveUser(user:User):Void
	{
		// daten lokal speichern
		CalendarUtils.saveUserLocal(user);
		// daten uebergeben
		CalendarConn.getInstance().saveUser(getSessionid(), user);
	}
	
	/**
	 * Quiz beenden
	 */
	public function stopQuiz():Void
	{
		// event
		getEvent().send("onStopQuiz");
	}

	public function addDays(days:com.adgamewonderland.cma.adventskalender2006.beans.Day):Void
	{
		this.days.push(days);
	}

	public function removeDays(days:com.adgamewonderland.cma.adventskalender2006.beans.Day):Void
	{
		for (var i:Number = 0; i < this.days.length; i++)
		{
			if (this.days[i] == days)
			{
				this.days.splice(i, 1);
			}
		}
	}

	public function toDaysArray():Array
	{
		return this.days;
	}

	/**
	 * Gibt einen Kalendertag anhand seiner id zurück
	 * @param id id des Kalendertages
	 * @return Kalendertag
	 */
	public function getDayById(id:Number):com.adgamewonderland.cma.adventskalender2006.beans.Day
	{
		// gesuchter tag
		var day:Day;
		// schleife ueber alle tage
		for (var i:String in this.days) {
			// aktueller tag
			day = Day(this.days[i]);
			// testen, ob gefunden
			if (day.getId() == id) {
				// zurueck geben
				return day;	
			}
		}
		// nicht gefunden
		return null;
	}

	public function setRecipelist(recipelist:com.adgamewonderland.cma.adventskalender2006.beans.RecipeList):Void
	{
		this.recipelist = recipelist;
	}

	public function getRecipelist():com.adgamewonderland.cma.adventskalender2006.beans.RecipeList
	{
		return this.recipelist;
	}

	public function setLinklist(linklist:com.adgamewonderland.cma.adventskalender2006.beans.LinkList):Void
	{
		this.linklist = linklist;
	}

	public function getLinklist():com.adgamewonderland.cma.adventskalender2006.beans.LinkList
	{
		return this.linklist;
	}

	public function setUser(user:com.adgamewonderland.cma.adventskalender2006.beans.User):Void
	{
		this.user = user;
	}

	public function getUser():com.adgamewonderland.cma.adventskalender2006.beans.User
	{
		return this.user;
	}

	public function setToday(today:Date):Void
	{
		this.today = today;
	}

	public function getToday():Date
	{
		return this.today;
	}

	public function setSessionid(sessionid:String):Void
	{
		this.sessionid = sessionid;
	}

	public function getSessionid():String
	{
		return this.sessionid;
	}

	public function getQuestionids():Array {
		return questionids;
	}

	public function setQuestionids(questionids:Array):Void {
		this.questionids = questionids;
	}

	public function getSelectedday():Day {
		return selectedday;
	}

	public function setSelectedday(selectedday:Day):Void {
		this.selectedday = selectedday;
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
		return "com.adgamewonderland.cma.adventskalender2006.beans.Adventcalendar";
	}


}