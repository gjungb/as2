/**
 * @author gerd
 */
class com.adgamewonderland.sskddorf.mischpult.beans.Wohnsituation {
	
	private var ID:Number;
	
	private var name:String;
	
	public function Wohnsituation() {
		this.ID = 0;
		this.name = "";
	}
	
	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getName():String {
		return name;
	}

	public function setName(name:String):Void {
		this.name = name;
	}
	
	public function toString():String
	{
		return(getID() + ": " + getName());	
	}
}