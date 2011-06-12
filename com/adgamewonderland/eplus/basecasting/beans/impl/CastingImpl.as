import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.agw.util.TimeFormater;
import com.adgamewonderland.eplus.basecasting.beans.Casting;
import com.adgamewonderland.eplus.basecasting.beans.impl.LocationImpl;
import com.adgamewonderland.eplus.basecasting.beans.Location;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl extends Casting {

	private static var TICKEREDGE:String = " +++ ";

	public static var LOCATIONSPLIT:String = "|";

	public function CastingImpl() {
		super();
	}

	public static function parse(aObj:Object ):CastingImpl
	{
		// casting
		var casting:CastingImpl = CastingImpl(RemotingBeanCaster.getCastedInstance(new CastingImpl(), aObj));
		// location
		var location:LocationImpl = LocationImpl.parse(aObj["location"]);
		// speichern
		casting.setLocation(location);
		// zurueck geben
		return casting;
	}

	public function getLocationTicker(showcity:Boolean ):String
	{
		// ticker text des castings
		var ticker:String = "";
		// umrandung
		ticker += TICKEREDGE;
		// datum
		ticker += TimeFormater.getDayMonth(getDate(), ".");
		// abstand
		ticker += " ";
		// location
		var locationname:String = getLocation().getName();
		// nur text vor dem trennzeichen
		if (locationname.indexOf(LOCATIONSPLIT) > -1)
			locationname = locationname.split(LOCATIONSPLIT)[0];
		// location name
		ticker += locationname;
		// stadt
		if (showcity) {
			// abstand
			ticker += ", ";
			// statdt
			ticker += getCity().getName();
			// abstand
			ticker += " ";
		}
		// umrandung
		ticker += TICKEREDGE;
		// zurueck geben
		return ticker;
	}

	public function getLocationName():String
	{
		// name der location
		var locationname:String = getLocation().getName();
		// nur text vor dem trennzeichen
		if (locationname.indexOf(LOCATIONSPLIT) > -1)
			locationname = locationname.split(LOCATIONSPLIT)[0];
		// zurueck geben
		return locationname;
	}

	public function getLocationInfo(aDelimiter:String ):String
	{
		// name der location, bei der das trennzeichen ersetzt ist durch das uebergebene
		var locationinfo:String = getLocation().getName();
		// abbrechen wenn trennzeichen nicht vorhanden
		if (locationinfo.indexOf(LOCATIONSPLIT) == -1)
			return "";
		// auftrennen
		var parts:Array = locationinfo.split(LOCATIONSPLIT);
		// name entfernen
		parts.shift();
		// mit neuem trennzeichen zusammen setzen
		locationinfo = parts.join(aDelimiter);
		// zurueck geben
		return locationinfo;
	}

}