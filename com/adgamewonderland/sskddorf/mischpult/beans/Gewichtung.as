/**
 * @author gerd
 */
 
import com.adgamewonderland.sskddorf.mischpult.beans.*;

class com.adgamewonderland.sskddorf.mischpult.beans.Gewichtung {
	
	private var ID:Number;
	
	private var wert:Number;
	
	private var lebensphase:Lebensphase;
	
	private var familienstand:Familienstand;
	
	private var produktkategorie:Produktkategorie;
	
	private var planungssumme:Planungssumme;
	
	public function Gewichtung() {
		this.ID = 0;
		this.wert = 0;
		this.lebensphase = null;
		this.familienstand = null;
		this.produktkategorie = null;
		this.planungssumme = null;
	}
	
	public function getWert():Number {
		return wert;
	}

	public function setWert(wert:Number):Void {
		this.wert = wert;
	}

	public function getFamilienstand():Familienstand {
		return familienstand;
	}

	public function setFamilienstand(familienstand:Familienstand):Void {
		this.familienstand = familienstand;
	}

	public function getProduktkategorie():Produktkategorie {
		return produktkategorie;
	}

	public function setProduktkategorie(produktkategorie:Produktkategorie):Void {
		this.produktkategorie = produktkategorie;
	}

	public function getLebensphase():Lebensphase {
		return lebensphase;
	}

	public function setLebensphase(lebensphase:Lebensphase):Void {
		this.lebensphase = lebensphase;
	}

	public function getPlanungssumme():Planungssumme {
		return planungssumme;
	}

	public function setPlanungssumme(planungssumme:Planungssumme):Void {
		this.planungssumme = planungssumme;
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}
	
	public function toString():String
	{
		return(getID() + ": " + getWert() + ", " + getLebensphase() + ", " + getFamilienstand() + ", " + getProduktkategorie() + ", " + getPlanungssumme());	
	}

}