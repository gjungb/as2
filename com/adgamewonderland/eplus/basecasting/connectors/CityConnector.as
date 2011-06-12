import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.ResultEvent;
import mx.utils.Collection;
import mx.utils.CollectionImpl;

import com.adgamewonderland.agw.net.DefaultConnector;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
import com.adgamewonderland.eplus.basecasting.interfaces.ICityConnector;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.connectors.CityConnector extends DefaultConnector implements ICityConnector {

	private static var instance:CityConnector;

	/**
	 * @return singleton instance of CityConnector
	 */
	public static function getInstance():CityConnector {
		if (instance == null)
			instance = new CityConnector();
		return instance;
	}

	private function CityConnector() {
		super();
		// gateway
		this.gateway = "http://www.base-casting.de/gateway"; // "http://tripto.adgame-wonderland.de:9999/basecasting/gateway";
		// remoteobj
		this.remoteobj = "com.adgamewonderland.eplus.basecasting.connectors.CityConnector";
		// debug
		this.debug = true;
	}

	public function loadCities():Void
	{
		// staedte laden
		var pc:PendingCall = getService().loadCities();
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onCitiesLoaded", "onConnectorFault");
	}

	public function loadCastings(aCity:CityImpl ):Void
	{
		// castings einer stadt laden
		var pc:PendingCall = getService().loadCastings(aCity.getID());
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onCastingsLoaded", "onConnectorFault");
	}

	private function onCitiesLoaded(re:ResultEvent ):Void
	{
		// liste der staedte
		var cities:Collection = new CollectionImpl();
		// aktuelle stadt
		var city:CityImpl;
		// schleife ueber staedte
		for (var i:Number = 0; i < re.result.length; i++) {
			// aktuelle stadt
			city = CityImpl.parse(re.result[i]);
			// in liste der staedte
			cities.addItem(city);
		}
		// listener informieren
		_event.send("onCitiesLoaded", cities);
	}

	private function onCastingsLoaded(re:ResultEvent ):Void
	{
		// liste der castings
		var castings:Collection = new CollectionImpl();
		// aktuelles casting
		var casting:CastingImpl;
		// schleife ueber castings
		for (var i:Number = 0; i < re.result.length; i++) {
			// aktuelles casting
			casting = CastingImpl.parse(re.result[i]);
			// in liste der castings
			castings.addItem(casting);
		}
		// listener informieren
		_event.send("onCastingsLoaded", castings);
	}

}