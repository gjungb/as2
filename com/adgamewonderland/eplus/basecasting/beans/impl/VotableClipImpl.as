import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl extends VotableClip {

	public static var STARS:Number = 5;

	function VotableClipImpl() {
		super();
	}

	public static function parse(aObj:Object ):VotableClipImpl
	{
		// clip
		var clip:VotableClipImpl = VotableClipImpl(RemotingBeanCaster.getCastedInstance(new VotableClipImpl(), aObj));
		// casting
		var casting:CastingImpl = CitiesController.getInstance().getCastingById(aObj.castingId);
		// casting zum clip zuordnen
		clip.setCasting(casting);
		// zurueck geben
		return clip;
	}

}