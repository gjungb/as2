import com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener;
import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.beans.UserFish;
import com.adgamewonderland.aldi.fischspiel.beans.Level;

class com.adgamewonderland.aldi.fischspiel.ui.LivesUI extends MovieClip implements ITankControllerListener
{

	private var lives_txt:TextField;

	public function LivesUI()
	{
		// zentriert
		lives_txt.autoSize = "center";
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
	}

	public function onLevelCleared(aLevel:Level):Void
	{
	}

	public function onFishAdded(aFish : Fish) : Void {
		// leben anzeigen
		if (aFish instanceof UserFish)
			lives_txt.text = "" + aFish.getLives();
	}

	public function onFishRemoved(aFish : Fish) : Void {
	}

	public function onFishEaten(aEater : Fish, aEaten : Fish) : Void {
		// leben anzeigen
		if (aEaten instanceof UserFish)
			lives_txt.text = "" + aEaten.getLives();
	}

	public function onFishGrown(aFish : Fish) : Void {
	}

}
