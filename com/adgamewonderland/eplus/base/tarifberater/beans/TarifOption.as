/**
 * @author harry
 */
class com.adgamewonderland.eplus.base.tarifberater.beans.TarifOption 
{
	private var option:String = "";
	private var check:Boolean = false;

	public function TarifOption(aOption:String, aCheck:Boolean)
	{
		this.option = aOption;
		this.check = aCheck;
	}

	/**
	 * @return the option
	 */
	public function getOption():String
	{
		// Not yet implemented
		return this.option;
	}

	/**
	 * @param option the option to set
	 */
	public function setOption(aOption:String):Void
	{
		this.option = aOption;
	}

	/**
	 * @return the check
	 */
	public function getCheck():Boolean
	{
		// Not yet implemented
		return this.check;
	}

	/**
	 * @param check the check to set
	 */
	public function setCheck(aCheck:Boolean):Void
	{
		this.check = aCheck;
	}

	/**
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public function toString():String
	{
		var ret : String = "";
		for (var i : String in this) {
			ret += i + ": " + this[i] + "\n";
		}
		return ret;
	}
}
