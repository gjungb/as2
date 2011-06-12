/**
 * @author gerd
 */
class com.adgamewonderland.dhl.adventskalender.ui.PricesUI extends MovieClip {
	
	public function PricesUI() {
		
	}
	
	public function showPrice(week:Number ):Void
	{
		// hinspringen
		gotoAndStop("frPrice" + week);
	}
	
	public function hidePrice():Void
	{
		// zum start
		gotoAndStop(1);
	}
}