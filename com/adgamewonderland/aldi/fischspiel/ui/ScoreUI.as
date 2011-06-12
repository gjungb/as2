import com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.beans.UserFish;
import com.adgamewonderland.aldi.fischspiel.beans.Level;

class com.adgamewonderland.aldi.fischspiel.ui.ScoreUI extends MovieClip implements ITankControllerListener
{

	private var score_txt:TextField;

	public function ScoreUI()
	{
		// zentriert
		score_txt.autoSize = "center";
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
		// punkte anzeigen
		if (aFish instanceof UserFish)
			score_txt.text = "" + UserFish(aFish).getScore();
	}

	public function onFishRemoved(aFish : Fish) : Void {
	}

	public function onFishEaten(aEater : Fish, aEaten : Fish) : Void {
		// punkte anzeigen
		if (aEater instanceof UserFish)
			score_txt.text = "" + UserFish(aEater).getScore();
	}

	public function onFishGrown(aFish : Fish) : Void {
	}

}
