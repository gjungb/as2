import mx.utils.Collection;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.ICityConnectorListener {

	public function onCitiesLoaded(cities:Collection ):Void;

	public function onCastingsLoaded(castings:Collection ):Void;

}