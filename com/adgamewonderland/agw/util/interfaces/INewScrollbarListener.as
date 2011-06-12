import com.adgamewonderland.agw.util.NewScrollbarUI;
/**
 * @author Harry
 */
interface com.adgamewonderland.agw.util.interfaces.INewScrollbarListener {
	public function beforeScrollPosChanged	(scroll:NewScrollbarUI,currPos:Number) : Void;
	public function afterScrollPosChanged	(scroll:NewScrollbarUI,currPos:Number) : Void;
}