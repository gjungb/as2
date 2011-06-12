/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.GameStatus {

	public static var STATUS_NONE:Number = 0;

	public static var STATUS_LOGIN:Number = 1;

	public static var STATUS_REGISTER:Number = 2;

	public static var STATUS_CHALLENGE:Number = 3;

	public static var STATUS_DIFFICULTY:Number = 4;

	public static var STATUS_COMPARISON:Number = 5;

	public static var STATUS_SUDOKU:Number = 6;

	public static var STATUS_GAMEOVER:Number = 7;

	public static var STATUS_CHALLENGESENT:Number = 8;

	public static var STATUS_CHALLENGEFINISHED:Number = 9;

	public static var STATUS_AWARD:Number = 10;

	public static var STATUS_TRAINING:Number = 11;

	private var status:Number;

	public function GameStatus(status:Number ) {
		// spielstatus
		this.status = status;
	}

	public function getStatus():Number {
		return status;
	}

	public function setStatus(status:Number):Void {
		this.status = status;
	}

//	public function equals(gamestatus:GameStatus ):Boolean {
//		// stimmen die stati ueberein
//		return (gamestatus.getStatus() === this.getStatus());
//	}

	public function toString() : String {
		return "com.adgamewonderland.duden.sudoku.challenge.beans.GameStatus: " + getStatus();
	}

}