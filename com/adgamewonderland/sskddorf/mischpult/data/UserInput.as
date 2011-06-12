/**
 * @author gerd
 */
 
import com.adgamewonderland.sskddorf.mischpult.beans.*;
 
class com.adgamewonderland.sskddorf.mischpult.data.UserInput {
	
	private var familienstand:Familienstand;
	
	private var lebensphase:Lebensphase;
	
	private var planungssumme:Planungssumme;
	
	private var wohnsituation:Wohnsituation;
	
	private var personen:Number;
	
	private var alter:Number;
	
	private var einkommen:Number;
	
	private var wohnkosten:Number;
	
	private var sonstigekosten:Number;
	
	private var verfuegung:Number;
	
	private var lebenshaltungskosten:Number;
	
	private var vorhandene:Array;
	
	public function UserInput() {
		this.familienstand = new Familienstand();
		this.lebensphase = new Lebensphase();
		this.planungssumme = new Planungssumme();
		this.wohnsituation = new Wohnsituation();
		this.personen = 1;
		this.alter = 30;
		this.einkommen = 0;
		this.wohnkosten = 0;
		this.sonstigekosten = 0;
		this.verfuegung = 0;
		this.lebenshaltungskosten = 0;
		this.vorhandene = new Array();
	}

	public function getLebensphase():Lebensphase {
		return lebensphase;
	}

	public function setLebensphase(lebensphase:Lebensphase):Void {
		this.lebensphase = lebensphase;
	}

	public function getEinkommen():Number {
		return einkommen;
	}

	public function setEinkommen(einkommen:Number):Void {
		this.einkommen = Math.max(einkommen, 0);
	}

	public function getSonstigekosten():Number {
		return sonstigekosten;
	}

	public function setSonstigekosten(sonstigekosten:Number):Void {
		this.sonstigekosten = Math.max(sonstigekosten, 0);
	}

	public function getVorhandene():Array {
		return vorhandene;
	}

	public function setVorhandene(vorhandene:Array):Void {
		this.vorhandene = vorhandene;
	}

	public function getPlanungssumme():Planungssumme {
		return planungssumme;
	}

	public function setPlanungssumme(planungssumme:Planungssumme):Void {
		this.planungssumme = planungssumme;
	}

	public function getWohnkosten():Number {
		return wohnkosten;
	}

	public function setWohnkosten(wohnkosten:Number):Void {
		this.wohnkosten = Math.max(wohnkosten, 0);
	}

	public function getFamilienstand():Familienstand {
		return familienstand;
	}

	public function setFamilienstand(familienstand:Familienstand):Void {
		this.familienstand = familienstand;
	}

	public function getVerfuegung():Number {
		return verfuegung;
	}

	public function setVerfuegung(verfuegung:Number):Void {
		this.verfuegung = Math.max(verfuegung, 0);
	}

	public function getWohnsituation():Wohnsituation {
		return wohnsituation;
	}

	public function setWohnsituation(wohnsituation:Wohnsituation):Void {
		this.wohnsituation = wohnsituation;
	}

	public function getPersonen():Number {
		return personen;
	}

	public function setPersonen(personen:Number):Void {
		this.personen = Math.max(personen, 1);
	}

	public function getAlter():Number {
		return alter;
	}

	public function setAlter(alter:Number):Void {
		this.alter = alter;
	}

	public function getLebenshaltungskosten():Number {
		return lebenshaltungskosten;
	}

	public function setLebenshaltungskosten(lebenshaltungskosten:Number):Void {
		this.lebenshaltungskosten = Math.max(lebenshaltungskosten, 0);
	}

}