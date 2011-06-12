import com.adgamewonderland.duden.sudoku.challenge.beans.GameStatus;
/**
 * @author gerd
 */
interface com.adgamewonderland.duden.sudoku.challenge.interfaces.IGameListener {

	public function onChangeStatus(oldstatus:GameStatus, newstatus:GameStatus ):Void;

}