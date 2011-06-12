import com.adgamewonderland.agw.util.DefaultController;
import mx.utils.Collection;
import mx.utils.CollectionImpl;
import com.adgamewonderland.aldi.fischspiel.beans.Level;
import com.adgamewonderland.aldi.fischspiel.beans.LevelDescription;

class com.adgamewonderland.aldi.fischspiel.controllers.LevelController extends DefaultController {

	private static var instance : LevelController;

	private var levels:Collection;

	/**
	 * @return singleton instance of LevelController
	 */
	public static function getInstance() : LevelController {
		if (instance == null)
			instance = new LevelController();
		return instance;
	}

	public function getLevel(aId:Number ):Level
	{
		// pruefen, ob level schon initialisiert
		if (this.levels.isEmpty())
			initLevels();
		// auf maximal level begrenzen
		if (aId > this.levels.getLength())
			aId = this.levels.getLength();
		// gesuchter level
		var level:Level = Level(this.levels.getItemAt(aId - 1));
		// zurueck geben
		return level;
	}

	public function clearLevels():Void
	{
		// level leeren
		this.levels.clear();
	}

	private function LevelController() {
		// die einzelnen level
		this.levels = new CollectionImpl();
	}

	private function initLevels():Void
	{
		// TODO: einzelne level anlegen
		var level:Level;
		var description:LevelDescription;

		// neues level
		level = new Level(this.levels.getLength() + 1);
		// beschreibung ([anzahl der fische je groesse], anzahl zu fressender fische fuer wachstum)
		description = new LevelDescription([10, 0, 0, 0], 4);
		level.setDescription(description);
		// level speichern
		this.levels.addItem(level);

		// neues level
		level = new Level(this.levels.getLength() + 1);
		// beschreibung ([anzahl der fische je groesse], anzahl zu fressender fische fuer wachstum)
		description = new LevelDescription([5, 2, 1, 0], 6);
		level.setDescription(description);
		// level speichern
		this.levels.addItem(level);

		// neues level
		level = new Level(this.levels.getLength() + 1);
		// beschreibung ([anzahl der fische je groesse], anzahl zu fressender fische fuer wachstum)
		description = new LevelDescription([3, 3, 3, 1], 8);
		level.setDescription(description);
		// level speichern
		this.levels.addItem(level);

		// neues level
		level = new Level(this.levels.getLength() + 1);
		// beschreibung ([anzahl der fische je groesse], anzahl zu fressender fische fuer wachstum)
		description = new LevelDescription([3, 3, 2, 2], 10);
		level.setDescription(description);
		// level speichern
		this.levels.addItem(level);

		// neues level
		level = new Level(this.levels.getLength() + 1);
		// beschreibung ([anzahl der fische je groesse], anzahl zu fressender fische fuer wachstum)
		description = new LevelDescription([5, 2, 2, 5], 12);
		level.setDescription(description);
		// level speichern
		this.levels.addItem(level);

	}

}