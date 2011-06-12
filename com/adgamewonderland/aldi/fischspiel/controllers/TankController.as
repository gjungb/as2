import mx.utils.Collection;
import mx.utils.CollectionImpl;

import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.aldi.fischspiel.beans.ComputerFish;
import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.beans.UserFish;

import flash.geom.Point;
import flash.geom.Rectangle;
import mx.utils.Iterator;
import com.adgamewonderland.aldi.fischspiel.beans.Level;
import com.adgamewonderland.aldi.fischspiel.controllers.LevelController;
import com.adgamewonderland.aldi.fischspiel.beans.LevelDescription;
import com.adgamewonderland.agw.DES;

class com.adgamewonderland.aldi.fischspiel.controllers.TankController extends DefaultController
{

	private static var instance : TankController;

	private var bounds:Rectangle;

	private var fishes:Collection;

	private var userfish:UserFish;

	private var fishcount:Number;

	private var currentlevel:Number = 1;

	private var level:Level;

	/**
	 * @return singleton instance of TankController
	 */
	public static function getInstance() : TankController
	{
		if (instance == null)
			instance = new TankController();
		return instance;
	}

	public function initTank(aCurrentlevel:Number ):Void
	{
		// currentlevel
		if (isNaN(aCurrentlevel) == false)
			this.currentlevel = aCurrentlevel - 1;
		// fisch des spielers
		addFish("UserFish", 1.5);
		// naechster level
		nextLevel();
	}

	public function nextLevel():Void
	{
		// pruefen, ob noch leben uebrig
		if (getUserfish().getLives() <= 0) {
			// punktzahl
			var score:Number = getUserfish().getScore();
			// fische loeschen
			clearTank();
			// fisch des spielers loeschen
			removeFish(getUserfish(), false);
			// resetten
			resetTank();
			// level resetten
			LevelController.getInstance().clearLevels();
			// zur highscoreliste
			_root.highscore_mc.showGameover(score);
			_root.gotoAndStop("frGameover");

			// abbrechen
			return;
		}
		// level hochzaehlen
		this.currentlevel ++;
		// level laden
		this.level = LevelController.getInstance().getLevel(this.currentlevel);
		// description
		var description:LevelDescription = this.level.getDescription();
		// startgroesse
		getUserfish().setSize(1.5);
		// gewichtszuwachs, bei dem der fisch eine groesse zunimmt
		getUserfish().setGrowthsteps(description.getGrowthsteps());
		// fisch des spielers immunisieren
		getUserfish().startImmunity();
		// anzahl fische einer groesse
		var count:Number;
		// schleife ueber alle groessen
		for (var i : Number = 1; i <= Fish.NUMSIZES; i++) {
			// anzahl fische dieser groesse
			count = description.getFishcount(i);
			// schleife ueber alle fische
			for (var j : Number = 0; j < count; j++) {
				// fisch hinzufuegen
				addFish("ComputerFish", i);
			}
		}
		// listener informieren
		_event.send("onLevelStarted", this.level);
	}

	public function eatFish(aEater:Fish, aEaten:Fish ):Void
	{
//		trace(aEater + " > " + aEaten);

		// listener informieren
		_event.send("onFishEaten", aEater, aEaten);
		// user hat gefressen
		if (aEater instanceof UserFish) {
			// leben abziehen
			aEaten.setLives(aEaten.getLives() - 1);
			// punkte zaehlen
			UserFish(aEater).addScore(aEaten.getSize() * 10);
			// gegner zaehlen
			this.level.getStatistics().addCount(aEaten.getSize());
			// wachsen
			if (UserFish(aEater).addGrowth(aEaten.getSize())) {
				// sound
				_root.sound_mc.setSound("grow", 1);
				// listener informieren
				_event.send("onFishGrown", aEater);
			} else {
				// sound
				_root.sound_mc.setSound("eat", 1);
			}
		}
		// user wurde gefressen
		if (aEaten instanceof UserFish) {
			// pruefen, ob immun
			if (UserFish(aEaten).isImmune() == false) {
				// leben abziehen
				aEaten.setLives(aEaten.getLives() - 1);
				// pruefen, ob noch leben vorhanden
				if (aEaten.getLives() > 0) {
					// immunitaet
					UserFish(aEaten).startImmunity();
				}
				// sound
				_root.sound_mc.setSound("eat", 1);
			}
		}
		// computer haben sich gegenseitig gefressen
		if (aEater instanceof ComputerFish && aEaten instanceof ComputerFish) {
			// leben abziehen
			aEaten.setLives(aEaten.getLives() - 1);
			// sound
			_root.sound_mc.setSound("eat", 1);
		}

		// pruefen, ob noch leben uebrig
		if (aEaten.getLives() <= 0) {
			// computerfisch loeschen und neu anlegen
			if (aEaten instanceof ComputerFish) {
				// den gefressenen entfernen und neu anlegen
				removeFish(aEaten, true);
			}
			// fisch des spielers: level beenden
			if (aEaten instanceof UserFish) {
				// level beenden
				clearLevel();
				// sound
				_root.sound_mc.setSound("gameover", 1);
			}
		}
		// user hat maximalgroesse erreicht
		if (UserFish(aEater).getSize() > Fish.NUMSIZES) {
			// sound
			_root.sound_mc.setSound("level", 1);
			// level beenden
			clearLevel();
		}
	}

