import com.adgamewonderland.ea.nextlevel.model.beans.Repository;

interface com.adgamewonderland.ea.nextlevel.interfaces.IRepositoryConnectorListener
{

	public function onRepositoryLoaded(repository:Repository):Void;

	public function onRepositoryUpdated(id:Number):Void;

	public function onRepositorySaved(id:Number):Void;
}