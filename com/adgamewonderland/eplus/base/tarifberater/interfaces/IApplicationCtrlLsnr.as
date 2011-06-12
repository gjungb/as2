
/** * @author gerd */import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

interface com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr {
	
	public function onZeigeProduktinfos(aProdukt : IProdukt ) : Void;		public function onAendereGroesse(aSizable : ISizable ) : Void;
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void;
	
}