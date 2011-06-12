import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.beans.impl.ClipImpl extends Clip {

	private static var PATH:String = "http://www.base-casting.de/videos/"; // (_root._url.indexOf("http://") == -1 ? "http://www.base-casting.de" : "") + "/videos/"; //

	public function ClipImpl() {
		super();
	}

	public static function parse(aObj:Object ):ClipImpl
	{
		// clip
		var clip:ClipImpl = ClipImpl(RemotingBeanCaster.getCastedInstance(new ClipImpl(), aObj));
		// casting
		var casting:CastingImpl = CitiesController.getInstance().getCastingById(aObj.castingId);
		// casting zum clip zuordnen
		clip.setCasting(casting);
		// zurueck geben
		return clip;
	}

	public static function getClipurl(aClip:Clip ):String
	{
		// url zum clip
		return PATH + aClip.getPath() + aClip.getFilename();
	}

	public static function getThumburl(aClip:Clip ):String
	{
		// url zum thumbnail
		return PATH + aClip.getPath() + aClip.getThumbnail();
	}

}