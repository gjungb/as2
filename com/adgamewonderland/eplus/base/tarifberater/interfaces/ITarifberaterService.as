/**
 * @author harry
 */
import com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss;

interface com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterService 
{

	/**
	 * Legt einen oder mehrere Ergebnisse in den Warenkorb.
	 * Bei Erfolg liefert Funktion "ok"
	 * Im Fehlerfall eine Beschreibung der Exception.
	 * 
	 * @param para
	 */
	public function legeErgebnissInWk(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void;

	/**
	 * Die Beratungsergebnisse werden innerhalb der Session gespeichert,
	 * damit der benutzer ein Stück Hardware auswählen kann.
	 * 
	 * Bei Erfolg liefert Funktion "ok"
	 * Im Fehlerfall eine Beschreibung der Exception.
	 * 
	 * @param para
	 */
	public function waehleHardwareZumErgebniss(aPara1 : BeratungsErgebniss, aPara2 : BeratungsErgebniss) : Void;
}
