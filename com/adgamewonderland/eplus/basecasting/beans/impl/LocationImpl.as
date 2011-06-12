import com.adgamewonderland.eplus.basecasting.beans.Location;
import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.beans.impl.LocationImpl extends Location {

	public function LocationImpl() {
		super();
	}

	public static function parse(aObj:Object ):LocationImpl
	{
		return LocationImpl(RemotingBeanCaster.getCastedInstance(new LocationImpl(), aObj));
	}

	public function addCasting(aCasting:CastingImpl ):Void
	{
		this.castings.push(aCasting);
	}

}