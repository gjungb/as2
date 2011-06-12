import mx.utils.Collection;
import mx.utils.CollectionImpl;
/**
 * @author gerd
 */
class com.adgamewonderland.agw.util.RandomUtil {

	public static function getRandomValues(aMinimum:Number, aMaximum:Number, aCount:Number ):Collection
	{
		// zufaellig ausgewaehlte zahlen zwischen minimum und maximum
		var randomvalues:Collection = new CollectionImpl();
		// sicherheit
		if (aMaximum - aMinimum < aCount)
			return randomvalues;
		// jeweilige zufallszahl
		var rand:Number;
		// schleife
		do {
			// zufallszahl
			rand = aMinimum + Math.round(Math.random() * (aMaximum - aMinimum));
			// pruefen, ob zahl noch nicht vorhanden
			if (randomvalues.contains(rand) == false) {
				// zahl speichern
				randomvalues.addItem(rand);
			}
		} while (randomvalues.getLength() < aCount);
		// zurueck geben
		return randomvalues;
	}

	public static function getRandomIndex(aArray:Array ):Number
	{
		// zufaelliger index im array, an dem noch kein wert gesetzt ist
		var randomindex:Number = -1;
		// jeweilige zufallszahl
		var rand:Number;
		// schleife
		do {
			// zufallszahl
			rand = Math.floor(Math.random() * aArray.length);
			// pruefen, ob noch kein wert vorhanden
			if (aArray[rand] == null)
				randomindex = rand;
		} while (randomindex == -1);

		// zurueck geben
		return randomindex;
	}

	private function RandomUtil() {

	}

}