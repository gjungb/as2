/**
 * @author gerd
 */
class com.adgamewonderland.sskddorf.mischpult.beans.Produktkategorie {
	
	private var ID:Number;
	
	private var name:String;
	
	private var abkuerzung:String;
	
	private var defaulttext:String;
	
	public function Produktkategorie() {
		this.ID = 0;
		this.name = "";
		this.abkuerzung = "";
		this.defaulttext = "";
	}
	
	public function getAbkuerzung():String {
		return abkuerzung;
	}

	public function setAbkuerzung(abkuerzung:String):Void {
		this.abkuerzung = abkuerzung;
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

	public function getDefaulttext():String {
		return defaulttext;
	}

	public function setDefaulttext(defaulttext:String):Void {
		this.defaulttext = defaulttext;
	}
	
	public function toString():String
	{
		return(getID() + ": " + getName() + ", " + getAbkuerzung() + ", " + getDefaulttext());	
	}

}