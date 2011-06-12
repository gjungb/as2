import com.adgamewonderland.aldi.fischspiel.ui.FishUI;
import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import mx.utils.Delegate;

class com.adgamewonderland.aldi.fischspiel.ui.ComputerFishUI extends FishUI
{

	public function ComputerFishUI() {
		super();
	}

	public function onFishEaten(eater:Fish, eaten:Fish):Void
	{
		// testen, ob gefressen
		if (eaten.equals(getFish())) {
			// animation
			eaten_mc.play();
			// nach pause loeschen
			eaten_mc.onEnterFrame = Delegate.create(this, doRemove);
		}
	}

	private function showSize(aSize:Number ):Void
	{
		// hinspringen
		gotoAndStop(aSize);
		// animation skalieren
		eaten_mc._xscale = eaten_mc._yscale = aSize / Fish.NUMSIZES * 100;
	}

	private function doRemove() : Void
	{
		// loeschen, wenn animation beendet
		if (eaten_mc._currentframe == eaten_mc._totalframes)
			this.removeMovieClip();
	}

	public function toString() : String {
		return "ComputerFishUI: " + super.toString();
	}

}
