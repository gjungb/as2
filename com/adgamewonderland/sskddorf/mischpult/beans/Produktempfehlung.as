/**
 * @author gerd
 */
 
import com.adgamewonderland.sskddorf.mischpult.beans.*;

class com.adgamewonderland.sskddorf.mischpult.beans.Produktempfehlung {
	
	private var ID:Number;
	
	private var produkt:Produkt;
	
	private var lebensphase:Lebensphase;
	
	private var familienstand:Familienstand;
	
	public function Produktempfehlung() {
		this.ID = 0;
		this.produkt = null;
		this.lebensphase = null;
		this.familienstand = null;
	}

	public function getFamilienstand():Familienstand {
		return familienstand;
	}

	public function setFamilienstand(familienstand:Familienstand):Void {
		this.familienstand = familienstand;
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getLebensphase():Lebensphase {
		return lebensphase;
	}

	public function setLebensphase(lebensphase:Lebensphase):Void {
		this.lebensphase = lebensphase;
	}

	public function getProdukt():Produkt {
		return produkt;
	}

	public function setProdukt(produkt:Produkt):Void {
		this.produkt = produkt;
	}

}