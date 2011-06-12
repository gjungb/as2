class com.adgamewonderland.duden.sudoku.challenge.beans.HighscoreListItem 
{
	private var userid:Number;
	private var nickname:String;
	private var email:String;
	private var score:Number;

	public function HighscoreListItem()
	{
		// Not yet implemented
	}

	public function setUserid(userid:Number):Void
	{
		this.userid = userid;
	}

	public function getUserid():Number
	{
		return this.userid;
	}

	public function setNickname(nickname:String):Void
	{
		this.nickname = nickname;
	}

	public function getNickname():String
	{
		return this.nickname;
	}

	public function setEmail(email:String):Void
	{
		this.email = email;
	}

	public function getEmail():String
	{
		return this.email;
	}

	public function setScore(score:Number):Void
	{
		this.score = score;
	}

	public function getScore():Number
	{
		return this.score;
	}
}