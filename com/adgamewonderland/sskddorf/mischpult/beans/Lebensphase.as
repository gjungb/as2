/**
 * @author gerd
 */
class com.adgamewonderland.sskddorf.mischpult.beans.Lebensphase {
	
	private var ID:Number;
	
	private var name:String;
	
	private var altermin:Number;
	
	private var altermax:Number;
	
	public function Lebensphase() {
		this.ID = 0;
		this.name = "";
		this.altermin = 0;
		this.altermax = 0;
	}
	
	public function getAltermin():Number {
		return altermin;
	}

	public function setAltermin(altermin:Number):Void {
		this.altermin = altermin;
	}

	public function getName():String {
		return name;
	}

	public function setName(name:String):Void {
		this.name = name;
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getAltermax():Number {
		return altermax;
	}

	public function setAltermax(altermax:Number):Void {
		this.altermax = altermax;
	}
	
	public function toString():String
	{
		return(getID() + ": " + getName() + ", " + getAltermin() + " - " + getAltermax());	
	}

}