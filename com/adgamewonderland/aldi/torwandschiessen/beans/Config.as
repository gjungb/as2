/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.aldi.torwandschiessen.beans.Config {
	
	private var round:Number;
	
	private var seconds:Number;
	
	private var changeHoles:Boolean;
	
	public function Config(round:Number, seconds:Number, changeHoles:Boolean) {
		this.round = round;
		this.seconds = seconds;
		this.changeHoles = changeHoles;
	}
	
	public function getSeconds():Number {
		return seconds;
	}

	public function setSeconds(seconds:Number):Void {
		this.seconds = seconds;
	}

	public function getChangeHoles():Boolean {
		return changeHoles;
	}

	public function setChangeHoles(changeHoles:Boolean):Void {
		this.changeHoles = changeHoles;
	}

	public function getRound():Number {
		return round;
	}

	public function setRound(round:Number):Void {
		this.round = round;
	}

}