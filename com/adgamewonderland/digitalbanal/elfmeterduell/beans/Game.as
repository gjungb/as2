/**
 * @author gerd
 */
 
import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;
 
class com.adgamewonderland.digitalbanal.elfmeterduell.beans.Game {
	
	public static var STATUS_CHALLENGER_DONE:Number = 1;
	
	public static var STATUS_OPPONENT_DONE:Number = 2;
	
	public static var STATUS_OPPONENT_AWARDED:Number = 3;
	
	public static var STATUS_CHALLENGER_AWARDED:Number = 4;
	
	private var ID:Number;
	
	private var mailid:String;
	
	private var status:Number;
	
	private var winner:Number;
	
	private var gameDetails:Array;
	
	public function Game() {
		// id in herausforderungs email
		this.mailid = "";
		// status
		this.status = 0;
		// sieger
		this.winner = 0;
		// details der beiden spiele (herausforderer / gegner)
		this.gameDetails = new Array();
		
//		Object.registerClass("Game", com.adgamewonderland.digitalbanal.elfmeterduell.beans.Game);
	}

	public function getGameDetails():Array {
		return gameDetails;
	}

	public function setGameDetails(gameDetails:Array):Void {
		this.gameDetails = gameDetails;
	}

	public function getWinner():Number {
		return winner;
	}

	public function setWinner(winner:Number):Void {
		this.winner = winner;
	}

	public function getStatus():Number {
		return status;
	}

	public function setStatus(status:Number):Void {
		this.status = status;
	}

	public function getMailid():String {
		return mailid;
	}

	public function setMailid(mailid:String):Void {
		this.mailid = mailid;
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

}