import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.behaviours.MoveByRandom;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;

class com.adgamewonderland.aldi.fischspiel.beans.ComputerFish extends Fish
{

	public function ComputerFish()
	{
		// bewegungsverhalten
		setMoveBehaviour(new MoveByRandom());
		// grenzen der bewegung
		this.moveBehaviour.setBounds(TankController.getInstance().getBounds());
	}

	public function toString() : String {
		return "ComputerFish: " + getId();
	}
}
