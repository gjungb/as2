import com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener;
import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.beans.Level;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.beans.LevelStatistics;
import mx.utils.Delegate;


class com.adgamewonderland.aldi.fischspiel.ui.LevelUI extends MovieClip implements ITankControllerListener
{

	private var count0_txt:TextField;

	private var count1_txt:TextField;

	private var count2_txt:TextField;

	private var count3_txt:TextField;

	private var count4_txt:TextField;

	private var nextlevel_btn:Button;

	public function LevelUI()
	{
		// ausblenden
		_visible = false;
	}

	public function onLoad():Void
	{
		// als listener registrieren
		TankController.getInstance().addListener(this);
		// textfelder zentriert
		count0_txt.autoSize = count1_txt.autoSize = count2_txt.autoSize = count3_txt.autoSize = count4_txt.autoSize = "center";
		// button weiter
		nextlevel_btn.onRelease = Delegate.create(this, doNexlevel);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		TankController.getInstance().removeListener(this);
	}

	public function onFishAdded(aFish:Fish ):Void
	{
	}

	public function onFishRemoved(aFish:Fish ):Void
	{
	}

	public function onFishEaten(aEater:Fish, aEaten:Fish ):Void
	{
	}

	public function onFishGrown(aFish:Fish ):Void
	{
	}

	public function onLevelStarted(aLevel:Level):Void
	{
		// ausblenden
		_visible = false;
	}

	public function onLevelCleared(aLevel:Level ):Void
	{
		// einblenden
		_visible = true;
		// statistic
		var statistics:LevelStatistics = aLevel.getStatistics();
		// schleife uber alle groessen
		for (var i : Number = 0; i <= Fish.NUMSIZES; i++) {
			// anzahl anzeigen
			TextField(this["count" + i + "_txt"]).text = String(statistics.getCount(i));
		}
	}

	private function doNexlevel():Void
	{
		// naechstes level
		TankController.getInstance().nextLevel();
	}

}
