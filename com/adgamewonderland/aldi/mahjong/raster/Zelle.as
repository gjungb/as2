/**
 * @author gerd
 */

class com.adgamewonderland.aldi.mahjong.raster.Zelle {
	
	private var belegung:Boolean;
	
	private var owner:Number;
	
	public function Zelle() {
		belegung = false;
		owner = 0;
	}
	
	public function init():Void
	{
		belegung = false;
		owner = 0;
	}
	
	public function getBelegung():Boolean {
		return belegung;
	}

	public function setBelegung(belegung:Boolean):Void {
		this.belegung = belegung;
	}

	public function getOwner():Number {
		return owner;
	}

	public function setOwner(owner:Number):Void {
		this.owner = owner;
	}

}