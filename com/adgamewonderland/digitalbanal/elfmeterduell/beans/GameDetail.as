/**
 * @author gerd
 */
 
import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;
 
class com.adgamewonderland.digitalbanal.elfmeterduell.beans.GameDetail {
	
	public static var MODE_CHALLENGER:Number = 0;
	
	public static var MODE_OPPONENT:Number = 1;
	
	private var ID:Number;
	
	private var mode:Number;
	
	private var offense:String;
	
	private var defense:String;
	
	private var showinlist:Boolean;
	
	private var score:Number;
	
	private var goals:Number;
	
	private var user:User;
	
	private var opponent:String;
	
	public function GameDetail(mode:Number  ) {
		// spielmodus
		this.mode = mode;
		// angriff
		this.offense = "";
		// verteidigung
		this.defense = "";
		// in liste anzeigen
		this.showinlist = true;
		// erzielte punktzahl
		this.score = 0;
		// anzahl geschossener tore
		this.goals = 0;
		// user
		this.user = new User();
		// email des gegners
		this.opponent = "";
		
//		Object.registerClass("GameDetail", com.adgamewonderland.digitalbanal.elfmeterduell.beans.GameDetail);
	}
	
	public function getOffense():String {
		return offense;
	}

	public function setOffense(offense:String):Void {
		this.offense = offense;
	}

	public function getShowinlist():Boolean {
		return showinlist;
	}

	public function setShowinlist(showinlist:Boolean):Void {
		this.showinlist = showinlist;
	}

	public function getDefense():String {
		return defense;
	}

	public function setDefense(defense:String):Void {
		this.defense = defense;
	}

	public function getMode():Number {
		return mode;
	}

	public function setMode(mode:Number):Void {
		this.mode = mode;
	}

	public function getScore():Number {
		return score;
	}

	public function setScore(score:Number):Void {
		this.score = score;
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getUser():User {
		return user;
	}

	public function setUser(user:User):Void {
		this.user = user;
	}
	
	public function toString():String
	{
		return ("GameDetail: " + getMode() + " " + getID())	;
	}

	public function getOpponent():String {
		return opponent;
	}

	public function setOpponent(opponent:String):Void {
		this.opponent = opponent;
	}

	public function getGoals():Number {
		return goals;
	}

	public function setGoals(goals:Number):Void {
		this.goals = goals;
	}

}