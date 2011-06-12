import mx.utils.Delegate;

import com.adgamewonderland.agw.interfaces.IRadiobuttonListener;
import com.adgamewonderland.agw.util.RadiobuttonUI;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameStatus;
import com.adgamewonderland.duden.sudoku.challenge.beans.Sudoku;

/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.DifficultyUI extends MovieClip implements IRadiobuttonListener {

	private var radio1_mc:RadiobuttonUI;

	private var radio2_mc:RadiobuttonUI;

	private var radio3_mc:RadiobuttonUI;

	private var prev_btn:Button;

	private var start_btn:Button;

	public function DifficultyUI() {

	}

	public function onLoad():Void
	{
		// zurueck
		prev_btn.onRelease = Delegate.create(this, doStop);
		// starten
		start_btn.onRelease = Delegate.create(this, doStart);
		// nach pause radiobuttons initialisieren
		var interval:Number;
		// funktion
		var doInit:Function = function(mc:DifficultyUI ):Void {
			// abspielen
			mc.initRadiobuttons();
			// interval loeschen
			clearInterval(interval);
		};
		// umschalten
		interval = setInterval(doInit, 25, this);
	}

	public function doStop():Void
	{
		// kein gegner
		GameController.getInstance().setOpponentemail("");
		// challenge formular
		GameController.getInstance().changeStatus(new GameStatus(GameStatus.STATUS_CHALLENGE));
	}

	public function doStart():Void
	{
		// button ausblenden
		start_btn._visible = false;
		// training oder herausforderung
		switch (GameController.getInstance().isTraining()) {
			// training
			case true :
				// sudoku starten lassen
				GameController.getInstance().startSudoku();

				break;
			// herausforderung
			case false :
				// statistik uebersicht
				GameController.getInstance().changeStatus(new GameStatus(GameStatus.STATUS_COMPARISON));

				break;
		}
	}

	public function onRadiobuttonChecked(mc:RadiobuttonUI, status:Boolean ):Void
	{
		// je nach radiobutton
		switch (mc) {
			case radio1_mc :
				radio2_mc.status = false;
				radio3_mc.status = false;
				if (status) GameController.getInstance().setDifficulty(Sudoku.DIFFICULTY_EASY);
				break;
			case radio2_mc :
				radio1_mc.status = false;
				radio3_mc.status = false;
				if (status) GameController.getInstance().setDifficulty(Sudoku.DIFFICULTY_MEDIUM);
				break;
			case radio3_mc :
				radio1_mc.status = false;
				radio2_mc.status = false;
				if (status) GameController.getInstance().setDifficulty(Sudoku.DIFFICULTY_HARD);
				break;
		}
	}

	private function initRadiobuttons():Void
	{
		// als listener bei radiobuttons registrieren
		radio1_mc.addListener(this);
		radio2_mc.addListener(this);
		radio3_mc.addListener(this);
		// radiobutton mit schwierigkeitsgrad aktivieren
		RadiobuttonUI(this["radio" + GameController.getInstance().getDifficulty() + "_mc"]).status = true;
	}

}