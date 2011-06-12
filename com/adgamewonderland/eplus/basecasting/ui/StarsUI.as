/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.StarsUI extends MovieClip {

	private var bar_mc:MovieClip;

	function StarsUI() {
	}

	public function showStars(aPercent:Number ):Void
	{
		// balken skalieren
		bar_mc._xscale = aPercent;
	}

}