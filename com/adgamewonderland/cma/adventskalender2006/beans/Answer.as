/**
 * eine Antwort
 */
class com.adgamewonderland.cma.adventskalender2006.beans.Answer 
{
	private var antwortid:Number;
	private var antworttext:String;
	private var antwort_ok:Boolean;

	public function Answer(antwortid:Number, antworttext:String, antwort_ok:Boolean)
	{
		// ids der antwort aus dem gewinnspiel-backend
		this.antwortid = antwortid;
		// text der antwort
		this.antworttext = antworttext;
		// ist die antwort korrekt
		this.antwort_ok = antwort_ok;
	}

	public function setAntwortid(antwortid:Number):Void
	{
		this.antwortid = antwortid;
	}

	public function getAntwortid():Number
	{
		return this.antwortid;
	}

	public function setAntworttext(antworttext:String):Void
	{
		this.antworttext = antworttext;
	}

	public function getAntworttext():String
	{
		return this.antworttext;
	}

	public function setAntwort_ok(antwort_ok:Boolean):Void
	{
		this.antwort_ok = antwort_ok;
	}

	public function isAntwort_ok():Boolean
	{
		return this.antwort_ok;
	}
	
	public function toString():String {
		return "Answer " + getAntwortid() + ": " + getAntworttext() + ", " + isAntwort_ok();
	}
}