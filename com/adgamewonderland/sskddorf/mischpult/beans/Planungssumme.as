/**
 * @author gerd
 */
class com.adgamewonderland.sskddorf.mischpult.beans.Planungssumme {
	
	private var ID:Number;
	
	private var summemin:Number;
	
	private var summemax:Number;
	
	private var summeact:Number;
	
	public function Planungssumme() {
		this.ID = 0;
		this.summemin = 0;
		this.summemax = 0;
		this.summeact = 0;
	}
	
	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getSummemin():Number {
		return summemin;
	}

	public function setSummemin(summemin:Number):Void {
		this.summemin = summemin;
	}

	public function getSummemax():Number {
		return summemax;
	}

	public function setSummemax(summemax:Number):Void {
		this.summemax = summemax;
	}
	
	public function toString():String
	{
		return(getID() + ": " + getSummemin() + " - " + getSummemax());	
	}

	public function getSummeact():Number {
		return summeact;
	}

	public function setSummeact(summeact:Number):Void {
		if (summeact < 0) summeact = 0;
		this.summeact = summeact;
	}

}