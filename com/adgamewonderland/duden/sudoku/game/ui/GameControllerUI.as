/* * Generated by ASDT*/
import com.adgamewonderland.duden.sudoku.game.ui.*;import mx.utils.Delegate;import com.adgamewonderland.duden.sudoku.game.beans.Grid;
class com.adgamewonderland.duden.sudoku.game.ui.GameControllerUI extends MovieClip {
	private var restart_btn:Button;
	private var sound_btn:Button;	private var solve_btn:Button;
	public function GameControllerUI() {		// restart		restart_btn.onRelease = Delegate.create(this, onRestart);		// sound		sound_btn.onRelease = Delegate.create(this, onSound);		// solve		solve_btn.onRelease = Delegate.create(this, onSolve);
	}
	public function onRestart():Void	{		// spiel neu starten lassen		SudokuUI(_parent).stopGame(false);	}
	public function onSound():Void	{		// globaler sound		var snd:Sound = new Sound();		// lautstarke umschalten		snd.setVolume(snd.getVolume() > 0 ? 0 : 100);	}	public function onSolve():Void	{		// spiel loesen lassen		Grid.getInstance().solveSudoku();	}

}