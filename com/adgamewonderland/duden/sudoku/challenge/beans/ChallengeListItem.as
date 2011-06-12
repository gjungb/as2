class com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeListItem
{
	private var did:Number;
	private var cid:Number;
	private var mode:Number;
	private var uid:Number;
	private var nickname:String;
	private var status:Number;
	private var hashkey:String;

	public function ChallengeListItem()
	{
		this.did = 0;
		this.cid = 0;
		this.mode = 0;
		this.uid = 0;
		this.nickname = "";
		this.status = 0;
		this.hashkey = "";
	}

	public function setCid(cid:Number):Void
	{
		this.cid = cid;
	}

	public function getCid():Number
	{
		return this.cid;
	}

	public function setDid(did:Number):Void
	{
		this.did = did;
	}

	public function getDid():Number
	{
		return this.did;
	}

	public function setNickname(nickname:String):Void
	{
		this.nickname = nickname;
	}

	public function getNickname():String
	{
		return this.nickname;
	}

	public function setHashkey(hashkey:String):Void
	{
		this.hashkey = hashkey;
	}

	public function getHashkey():String
	{
		return this.hashkey;
	}

	public function setUid(uid:Number):Void
	{
		this.uid = uid;
	}

	public function getUid():Number
	{
		return this.uid;
	}

	public function setStatus(status:Number):Void
	{
		this.status = status;
	}

	public function getStatus():Number
	{
		return this.status;
	}

	public function setMode(mode:Number):Void
	{
		this.mode = mode;
	}

	public function getMode():Number
	{
		return this.mode;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeListItem\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}