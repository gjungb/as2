/**
 * @author gerd
 */
class com.adgamewonderland.aldi.util.Security {
	
	private static var instance : Security;
	
	private var hash:String;
	
	/**
	 * @return singleton instance of Security
	 */
	public static function getInstance() : Security
	{
		if (instance == null)
			instance = new Security();
		return instance;
	}
	
	public function setHash(hash:String ):Void
	{
		// als array
		var rev:Array = hash.split("");
		// umdrehen
		rev.reverse();
		// speichern
		this.hash = rev.join("");
	}
	
	public function getHash():String {
		return this.hash;
	}
	
	private function Security()
	{
		// hashkey fuer verschluesselung
		this.hash = "";	
	}

}