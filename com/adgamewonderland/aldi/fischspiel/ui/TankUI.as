import mx.utils.Collection;
import mx.utils.CollectionImpl;

import com.adgamewonderland.aldi.fischspiel.beans.ComputerFish;
import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.beans.Level;
import com.adgamewonderland.aldi.fischspiel.beans.UserFish;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener;
import com.adgamewonderland.aldi.fischspiel.ui.FishUI;
import com.adgamewonderland.aldi.fischspiel.ui.GrowthUI;
import com.adgamewonderland.aldi.fischspiel.ui.LivesUI;

class com.adgamewonderland.aldi.fischspiel.ui.TankUI extends MovieClip implements ITankControllerListener
{
	private var fishuis:Collection;

	private var fishes_mc:MovieClip;

	private var mask_mc:MovieClip;

	private var growth_mc:GrowthUI;

	private var lives_mc:LivesUI;

	public function TankUI()
	{
		// alle fische auf buehne
		this.fishuis = new CollectionImpl();
		// container fuer alle fische auf buehne
		fishes_mc = this.createEmptyMovieClip("fishes_mc", getNextHighestDepth());
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
		// alle fische loeschen
		for (var i : Number = 0; i < this.fishuis.getLength(); i++) {
			trace(this.fishuis.getItemAt(i));

		}
	}

	public function onFishAdded(aFish:Fish):Void
	{
		// neuer fisch auf buehne
		var ui:FishUI = addFishUI(aFish);
		// zur liste aller fische hinzufuegen
		this.fishuis.addItem(ui);
	}

	public function onFishRemoved(aFish:Fish):Void
	{
		// entsprechendes movieclip
		var ui:FishUI = FishUI(fishes_mc["fish" + aFish.getId() + "_mc"]);
		// aus liste aller fische loeschen
		this.fishuis.removeItem(ui);
		// von buehne loeschen
		ui.removeMovieClip();
	}

	public function onFishEaten(eater : Fish, eaten : Fish) : Void {
	}

	public function onFishGrown(aFish : Fish) : Void {
	}

	/**
	 * fuegt einen fisch auf der buehne hinzu
	 * @param aFish
	 */
	private function addFishUI(aFish:Fish ):FishUI
	{
		// movieclip des fisches
		var ui:FishUI;
		// identifier fuer symbol aus bibliothek
		var identifier:String = "";
		// je nach subklasse
		if (aFish instanceof UserFish) identifier = "UserFishUI";
		if (aFish instanceof ComputerFish) identifier = "ComputerFishUI";
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = aFish.getPosition().x;
		constructor._y = aFish.getPosition().y;
		// fish
		constructor._fish = aFish;
		// auf buehne
		ui = FishUI(fishes_mc.attachMovie(identifier, "fish" + aFish.getId() + "_mc", fishes_mc.getNextHighestDepth(), constructor));
		// zurueck geben
		return ui;
	}

}
