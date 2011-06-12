
class com.adgamewonderland.eplus.base.tarifberater.beans.Antwort 
{
	
	private var identifier : String;
	
	private var typ : String;
	
	private var name : String;
	
	private var text : String;
	
	private var visible : Boolean = true;
	
	private var step : String;
	
	public function Antwort(aIdentifier : String, aTyp : String, aName : String, aText : String, aStep : String ) {
		this.identifier = aIdentifier;
		this.typ = aTyp;
		this.name = aName;
		this.text = aText;
		this.step = aStep;
	}

	public function getIdentifier() : String {
		return this.identifier;
	}
	
	public function getTyp() : String {
		return this.typ;
	}

	public function getName() : String {
		return this.name;
	}

	public function getText() : String {
		return this.text;
	}

	public function setText(aText : String) : Void {
		this.text = aText;
	}

	public function getVisible() : Boolean {
		return this.visible;
	}

	public function setVisible(aValue : Boolean) : Void {
		this.visible = aValue;
	}

	public function getStep() : String {
		return this.step;
	}

	public function setStep(aStep : String) : Void {
		this.step = aStep;
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
