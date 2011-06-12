import com.adgamewonderland.duden.sudoku.challenge.beans.Toptime;
/**
 *
 * Statistische Angaben zum User, die z.T. nur für interne Zwecke verwendet werden, z.T. im Client angezeigt werden.
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Statistics
{
	private var ID:Number;
	/**
	 *
	 * Datum des ersten Logins des Users (für statistische Zwecke)
	 */
	private var firstlogin:Date;
	/**
	 *
	 * Datum des letzten Logins des Users (für statistische Zwecke)
	 */
	private var lastlogin:Date;
	/**
	 *
	 * Anzahl der Logins des Users (für statistische Zwecke)
	 */
	private var numlogins:Number;
	/**
	 *
	 * Anzahl der Spiele, an denen der User teilgenommen hat
	 */
	private var numgames:Number;
	/**
	 *
	 * Anzahl der Spiele, die der User gewonnen hat
	 */
	private var gameswon:Number;
	/**
	 *
	 * Anzahl der Spiele, die der User verloren hat
	 */
	private var gameslost:Number;
	/**
	 *
	 * Anzahl der Spiele des Users, die unentschieden endeten
	 */
	private var gamesdrawn:Number;
	/**
	 *
	 * Gesamtpunktzahl des Users
	 */
	private var score:Number;
	/**
	 * Bestzeiten des Users
	 */
	private var toptimes:Array; //  = new Array();

	public function Statistics()
	{
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Statistics", Statistics);
	}

	/**
	 * Verhältnis von gewonnen zu gesamten Spielen
	 * @return Gibt das Zahlenverhältnis der gewonnen zu den gesamten Spielen als Prozentzahl zurück
	 */
	public function getPorportion():Number
	{
		// 0 spiele abfangen
		if (getNumgames() == 0) return 0;
		// verhaeltnis
		var proportion:Number = Math.round(getGameswon() / getNumgames() * 100);
		// zurueck geben
		return proportion;
	}

	/**
	 * Fügt eine Bestzeit eines Schwierigkeitsgrades hinzu
	 * @param id ID aus Datenbank
	 * @param difficulty Schwierigkeitsgrad
	 * @param time Spielzeit
	 */
	public function addToptime(id:Number, difficulty:Number, time:Number ):Void
	{
		// neue toptime
		var toptime:Toptime = new Toptime();
		// id
		toptime.setID(id);
		// difficulty
		toptime.setDifficulty(difficulty);
		// time
		toptime.setTime(time);
		// zum array hinzufuegen
		this.toptimes[difficulty] = toptime;
	}

	/**
	 * Gibt die Bestzeit eines Schwierigkeitsgrades zurück
	 * @param difficulty Schwierigkeitsgrad
	 * @return Toptime Bestzeit
	 */
	public function getToptime(difficulty:Number ):Toptime
	{
		// bestzeit
		var toptime:Toptime = null;
		// testen, ob vorhanden
		if (difficulty > 0 && difficulty <= getToptimes().length) {
			// gesuchte bestzeit
			toptime = getToptimes()[difficulty];
		}
		// zurueck geben
		return toptime;
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setFirstlogin(firstlogin:Date):Void
	{
		this.firstlogin = firstlogin;
	}

	public function getFirstlogin():Date
	{
		return this.firstlogin;
	}

	public function setLastlogin(lastlogin:Date):Void
	{
		this.lastlogin = lastlogin;
	}

	public function getLastlogin():Date
	{
		return this.lastlogin;
	}

	public function setNumlogins(numlogins:Number):Void
	{
		this.numlogins = numlogins;
	}

	public function getNumlogins():Number
	{
		return this.numlogins;
	}

	public function setNumgames(numgames:Number):Void
	{
		this.numgames = numgames;
	}

	public function getNumgames():Number
	{
		return this.numgames;
	}

	public function setGameswon(gameswon:Number):Void
	{
		this.gameswon = gameswon;
	}

	public function getGameswon():Number
	{
		return this.gameswon;
	}

	public function setGameslost(gameslost:Number):Void
	{
		this.gameslost = gameslost;
	}

	public function getGameslost():Number
	{
		return this.gameslost;
	}

	public function setGamesdrawn(gamesdrawn:Number):Void
	{
		this.gamesdrawn = gamesdrawn;
	}

	public function getGamesdrawn():Number
	{
		return this.gamesdrawn;
	}

	public function setScore(score:Number):Void
	{
		this.score = score;
	}

	public function getScore():Number
	{
		return this.score;
	}

	public function setToptimes(toptimes:Array):Void
	{
		// toptimes casten
		for (var i:String in toptimes) {
			// aktuelle toptime
			var toptime:Object = toptimes[i];
			// ungueltige ueberspringen
			if (toptime == undefined) continue;
			// zur statistik hinzufuegen
			addToptime(toptime["ID"], toptime["difficulty"], toptime["time"]);
		}
	}

	public function getToptimes():Array
	{
		return this.toptimes;
	}
}