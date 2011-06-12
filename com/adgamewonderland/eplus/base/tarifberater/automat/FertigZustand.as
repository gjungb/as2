import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;

class com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand extends AbstractZustand {
	
	public function FertigZustand(aAutomat : TarifberaterAutomat){
		super(aAutomat);
		// id
		this.id = "FertigZustand";
		// frage
		this.frage = new Frage("");
	}
	
	public function toString() : String {
		return "com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand";
	}
}