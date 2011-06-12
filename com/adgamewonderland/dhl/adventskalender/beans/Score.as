/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventskalender.beans.*; 

class com.adgamewonderland.dhl.adventskalender.beans.Score {
	
	private var gid:Number;
	
	private var user:User;
	
	private var score:Number;
	
	public function Score() {
		gid = null;
		user = new User();
		score = 0;
	}
	
	public function getScore():Number {
		return score;
	}

	public function setScore(score:Number):Void {
		this.score = score;
	}

	public function getGid():Number {
		return gid;
	}

	public function setGid(gid:Number):Void {
		this.gid = gid;
	}

	public function getUser():User {
		return user;
	}

	public function setUser(user:User):Void {
		this.user = user;
	}

}