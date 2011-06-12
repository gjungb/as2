/**
 * @author Harry
 */
interface com.adgamewonderland.ea.nextlevel.swfstudio.IFilesystemHandler {
	public function onCompleteFileOpen	(return_obj) : Void;
	public function onCompleteSaveAs	(returnObj:Object, callbackObj:Object, errorObj:Object) : Void;
	public function onError				(return_obj) : Void;

}