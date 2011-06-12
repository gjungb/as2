import mx.utils.Collection;

import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.agw.util.RandomUtil;
import com.adgamewonderland.kalaydo.messequiz.ui.QuizUI;

/**
 * @author gerd
 */
class com.adgamewonderland.kalaydo.messequiz.controllers.QuizController extends DefaultController {

	private static var instance:QuizController;

	private static var TASKS:Number = 4;

	private var figures:Array;

	private var tasks:Collection;

	private var currenttask:Number;

	private var correct:Number;

	private var winner:Number;

	private var ui:QuizUI;

	/**
	 * @return singleton instance of QuizController
	 */
	public static function getInstance():QuizController {
		if (instance == null)
			instance = new QuizController();
		return instance;
	}

	private function QuizController() {

	}

	public function initQuiz(ui:QuizUI ):Void
	{
		// quiz ui
		this.ui = ui;
		// status der figuren
		this.figures = new Array(TASKS + 1);
		// aktulle aufgabe
		this.currenttask = 0;
		// anzahl korrekt beantworteter aufgaben
		this.correct = 0;
		// anzahl verfuegbarer aufgaben
		var numtasks = this.ui.getNumTasks();
		// zufaellige aufgaben
		this.tasks = RandomUtil.getRandomValues(1, numtasks, TASKS);
		// gewinner
		this.winner = 0;
		// naechste aufgabe
		nextTask();
	}

	public function solveTask(aCorrect:Boolean ):Void
	{
		// anzahl korrekt beantworteter aufgaben
		this.correct += (aCorrect ? 1:0);
		// wenn korrekt, figur streichen
		if (aCorrect) {
			// zufaelliger index
			var rand:Number = RandomUtil.getRandomIndex(this.figures);
			// figur streichen
			this.figures[rand] = true;
		}
		// listener informieren
		_event.send("onTaskSolved", aCorrect, this.figures);
		// naechste aufgabe
//		nextTask();
	}

	public function solveGuess(aFigure:Number ):Void
	{
		// anzahl verbleibender figuren
		var numfigures:Number = TASKS - this.correct + 1;
		// per zufall entscheiden
		var won:Boolean = Math.random() < 1 / numfigures;
		// entsprechend verzweigen
		if (won) {
			// gewinner
			this.winner = aFigure;
		}
		// listener informieren
		_event.send("onGuessFinished", won);

	}

	public function getWinner():Number
	{
		return this.winner;
	}

	public function nextTask():Void
	{
		// hochzaehlen
		if (++this.currenttask > TASKS) {
			// beenden
			finishQuiz();
			// abbrechen
			return;
		}
		// aufgabe
		var task:Number = Number(this.tasks.getItemAt(this.currenttask - 1));
		// anzeigen lassen
		this.ui.showTask(task, this.currenttask, TASKS);
	}

	private function finishQuiz():Void
	{
		// gewonnen oder nicht
		var won:Boolean = this.correct == TASKS;
		// entsprechend verzweigen
		if (won) {
			// welche figur ausgewaehlt
			for (var i : Number = 0; i < figures.length; i++) {
				// gewinner
				if (this.figures[i] != true)
					this.winner = i + 1;
			}
		}
		// listener informieren
		_event.send("onQuizFinished", won);
	}

}