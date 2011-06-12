/**
 * @author gerd
 */
class com.adgamewonderland.aldi.mahjong.util.GameConf {
	
	private var breite:Number;
	
	private var hoehe:Number;
	
	private var xpos:Number;
	
	private var ypos:Number;
	
	private var xversatz:Number;
	
	private var yversatz:Number;
	
	public function GameConf() {
		this.breite = 0;
		this.hoehe = 0;
		this.xpos = 0;
		this.ypos = 0;
		this.xversatz = 0;
		this.yversatz = 0;
	}
	
	public function getHoehe():Number {
		return hoehe;
	}

	public function setHoehe(hoehe:Number):Void {
		this.hoehe = Number(hoehe);
	}

	public function getXpos():Number {
		return xpos;
	}

	public function setXpos(xpos:Number):Void {
		this.xpos = Number(xpos);
	}

	public function getBreite():Number {
		return breite;
	}

	public function setBreite(breite:Number):Void {
		this.breite = Number(breite);
	}

	public function getYpos():Number {
		return ypos;
	}

	public function setYpos(ypos:Number):Void {
		this.ypos = Number(ypos);
	}

	public function getXversatz():Number {
		return xversatz;
	}

	public function setXversatz(xversatz:Number):Void {
		this.xversatz = Number(xversatz);
	}

	public function getYversatz():Number {
		return yversatz;
	}

	public function setYversatz(yversatz:Number):Void {
		this.yversatz = Number(yversatz);
	}

}