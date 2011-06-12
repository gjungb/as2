import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.beans.UserFish;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener;
import com.adgamewonderland.aldi.fischspiel.beans.Level;

class com.adgamewonderland.aldi.fischspiel.ui.GrowthUI extends MovieClip implements ITankControllerListener
{

	private var bar_mc:MovieClip;

	public function GrowthUI()
	{
		// Not yet implemented
	}

	public function onLoad():Void
	{
		// als listener registrieren
		TankController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		TankController.getInstance().removeListener(this);
	}

	public function onLevelStarted(aLevel:Level):Void
	{
		// balken skalieren
		bar_mc._xscale = 0;
	}

	public function onLevelCleared(aLevel:Level):Void
	{
	}

	public function onFishAdded(aFish : Fish) : Void {
		// wachstum anzeigen
		if (aFish instanceof UserFish)
			gotoAndStop(Math.floor(aFish.getSize()));
	}

	public function onFishRemoved(aFish : Fish) : Void {
	}

	public function onFishEaten(aEater : Fish, aEaten : Fish) : Void {
		// wachstum anzeigen
		if (aEater instanceof UserFish) {
			// gesamtwachstum
			var percent:Number = UserFish(aEater).getGrowthPercent();
			// balken skalieren
			bar_mc._xscale = percent;
		}
	}

	public function onFishGrown(aFish : Fish) : Void {
		// wachstum anzeigen
		if (aFish instanceof UserFish) {
			// wachstumsstufe
			gotoAndStop(Math.floor(aFish.getSize()));
		}
	}

}
