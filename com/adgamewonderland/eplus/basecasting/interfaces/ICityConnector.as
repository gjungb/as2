import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
interface com.adgamewonderland.eplus.basecasting.interfaces.ICityConnector
{

	/**
	 * Lädt alle Städte aus der Datenbank
	 * Zu jeder City werden alle Castings mit den dazu gehörigen Locations geliefert.
	 * @returns Gibt eine Liste aller Städte zurück
	 */
	public function loadCities():Void;

	/**
	 * Lädt alle Castings einer Statdt aus der Datenbank
	 * Zu jedem Casting werden dazu gehörigen Locations geliefert.
	 * @param cityId ID der Stadt in der Datenbank
	 * @returns Gibt eine Liste aller Castings einer Stadt zurück, aufsteigend sortiert nach Datum des Castings
	 */
	public function loadCastings(aCity:CityImpl ):Void;
}
