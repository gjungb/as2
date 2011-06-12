import com.adgamewonderland.eplus.basecasting.beans.Clip;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.IVideoControllerListener {

	public function onClipSelected(aClip:Clip ):Void;

	public function onVotingStarted(aClip:Clip ):Void;

	public function onTellafriendStarted(aClip:Clip ):Void;

}