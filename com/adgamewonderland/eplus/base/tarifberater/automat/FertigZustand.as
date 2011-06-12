import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.automat.AbstractZustand;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;

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
	}		public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {		if(aZustand  instanceof FertigZustand){					warenkorbBestellen("");					trace("warenkorbBestellen()");		}	}
}