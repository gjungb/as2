/**
 * @author gerd
 */
class com.adgamewonderland.digitalbanal.elfmeterduell.beans.Statistics {
	
	private var statisticsID:Number;
	
	private var firstlogin:Date;
	
	private var lastlogin:Date;
	
	private var numlogins:Number;
	
	private var numgames:Number;
	
	private var gameswon:Number;
	
	private var gameslost:Number;
	
	private var gamesdrawn:Number;
	
	private var goalsoffense:Number;
	
	private var goalsdefense:Number;
	
	private var goalsmissed:Number;
	
	private var score:Number;
	
	private var rank:Number;
	
	public function Statistics() {
		this.statisticsID = null;
		this.firstlogin = null;
		this.lastlogin = null;
		this.numlogins = 0;
		this.numgames = 0;
		this.gameswon = 0;
		this.gameslost = 0;
		this.gamesdrawn = 0;
		this.goalsoffense = 0;
		this.goalsdefense = 0;
		this.goalsmissed = 0;
		this.score = 0;
		this.rank = 0;
		
//		Object.registerClass("Statistics", com.adgamewonderland.digitalbanal.elfmeterduell.beans.Statistics);
	}
	
	public function getGameslost():Number {
		return gameslost;
	}

	public function setGameslost(gameslost:Number):Void {
		this.gameslost = gameslost;
	}

	public function getScore():Number {
		return score;
	}

	public function setScore(score:Number):Void {
		this.score = score;
	}

	public function getNumlogins():Number {
		return numlogins;
	}

	public function setNumlogins(numlogins:Number):Void {
		this.numlogins = numlogins;
	}

	public function getGameswon():Number {
		return gameswon;
	}

	public function setGameswon(gameswon:Number):Void {
		this.gameswon = gameswon;
	}

	public function getFirstlogin():Date {
		return firstlogin;
	}

	public function setFirstlogin(firstlogin:Date):Void {
		this.firstlogin = firstlogin;
	}

	public function getLastlogin():Date {
		return lastlogin;
	}

	public function setLastlogin(lastlogin:Date):Void {
		this.lastlogin = lastlogin;
	}

	public function getGoalsdefense():Number {
		return goalsdefense;
	}

	public function setGoalsdefense(goalsdefense:Number):Void {
		this.goalsdefense = goalsdefense;
	}

	public function getGoalsmissed():Number {
		return goalsmissed;
	}

	public function setGoalsmissed(goalsmissed:Number):Void {
		this.goalsmissed = goalsmissed;
	}

	public function getNumgames():Number {
		return numgames;
	}

	public function setNumgames(numgames:Number):Void {
		this.numgames = numgames;
	}

	public function getGoalsoffense():Number {
		return goalsoffense;
	}

	public function setGoalsoffense(goalsoffense:Number):Void {
		this.goalsoffense = goalsoffense;
	}

	public function getGamesdrawn():Number {
		return gamesdrawn;
	}

	public function setGamesdrawn(gamesdrawn:Number):Void {
		this.gamesdrawn = gamesdrawn;
	}

	public function getStatisticsID():Number {
		return statisticsID;
	}

	public function setStatisticsID(statisticsID:Number):Void {
		this.statisticsID = statisticsID;
	}

	public function getRank():Number {
		return rank;
	}

	public function setRank(rank:Number):Void {
		this.rank = rank;
	}

}