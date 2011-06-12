/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.IApplicationControllerListener {

	public function onStateChangeInited(aState:String, aNewstate:String ):Void;

	public function onStateChanged(aState:String, aNewstate:String ):Void;

}