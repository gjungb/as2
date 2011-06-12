import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterClientLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterService;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;

class com.adgamewonderland.eplus.base.tarifberater.services.TarifberaterClient implements ITarifberaterService, ITarifberaterClientLsnr
{
	private var _event:EventBroadcaster;

	private function TarifberaterClient()
	{
		this._event = new EventBroadcaster();
	}

	public function addListener(l:Object):Void
	{
		this._event.addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		this._event.removeListener(l);
	}
	
	public function legeErgebnissInWk(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
	}
	
	public function waehleHardwareZumErgebniss(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void {
	}
	
	public function onLegeErgebnissInWk(result : Object) : Void {
	}
	
	public function onWaehleHardwareZumErgebniss(result : Object) : Void {
	}
	
	public function neuStarten(aZustand : IZustand): Void{
	}
	
	public function zurueckGehen(aZustand: IZustand): Void {
	}
}
