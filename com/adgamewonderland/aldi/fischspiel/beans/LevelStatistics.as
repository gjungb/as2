/**
 * @author gerd
 */
dynamic class com.adgamewonderland.aldi.fischspiel.beans.LevelStatistics {

	public function LevelStatistics() {

	}

	public function addCount(aSize:Number ):Void
	{
		// anzahl fische der uebergebenen groesse
		if (this["count" + aSize] == null)
			this["count" + aSize] = 0;
		// hochzaehlen
		this["count" + aSize] ++;
	}

	public function getCount(aSize:Number ):Number
	{
		// anzahl fische der uebergebenen groesse
		if (this["count" + aSize] == null)
			this["count" + aSize] = 0;
		// zurueck geben
		return this["count" + aSize];
	}

}