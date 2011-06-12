import com.adgamewonderland.aldi.fischspiel.interfaces.IEatable;
import com.adgamewonderland.aldi.fischspiel.behaviours.IEatBehaviour;

class com.adgamewonderland.aldi.fischspiel.behaviours.EatBehaviour implements IEatBehaviour
{

	public function EatBehaviour() {

	}

	public function eat(aEater:IEatable, aEaten:IEatable):Number
	{
		// ergebnis
		var result:Number = 0;
		// der groessere gewinnt
		if (aEater.getSize() > aEaten.getSize())
			result = 1;
		if (aEater.getSize() < aEaten.getSize())
			result = -1;
		// zurueck geben
		return result;
	}
}
