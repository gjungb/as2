import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.ui.FishUI;
import com.adgamewonderland.aldi.fischspiel.beans.UserFish;

class com.adgamewonderland.aldi.fischspiel.ui.UserFishUI extends FishUI
{

	private static var MAXSCALE:Number = 200;

	private static var ALPHA_IMMUNITY:Number = 30;

	public function UserFishUI() {
		super();
	}

	public function doUpdateUI():Void
	{
		super.doUpdateUI();
		// user fish
		var uf:UserFish = UserFish(getFish());
		// immunitaet anzeigen
		_alpha = uf.isImmune() ? ALPHA_IMMUNITY : 100;
	}

	public function onFishEaten(eater:Fish, eaten:Fish):Void
	{
		// testen, ob gefressen
		if (eaten.equals(getFish())) {
			// abbrechen, wenn immun
			if (UserFish(eaten).isImmune())
				return;
			// animation
			eaten_mc.play();
		}
	}

	private function showSize(aSize:Number ):Void
	{
		// aktuelles vorzeichen der skalierung
		var sign:Number = _xscale < 0 ? -1 : 1;
		// skalierung
		var scale:Number = aSize / Fish.NUMSIZES * MAXSCALE;
		// skalieren
		_xscale = sign * scale;
		_yscale = scale;
	}

	public function toString() : String {
		return "UserFishUI: " + super.toString();
	}
}
