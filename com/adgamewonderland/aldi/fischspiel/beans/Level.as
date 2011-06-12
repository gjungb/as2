import com.adgamewonderland.aldi.fischspiel.beans.LevelDescription;
import com.adgamewonderland.aldi.fischspiel.beans.LevelStatistics;
/**
 * @author gerd
 */
class com.adgamewonderland.aldi.fischspiel.beans.Level {

	private var id:Number;

	private var description:LevelDescription;

	private var statistics:LevelStatistics;

	public function Level(aId:Number ) {
		// id
		this.id = aId;
		// description
		this.description = new LevelDescription();
		// statistics
		this.statistics = new LevelStatistics();
	}

	public function getId():Number
	{
		return id;
	}

	public function setDescription(aDescription:LevelDescription ):Void
	{
		this.description = aDescription;
	}

	public function getDescription():LevelDescription
	{
		return this.description;
	}

	public function getStatistics():LevelStatistics
	{
		return this.statistics;
	}

	public function toString() : String {
		return "com.adgamewonderland.aldi.fischspiel.beans.Level: " + this.id;
	}

}