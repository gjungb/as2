import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;

class com.adgamewonderland.eplus.base.tarifberater.automat.FehlerZustand extends AbstractZustand {
	
	public function FehlerZustand(aAutomat : TarifberaterAutomat){
		super(aAutomat);
		// id
		this.id = "FehlerZustand";
		// frage
		this.frage = new Frage("");
	}
}