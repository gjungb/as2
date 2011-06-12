import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
/**
 * @author gerd
 */
interface com.adgamewonderland.ea.nextlevel.interfaces.IMenuControllerListener {

	public function onPlaylistCreated():Void;
	public function onPlaylistOpened():Void;
	public function onPlaylistSaved():Void;
	public function onPlaylistSavedAs():Void;
	public function onMetainfoEdit(metainfo:Metainfo, allowcancel:Boolean):Void;
	public function onMetainfoClosed():Void;
	public function onPresentationCompleteOpened():Void;
	public function onPresentationIndividualOpened():Void;
	public function onFireMenue():Void;
}