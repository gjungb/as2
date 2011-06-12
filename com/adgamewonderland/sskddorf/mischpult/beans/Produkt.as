/**
 * @author gerd
 */
 
import com.adgamewonderland.sskddorf.mischpult.beans.*;
 
class com.adgamewonderland.sskddorf.mischpult.beans.Produkt {
	
	private var ID:Number;
	
	private var nameempfehlung:String;
	
	private var pfad:String;
	
	private var namevorhanden:String;
	
	private var nameinfos:String;
	
	private var kurzaussagen:String;
	
	private var kurzinfos:String;
	
	private var onlineabschliessbar:Boolean;
	
	private var abwaehlbar:Boolean;
	
	private var produktkategorie:Produktkategorie;
	
	public function Produkt() {
		this.ID = 0;
		this.nameempfehlung = "";
		this.pfad = "";
		this.namevorhanden = "";
		this.nameinfos = "";
		this.kurzaussagen = "";
		this.kurzinfos = "";
		this.onlineabschliessbar = false;
		this.abwaehlbar = false;
		this.produktkategorie = null;
	}

	public function getOnlineabschliessbar():Boolean {
		return onlineabschliessbar;
	}

	public function setOnlineabschliessbar(onlineabschliessbar:Number):Void {
		this.onlineabschliessbar = (onlineabschliessbar == 1);
	}

	public function getKurzinfos():String {
		return kurzinfos;
	}

	public function setKurzinfos(kurzinfos:String):Void {
		this.kurzinfos = kurzinfos;
	}

	public function getPfad():String {
		return pfad;
	}

	public function setPfad(pfad:String):Void {
		this.pfad = pfad;
	}

	public function getNameinfos():String {
		return nameinfos;
	}

	public function setNameinfos(nameinfos:String):Void {
		this.nameinfos = nameinfos;
	}

	public function getProduktkategorie():Produktkategorie {
		return produktkategorie;
	}

	public function setProduktkategorie(produktkategorie:Produktkategorie):Void {
		this.produktkategorie = produktkategorie;
	}

	public function getKurzaussagen():String {
		return kurzaussagen;
	}

	public function setKurzaussagen(kurzaussagen:String):Void {
		this.kurzaussagen = kurzaussagen;
	}

	public function getAbwaehlbar():Boolean {
		return abwaehlbar;
	}

	public function setAbwaehlbar(abwaehlbar:Number):Void {
		this.abwaehlbar = (abwaehlbar == 1);
	}

	public function getID():Number {
		return ID;
	}

	public function setID(ID:Number):Void {
		this.ID = ID;
	}

	public function getNamevorhanden():String {
		return namevorhanden;
	}

	public function setNamevorhanden(namevorhanden:String):Void {
		this.namevorhanden = namevorhanden;
	}

	public function getNameempfehlung():String {
		return nameempfehlung;
	}

	public function setNameempfehlung(nameempfehlung:String):Void {
		this.nameempfehlung = nameempfehlung;
	}
	
	public function toString():String
	{
		return(getID() + ": " + getNameempfehlung() + ", " +getProduktkategorie());	
	}

}