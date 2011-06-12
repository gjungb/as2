import mx.utils.Collection;
import mx.utils.CollectionImpl;

import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.connectors.CityConnector;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityConnectorListener;
import mx.utils.Iterator;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.controllers.CitiesController extends DefaultController implements ICityConnectorListener {

	private static var instance:CitiesController;

	private var cities:Collection;

	private var castings:Array;

	private var citycount:Number;

	private var parsedcity:CityImpl;

	private var currentcity:CityImpl;

	/**
	 * @return singleton instance of CitiesController
	 */
	public static function getInstance():CitiesController {
		if (instance == null)
			instance = new CitiesController();
		return instance;
	}

	private function CitiesController() {
		// liste der staedte
		this.cities = new CollectionImpl();
		// liste der castings
		this.castings = new Array();
		// anzahl der geladenen staedte
		this.citycount = 0;
		// aktuell geparste stadt
		this.parsedcity = null;
		// aktuell angezeigte stadt
		this.currentcity = null;
	}

	public function loadCities(aId:Number ):Void
	{
		// aktuell angezeigte stadt
		if (isNaN(aId) == false) {
			// neue stadt
			this.currentcity = new CityImpl();
			// id speichern
			this.currentcity.setID(aId);
		}
		// als listener bei connector anmelden
		CityConnector.getInstance().addListener(this);
		// staedte laden
		CityConnector.getInstance().loadCities();
	}

	public function onCitiesLoaded(cities:Collection ):Void
	{
		// liste der staedte
		this.cities = cities;
		// aktuelle stadt
		var city:CityImpl;
		// castings laden
		loadNextCasting();
	}

	public function onCastingsLoaded(castings:Collection ):Void
	{
		// castings der stadt zuordnen
		this.parsedcity.parseCastings(castings);
		// pruefen, ob alle staedte und castings geladen
		if (this.citycount < this.cities.getLength()) {
			// naechstes casting laden
			loadNextCasting();
		} else {
			// aktuelle stadt
			if (this.currentcity != null)
				this.currentcity = getCity(this.currentcity.getID());
			// alle castings in eine liste
			sortCastings();
			// listener informieren
			_event.send("onCitiesParsed", this.currentcity);
		}
	}

	public function getCities():Collection
	{
		return this.cities;
	}

	public function getSortedCities(aKey:String ):Collection
	{
		// pruefen, ob gueltiger sortierschluessel
		if (new CityImpl().hasOwnProperty(aKey) == false)
			return getCities();
		// sortierte staedte
		var sortedcities:Collection = new CollectionImpl();
		// staedte als array
		var cities:Array = getCitiesArray();
		// sortieren
		cities = cities.sortOn(aKey, Array.CASEINSENSITIVE);
		// schleife ueber sortierte staedte
		for (var i : Number = 0; i < cities.length; i++) {
			sortedcities.addItem(CityImpl(cities[i]));
		}
		// zurueck geben
		return sortedcities;
	}

	public function getCity(aId:Number ):CityImpl
	{
		return CityImpl(this.cities.getItemAt(aId - 1));
	}

	public function getCastingById(aId:Number ):CastingImpl
	{
		// gesuchtes casting
		var casting:CastingImpl = new CastingImpl();
		// schleife ueber castings
		for (var i:Number = 0; i < this.castings.length; i++) {
			// aktuelles casting
			casting = this.castings[i];
			// beenden, wenn id gefunden
			if (casting.getID() == aId)
				break;
		}
		// zurueck geben
		return casting;
	}

	public function setCurrentcity(aCity:CityImpl ):Void
	{
		this.currentcity = aCity;
	}

	public function getCurrentcity():CityImpl
	{
		return this.currentcity;
	}

	public function getCitiesTicker(showcity:Boolean ):String
	{
		// ticker aller staedte
		var ticker:String = "";
		// aktuelle stadt
		var city:CityImpl;
		// schleife ueber alle staedte
		for (var i:Number = 1; i <= this.citycount; i++) {
			// aktuelle stadt
			city = getCity(i);
			// ticker aller castings einer stadt
			ticker += city.getCastingTicker(showcity);
		}
		// zurueck geben
		return ticker;
	}

	public function getCityTicker(showcity:Boolean ):String
	{
		// ticker aller castings der aktuellen stadt
		var ticker:String = this.currentcity.getCastingTicker(showcity);
		// zurueck geben
		return ticker;
	}

	private function loadNextCasting():Void
	{
		// aktuell geparste stadt
		this.parsedcity = getCity(++this.citycount);
		// castings fuer diese stadt laden
		CityConnector.getInstance().loadCastings(this.parsedcity);
	}

	private function getCitiesArray():Array
	{
		// steadte als array
		var cities:Array = new Array();
		// schleife ueber staedte
		for (var i : Number = 0; i < getCities().getLength(); i++) {
			// aktuelle stadt
			cities.push(getCities().getItemAt(i));
		}
		// zurueck geben
		return cities;
	}

	private function sortCastings() : Void {
		// aktuelle stadt
		var city:CityImpl;
		// schleife ueber alle staedte
		for (var i : Number = 0; i < this.cities.getLength(); i++) {
			// aktuelle stadt
			city = CityImpl(this.cities.getItemAt(i));
			// castings der aktuellen stadt zur liste aller castings
			this.castings = this.castings.concat(city.toCastingsArray());
		}
		// nach id sortieren
		this.castings.sortOn("iD", Array.NUMERIC);
	}

}