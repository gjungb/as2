import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

interface com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr {

	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb ) : Void;
}