import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.beans.Level;

interface com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener
{

	public function onFishAdded(aFish:Fish):Void;

	public function onFishRemoved(aFish:Fish):Void;

	public function onFishEaten(aEater:Fish, aEaten:Fish):Void;

	public function onFishGrown(aFish:Fish):Void;

	public function onLevelStarted(aLevel:Level):Void;

	public function onLevelCleared(aLevel:Level):Void;
}
