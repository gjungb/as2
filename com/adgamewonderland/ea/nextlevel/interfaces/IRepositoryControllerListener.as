import com.adgamewonderland.ea.nextlevel.model.beans.impl.RepositoryImpl;
/**
 * @author gerd
 */
interface com.adgamewonderland.ea.nextlevel.interfaces.IRepositoryControllerListener {

	public function onRepositoryLoaded(repository:RepositoryImpl):Void;

}