	public function getBounds():Rectangle
	{
		return this.bounds;
	}

	public function getFishes():Collection
	{
		return this.fishes;
	}

	public function getUserfish():UserFish
	{
		return this.userfish;
	}

	private function TankController()
	{
		// resetten
		resetTank();
	}

	private function resetTank():Void
	{
		// umrandung / spielflaeche
		this.bounds = new Rectangle(0, 0, 800, 600);
		// alle fische
		this.fishes = new CollectionImpl();
		// der fisch des spielers
		this.userfish = null;
		// anzahl aller erzeugten fische
		this.fishcount = 0;
		// level
		this.currentlevel = 1;
		// das aktuelle level
		this.level = null;
	}

	private function addFish(aType:String, aSize:Number ):Void
	{
		// neuer fisch
		var fish:Fish;
		// je nach typ
		if (aType == "UserFish") {
			// neuer userfish
			fish = new UserFish();
			// als fisch des spielers speichern
			this.userfish = UserFish(fish);
			// position
			var x:Number = getBounds().x + getBounds().width / 2;
			var y:Number = getBounds().y + getBounds().height / 2;

		} else {
			// neuer computerfish
			fish = new ComputerFish();
			// abstand vom rand
			var xdiff:Number = Math.round(Math.random() * 10) * getBounds().width;
			var ydiff:Number = Math.round(Math.random() * getBounds().height);
			// position
			var x:Number = getBounds().x + xdiff;
			var y:Number = getBounds().y + ydiff;
		}
		// groesse
		fish.setSize(aSize);
		// id
		fish.setId(this.fishcount ++);
		// positionieren
		fish.updatePosition(new Point(x, y));
		// zur liste der fische hinzufuegen
		this.fishes.addItem(fish);
		// listener informieren
		_event.send("onFishAdded", fish);
	}

	private function removeFish(aFish:Fish, aNew:Boolean ):Void
	{
		// groesse des fisches
		var size:Number = aFish.getSize();
		// fisch aus liste loeschen
		getFishes().removeItem(aFish);
		// listener informieren
		_event.send("onFishRemoved", aFish);
		// fisch loeschen
		aFish.doUnload();
		// neuer fisch dazu
		if (aNew)
			addFish("ComputerFish", size);
	}

	private function clearTank():Void
	{
		// aktueller fisch
		var fish:Fish;
		// computerfische loeschen
		var iterator:Iterator = getFishes().getIterator();
		while (iterator.hasNext()) {
			// aktueller fisch
			fish = Fish(iterator.next());
			// fisch des spielers ueberspringen
			if (fish instanceof UserFish)
				continue;
			// fisch loeschen
			fish.doUnload();
			// listener informieren
			_event.send("onFishRemoved", fish);
		}
		// liste leeren
		getFishes().clear();
		// fisch des users speichern
		getFishes().addItem(getUserfish());
	}

	private function clearLevel():Void
	{
		// fische loeschen
		clearTank();
		// listener informieren
		_event.send("onLevelCleared", this.level);
	}

}
