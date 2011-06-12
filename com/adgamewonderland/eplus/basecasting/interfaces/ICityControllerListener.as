import com.adgamewonderland.eplus.basecasting.beans.Casting;
/**
 * @author gerd
 */
interface com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener {

	public function onCityStateChanged(aState:String, aNewstate:String ):Void;

	public function onCastingSelected(aCasting:Casting ):Void;

}