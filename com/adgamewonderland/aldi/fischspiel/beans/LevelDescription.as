/**
 * @author gerd
 */
class com.adgamewonderland.aldi.fischspiel.beans.LevelDescription {

	private var numfishes:Array;

	private var growthsteps:Number;

	public function LevelDescription(aNumfishes:Array, aGrowthsteps:Number ) {
		// anzahl der fische in den unterschiedlichen groessen
		this.numfishes = aNumfishes;
		// gewichtszuwachs, bei dem der userfish eine groesse zunimmt
		this.growthsteps = aGrowthsteps;
	}

	public function getFishcount(aSize:Number ):Number
	{
		// anzahl der fische der uebergebenen groesse
		var count:Number = this.numfishes[aSize - 1];
		// leere abfange
		if (count == null)
			count = 0;
		// zurueck geben
		return count;
	}

	public function getGrowthsteps():Number
	{
		return this.growthsteps;
	}

}