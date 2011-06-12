import com.adgamewonderland.agw.util.StringFormatter;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.Rechnungsrabatt implements IProdukt {
	
	public static var TYP_PROZENT : Number = 1;
	
	public static var TYP_ABSOLUT : Number = 2;

	public static var PROZENT : Number = 0.8;
	
	private var produkt : IProdukt;
	
	private var rabatt : Number = PROZENT;

	private var typ : Number = TYP_PROZENT;

	public function Rechnungsrabatt(aProdukt : IProdukt, aRabatt : Number, aTyp : Number ) {
		// dekoriertes produkt
		this.produkt = aProdukt;
		// rabatt
		if (aRabatt != null)
			this.rabatt = aRabatt;
		// typ
		if (aTyp != null)
			this.typ = aTyp;
	}

	public function getProdukt() : IProdukt {
		return this.produkt;	
	}

	public function getId() : String {
		return this.produkt.getId();
	}

	public function getName() : String {
		return this.produkt.getName();
	}
	
	public function getZusatztext() : String {
		// original text
		var zusatztext : String = this.produkt.getZusatztext();
		// je nach typ
		switch (this.typ) {
			case TYP_PROZENT :
				zusatztext += "(inkl. " + ((1 - this.rabatt) * 100) + "% Rabatt Online Vorteil)";
				break;
			case TYP_ABSOLUT :
				zusatztext += "(inkl. " + StringFormatter.formatMoney(this.rabatt) + " Rabatt Online Vorteil)";
				break;
		}
		return zusatztext;
	}

	public function getPreiseinmalig() : Number {
		return this.produkt.getPreiseinmalig();
	}
	
	public function getStreichpreiseinmalig() : Number {
		return this.produkt.getStreichpreiseinmalig();
	}
	
	public function getPreismonatlich() : Number {
		// original preis
		var preismonatlich : Number = this.produkt.getPreismonatlich();
		// je nach typ
		switch (this.typ) {
			case TYP_PROZENT :
				preismonatlich *= this.rabatt;
				break;
			case TYP_ABSOLUT :
				preismonatlich -= this.rabatt;
				break;
		}
		return preismonatlich;
	}
	
	public function setPreismonatlich(aValue : Number) : Void {
		this.produkt.setPreismonatlich(aValue);
	}

	public function getStreichpreismonatlich() : Number {
		return this.produkt.getStreichpreismonatlich();
	}
	
	public function getVisible() : Boolean {
		return this.produkt.getVisible();
	}
	
	public function setVisible(aValue : Boolean) : Void {
		this.produkt.setVisible(aValue);
	}
	
	public function getInfos() : Boolean {
		return this.produkt.getInfos();
	}
	
	public function getStep() : String {
		return this.produkt.getStep();
	}

	public function setStep(aStep : String) : Void {
		this.produkt.setStep(aStep);
	}
	
	public function getSapnummer() : String {
		return this.produkt.getSapnummer();
	}

	public function setSapnummer(aSapnummer : String) : Void {
		this.produkt.setSapnummer(aSapnummer);
	}

	public function clone() : IProdukt {
		return this.produkt.clone();
	}
}