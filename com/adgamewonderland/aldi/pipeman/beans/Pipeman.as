/**
 * @author gerd
 */

import com.adgamewonderland.agw.interfaces.ITimeConsumer;
import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.agw.util.Timer;
import com.adgamewonderland.agw.util.XMLConnector;
import com.adgamewonderland.aldi.pipeman.beans.Cell;
import com.adgamewonderland.aldi.pipeman.beans.Grid;
import com.adgamewonderland.aldi.pipeman.beans.Level;
import com.adgamewonderland.aldi.pipeman.beans.Supply;

import de.kruesch.event.EventBroadcaster;
 
class com.adgamewonderland.aldi.pipeman.beans.Pipeman implements ITimeConsumer {
	
	private static var _instance:Pipeman;
	
	private static var LEVELS:String = "ksta_pipeman_levels.xml"; // "aldi_pipeman_levels.xml"; // _global.path + 
	
	private static var SCORE_FLOW:Number = 10;
	
	private static var SCORE_UNUSED:Number = -1;
	
	private static var SCORE_SUCCESS:Number = 250;
	
	private var levels:Array;
	
	private var level:Level;
	
	private var gametimer:Timer;
	
	private var score:Number;
	
	private var _event:EventBroadcaster;
	
	public static function getInstance():Pipeman {
		if (_instance == null)
			_instance = new Pipeman();
		return _instance;
	}
	
	private function Pipeman() {
		this.levels = new Array();
		this.level = null;
		this.gametimer = new Timer();
		this.gametimer.addConsumer(this);
		this.score = 0;
		_event = new EventBroadcaster();
	}
	
	public function addListener(l ):Void
	{
		_event.addListener(l);
	}
	
	public function removeListener(l ):Void
	{
		_event.removeListener(l);
	}
	
	public function loadLevels():Void
	{
		// connector
		var conn:XMLConnector = new XMLConnector(this, _global.path + LEVELS);
		// laden
		conn.loadXML("onLevelsLoaded");
	}
	
	public function onLevelsLoaded(xmlobj:XML ):Void
	{
		// connector
		var conn:XMLConnector = new XMLConnector(null, null);
		// levels
		var levelsXML:XMLNode = xmlobj.firstChild;
		// level
		var level:Level;
		// schleife ueber einzelne level
		for (var i:Number = 0; i < levelsXML.childNodes.length; i++) {
			// level casten
			level = Level(RemotingBeanCaster.getCastedInstance(new Level(), conn.parseXMLNode(levelsXML.childNodes[i])));
			// speichern
			this.levels[level.getId()] = level;
		}
		// event
		_event.send("onLevelsParsed");
	}
	
	public function startPipeman():Void
	{
		// erstes level speichern
		setLevel(this.levels[1]);
		// punkte resetten
		setScore(0);
		// level starten
		startLevel();
	}
	
	public function startLevel():Void
	{
		// grid initialisieren
		Grid.getInstance().initGrid(getLevel());
		// registrieren
		Grid.getInstance().addListener(this);
		// supply initialisieren
		Supply.getInstance().initCurrent();
		// timer initialisieren
		getGametimer().startTime(getLevel().getTime());
		// timer starten
		getGametimer().status = true;
		
		// event
		_event.send("onLevelStarted", getLevel(), getScore(), getGametimer());
	}
	
	public function onFlowStarted():Void
	{
		// zeit stoppen
		getGametimer().status = false;
	}
	
	public function onFlowUpdated(cell:Cell ):Void
	{
		// punkte zaehlen
		setScore(getScore() + (cell.getFlow() ? SCORE_FLOW : 0));
	}
	
	public function onTimeEnded():Void
	{
		// flow starten
		Grid.getInstance().startFlow();
	}
	
	public function onFlowStopped(success:Boolean ):Void
	{
		// punkte addieren fuer erfolg
		setScore(getScore() + (success ? SCORE_SUCCESS : 0));
		// punkte abziehen fuer nicht durchflossene
		setScore(getScore() + Grid.getInstance().getNumUnusedPipes() * SCORE_UNUSED);
		
		// level mit / ohne erfolg beenden
		stopLevel(success);
	}
	
	public function stopLevel(success:Boolean ):Void
	{
		// zeit stoppen
		getGametimer().status = false;
		// deregistrieren
		Grid.getInstance().removeListener(this);
		// aufraeumen
		Grid.getInstance().resetGrid();
		// pruefen ob weitere level vorhanden
		if (!hasNextLevel()) success = false;
		
		// erfolg oder nicht
		switch (success) {
			// erfolg
			case true :
				// naechstes level
				setLevel(this.levels[getLevel().getId() + 1]);
				// event
				_event.send("onLevelStopped", getLevel());
			
				break;	
			// kein erfolg
			case false :
				// zur highscoreliste
				_root.gotoAndStop("frGameover");
				// punkte anzeigen
				_root.highscore_mc.showGameover(getScore());
			
				break;
		}
	}
	
	public function getLevel():Level {
		return level;
	}

	public function setLevel(level:Level):Void {
		this.level = level;
	}

	public function getScore():Number {
		return score;
	}

	public function setScore(score:Number):Void {
		// speichern
		this.score = score;
		// event
		_event.send("onScoreUpdated", getScore());
	}

	public function getGametimer():Timer {
		return gametimer;
	}

	public function setGametimer(gametimer:Timer):Void {
		this.gametimer = gametimer;
	}
	
	private function hasNextLevel():Boolean
	{
		// pruefen, ob naechstes level vorhanden
		return (getLevel().getId() + 1 < this.levels.length);
	}

}