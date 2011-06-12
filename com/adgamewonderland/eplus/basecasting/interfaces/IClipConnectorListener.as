import mx.utils.Collection;

import com.adgamewonderland.eplus.basecasting.beans.impl.ClipImpl;
import com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.IClipConnectorListener {

	public function onTopclipLoaded(aClip:VotableClipImpl):Void;

	public function onClipsByRankLoaded(aClips:Collection):Void;

	public function onClipsByDateLoaded(aClips:Collection):Void;

	public function onClipsByCastingLoaded(aClips:Collection):Void;

	public function onClipLoaded(aClip:ClipImpl):Void;

}