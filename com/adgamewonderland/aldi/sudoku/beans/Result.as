/**
 * @author gerd
 */
class com.adgamewonderland.aldi.sudoku.beans.Result {
	
	public static var TIME_OPEN:Number = -1;
	
	private var date:Date;
	
	private var difficulty:Number;
	
	private var time:Number;
	
	public function Result() {
		this.date = new Date();
		this.difficulty = null;
		this.time = TIME_OPEN;
	}
	
	public function getDate():Date {
		return date;
	}

	public function setDate(date:Date):Void {
		this.date = date;
	}

	public function getTime():Number {
		return time;
	}

	public function setTime(time:Number):Void {
		this.time = time;
	}

	public function getDifficulty():Number {
		return difficulty;
	}

	public function setDifficulty(difficulty:Number):Void {
		this.difficulty = difficulty;
	}
	
	public function toString():String
	{
		return (getDate().toLocaleString() + ", " + getDifficulty() + ", " + getTime());
	}

}