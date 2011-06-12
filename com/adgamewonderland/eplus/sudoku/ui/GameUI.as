import com.adgamewonderland.aldi.sudoku.beans.Grid;
import com.adgamewonderland.aldi.sudoku.beans.Solution;
import mx.rpc.ResultEvent;
import com.adgamewonderland.aldi.sudoku.beans.Field;
import com.adgamewonderland.aldi.sudoku.beans.Content;
import com.adgamewonderland.agw.util.Timer;
import com.adgamewonderland.aldi.sudoku.ui.ClockUI;
import com.adgamewonderland.eplus.sudoku.connectors.SudokuConnector;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.sudoku.ui.GameUI extends com.adgamewonderland.aldi.sudoku.ui.GameUI {

	public function GameUI() {
		super();
	}

	public function init():Void
	{
		super.init();
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

		// connector
		var connector:SudokuConnector = new SudokuConnector();
		// solution laden
		var solution:Solution = connector.getSolution(difficultychooser_mc.getDifficulty(), this, "onSolutionLoaded");
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

	public function onSolutionLoaded(re:ResultEvent ):Void
	{
		super.onSolutionLoaded(re);
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

}