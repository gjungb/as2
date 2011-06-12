/* 
 * Generated by ASDT 
*/ 

import mx.rpc.ResultEvent;

import com.adgamewonderland.agw.interfaces.ITimeConsumer;
import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.agw.util.Timer;
import com.adgamewonderland.aldi.sudoku.beans.Field;
import com.adgamewonderland.aldi.sudoku.beans.Grid;
import com.adgamewonderland.aldi.sudoku.beans.Result;
import com.adgamewonderland.aldi.sudoku.beans.Solution;
import com.adgamewonderland.aldi.sudoku.connectors.SudokuConnector;
import com.adgamewonderland.aldi.sudoku.interfaces.IGridListener;
import com.adgamewonderland.aldi.sudoku.ui.ClockUI;
import com.adgamewonderland.aldi.sudoku.ui.ContentcounterUI;
import com.adgamewonderland.aldi.sudoku.ui.DifficultyChooserUI;
import com.adgamewonderland.aldi.sudoku.ui.GameControllerUI;
import com.adgamewonderland.aldi.sudoku.ui.GridUI;
import com.adgamewonderland.aldi.sudoku.ui.JokerUI;
import com.adgamewonderland.aldi.sudoku.ui.ResultListUI;

class com.adgamewonderland.aldi.sudoku.ui.GameUI extends MovieClip implements ITimeConsumer, IGridListener {
	
	private static var TIMEGAME:Number = Number.MAX_VALUE;
	
	private static var TIMEERROR:Number = 10;
	
	private static var TIME_EASY:Number = 30 * 60;
	
	private static var TIME_HARD:Number = 60 * 60;
	
	private var gametime:Timer;
	
	private var score:Number = 0;
	
	private var resultlist_mc:ResultListUI;
	
	private var grid_mc:GridUI;
	
	private var clock_mc:ClockUI;
	
	private var joker_mc:JokerUI;
	
	private var contentcounter_mc:ContentcounterUI;
	
	private var controller_mc:GameControllerUI;
	
	private var difficultychooser_mc:DifficultyChooserUI;
	
	private var date:Date;
	
	public function GameUI() {
		// initialisieren
		init();
		// datum
		setDate(null);
	}
	
	public function init():Void
	{
		// punktzahl
		score = 0;
		// dauer des spiels
		gametime = new Timer();
		// contentcounter initialisieren
		contentcounter_mc.init();
		// grid ausblenden
		grid_mc._visible = false;
		// contentcounter ausblenden
		contentcounter_mc._visible = false;
		// controller ausblenden
		controller_mc._visible = false;
		// difficultychooser aktivieren
		difficultychooser_mc.showBlind(false);
		// resultlist einblenden
		resultlist_mc._visible = true;
		// clock resetten
		clock_mc.showTime(gametime);
		// joker initialisieren
		joker_mc.init();
	}
	
	public function startGame():Void
	{
		// initialisieren
		init();
		// als listener registrieren
		Grid.getInstance().addListener(this);
		// grid einblenden
		grid_mc._visible = true;
		// contentcounter einblenden
		contentcounter_mc._visible = true;
		// controller einblenden
		controller_mc._visible = true;
		// difficultychooser deaktivieren
		difficultychooser_mc.showBlind(true);
		// resultlist ausblenden
		resultlist_mc._visible = false;
		// solution laden
		SudokuConnector.getSolution(getDate(), difficultychooser_mc.getDifficulty(), this, "onSolutionLoaded");
	}
	
	public function onSolutionLoaded(re:ResultEvent ):Void
	{
		// reporting
		_root.getReportingProcessor().setTrackpoint(2, "start");
		// loesung
		var solution:Solution = Solution(RemotingBeanCaster.getCastedInstance(new Solution(), re.result));
		// datumsumformung
		solution.setDate(new Date(Number(re.result.date)));
		// grid
		var grid:Grid = Grid.getInstance();
		// grid initialisieren
		if (grid.initGrid(solution)) {
			// fields anzeigen lassen
			grid_mc.initGridUI(grid);
			
		} else {
			// fehlgeschlagen
			trace("konnte grid nicht initialisieren");	
		}
		// zeit initialisieren
		initTime();
	}
	
	public function pauseGame(bool:Boolean ):Void
	{
		// grid abdecken
		grid_mc.showFields(!bool);
		// zeit starten / stoppen
		gametime.status = !bool;
	}
	
	public function restartGame():Void
	{
		// beenden und zur anleitung
		stopGame(false);
	}
	
	public function stopGame(bool:Boolean ):Void
	{
		// uhr stoppen
		gametime.status = false;
		// abstand zur zielzeit
		var timeleft:Number = 0;
		// je nach schwierigkeitsgrad
		if (Grid.getInstance().getSolution().getDifficulty() == Solution.DIFFICULTY_EASY) {
			timeleft = TIME_EASY - gametime.getSeconds()["gone"];
		} else if (Grid.getInstance().getSolution().getDifficulty() == Solution.DIFFICULTY_HARD) {
			timeleft = TIME_HARD - gametime.getSeconds()["gone"];
		}
		// nicht <0
		if (timeleft < 0) timeleft = 0;
		// punkte vergeben
		setScore(timeleft * 10);
		// je nach parameter
		if (bool) {
			// zur highscoreliste
			_root.highscore_mc.showGameover(getScore());
			// weiter auf hauptzeitleiste
			_root.gotoAndStop("frGameover");
		} else {
			// zur anleitung	
			_root.gotoAndStop("frSplash");
		}
		// resetten
		resetGame();
	}
	
	public function onTimeEnded():Void
	{
		// bleibt leer, da endlos viel zeit
	}
	
	public function onError():Void
	{
		// zeit abziehen
		gametime.addTime(TIMEERROR);
	}
	
	public function onGridChanged(field:Field ):Void
	{
	}
	
	public function onGridFinished():Void
	{
		// ergebnis speichern
		resultlist_mc.saveResult(Grid.getInstance().getSolution().getDate(), Grid.getInstance().getSolution().getDifficulty(), gametime.getSeconds()["gone"]);
		// spiel beenden
		stopGame(true);
	}
	
	public function onSelectResult(result:Result ):Void
	{
		// datum speichern
		setDate(result.getDate());
		// schwierigkeitsgrad speichern
		difficultychooser_mc.setDifficulty(result.getDifficulty());
		// resultlist ausblenden
		resultlist_mc.hideList();
		// spiel starten
		startGame();
	}
	
	private function initTime():Void
	{
		// bei uhr anmelden
		gametime.addConsumer(this);
		// movieclip der uhr anmelden
		gametime.addUI(clock_mc);
		// dauer in sekunden uebergeben
		gametime.startTime(TIMEGAME);
		// uhr starten
		gametime.status = true;
	}
	
	private function resetGame():Void
	{
		// grid resetten
		Grid.getInstance().reset();
		// grid ui resetten
		grid_mc.reset();
		// initialisieren
		init();
	}

	public function getDate():Date {
		return date;
	}

	public function setDate(date:Date):Void {
		this.date = date;
	}

	public function getScore():Number {
		return score;
	}

	public function setScore(score:Number):Void {
		this.score = score;
	}

}