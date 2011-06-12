import com.adgamewonderland.agw.util.HashMap;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.AbstractProdukt implements IProdukt {
	
	private var id : String;
	
	private var name : String;
	
	private var zusatztext : String;
	
	private var preiseinmalig : Number;
	
	private var streichpreiseinmalig : Number;
	
	private var preismonatlich : Number;
	
	private var streichpreismonatlich : Number;
	
	private var visible : Boolean;
	
	private var infos : Boolean;
	
	private var step : String = "";
	
	private var sapnummer : String = "";
	
	private static var produkte : HashMap = new HashMap();

	/**
	 * "abstrakter" Konstruktor
	 */
	private function AbstractProdukt(aId : String, aName : String, aZusatztext : String, aPreiseinmalig : Number, aStreichpreiseinmalig : Number, aPreismonatlich : Number, aStreichpreismonatlich : Number, aVisible : Boolean, aInfos : Boolean, aStep : String) {
		this.id = aId;
		this.name = aName;
		this.zusatztext = aZusatztext;
		this.preiseinmalig = aPreiseinmalig;
		this.streichpreiseinmalig = aStreichpreiseinmalig;
		this.preismonatlich = aPreismonatlich;
		this.streichpreismonatlich = aStreichpreismonatlich;
		this.visible = aVisible;
		this.infos = aInfos;
		this.step = aStep;
	}

	public function clone() : IProdukt {
		return null;
	}
	
	/**
	 * Gibt ein Produkt anhand seines Namens zurück
	 * @param aName Name des Produkts
	 * @return das gesuchte Produkt oder null, falls kein Produkt mit dem Namen existiert
	 */
	public static function getProdukt(aName : String ) : IProdukt {
		// gewuenschtes produkt
		var produkt : IProdukt = IProdukt(produkte.get(aName));
		// klonen und zurueck geben
		return produkt.clone();
	}

	public function getId() : String {
		return this.id;
	}

	public function getName() : String {
		return this.name;
	}

	public function getZusatztext() : String {
		return this.zusatztext;
	}

	public function getPreiseinmalig() : Number {
		return this.preiseinmalig;
	}

	public function getStreichpreiseinmalig() : Number {
		return this.streichpreiseinmalig;
	}

	public function getPreismonatlich() : Number {
		return this.preismonatlich;
	}
	
	public function setPreismonatlich(aValue : Number) : Void {
		this.preismonatlich = aValue;
	}

	public function getStreichpreismonatlich() : Number {
		return this.streichpreismonatlich;
	}

	public function getVisible() : Boolean {
		return this.visible;
	}

	public function setVisible(aValue : Boolean) : Void {
		this.visible = aValue;
	}
	
	public function getInfos() : Boolean {
		return this.infos;
	}
	
	public function getStep() : String {
		return this.step;
	}

	public function setStep(aStep : String) : Void {
		this.step = aStep;
	}
	
	public function getSapnummer() : String {
		return this.sapnummer;
	}

	public function setSapnummer(aSapnummer : String) : Void {
		this.sapnummer = aSapnummer;
	}

	public function toString():String
	{
		var ret : String = "";
		for (var i : String in this) {
			ret += i + ": " + this[i] + " # ";
		}
		return ret;
	}
}