import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.behaviours.MoveByMouse;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;

class com.adgamewonderland.aldi.fischspiel.beans.UserFish extends Fish
{

	private static var GROWTHSTEPS:Number = 5;

	private static var IMMUNITY:Number = 5000;

	private var score:Number;

	private var growth:Number;

	private var growthsteps:Number;

	private var immune:Boolean;

	public function UserFish()
	{
		// bewegungsverhalten
		setMoveBehaviour(new MoveByMouse(10));
		// grenzen der bewegung
		this.moveBehaviour.setBounds(TankController.getInstance().getBounds());
		// leben
		setLives(4);
		// punktzahl
		this.score = 0;
		// wachstum
		this.growth = 0;
		// gewichtszuwachs, bei dem der fisch eine groesse zunimmt
		this.growthsteps = GROWTHSTEPS;
		// immung gegen gefressen werden
		this.immune = false;
	}

	public function addScore(aScore:Number ):Void
	{
		this.score += aScore;
	}

	public function addGrowth(aGrowth:Number ):Boolean
	{
		// wachsen
		this.growth += aGrowth;
		// wird die naechste wachstumsstufe erreicht
		var grown:Boolean = false;
		// pruefen, ob wachstumsschwelle erreicht
		if (this.growth >= this.growthsteps) {
			// vergroessern
			setSize(getSize() + 1);
			// naechste wachstumsstufe erreicht
			grown = true;
			// resetten
			this.growth = 0;
		}
		// zurueck geben
		return grown;
	}

	public function startImmunity():Void
	{
		// immunisieren
		setImmune(true);
		// nach pause deimmunisieren
		var interval:Number;
		var doSwitch:Function = function(aFish:UserFish ):Void
		{
			aFish.setImmune(false);
			clearInterval(interval);
		};
		interval = setInterval(doSwitch, IMMUNITY, this);
	}

	public function getGrowthPercent():Number
	{
		// prozent des gesamtwachstums
		var percent:Number = 0;
		// wie viel muss ich insgesamt zunehmen
		var maxweight:Number = this.growthsteps * Fish.NUMSIZES;
		// wie schwer bin ich im moment
		var weight:Number = Math.floor(this.size) * this.growthsteps + this.growth;
		// verhaeltnis
		percent = Math.round(weight / maxweight * 100);
		// zurueck geben
		return percent;
	}

	public function getScore():Number
	{
		return this.score;
	}

	public function getGrowth():Number
	{
		return this.growth;
	}

	public function setGrowthsteps(aGrowthsteps:Number ):Void
	{
		this.growthsteps = aGrowthsteps;
	}

	public function setImmune(aImmune:Boolean ):Void
	{
		this.immune = aImmune;
	}

	public function isImmune():Boolean
	{
		return this.immune;
	}

	public function toString() : String {
		return "UserFish: " + getId();
	}
}
