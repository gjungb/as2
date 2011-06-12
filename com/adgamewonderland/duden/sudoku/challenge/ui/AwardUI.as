import com.adgamewonderland.duden.sudoku.challenge.ui.ResultUI;
import mx.utils.Delegate;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;
import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeImpl;
import com.adgamewonderland.duden.sudoku.challenge.beans.User;
import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.AwardUI extends MovieClip {

	private var result0_mc:ResultUI;

	private var result1_mc:ResultUI;

	private var message_txt:TextField;

	private var next_btn:Button;

	public function AwardUI() {

	}

	public function onLoad():Void
	{
		// aktuell eingeloggter user
		var user:User = GameController.getInstance().getUser();
		// aktuelle herausforderung
		var challenge:ChallengeImpl = GameController.getInstance().getChallenge();
		// herausforderer
		var challenger:User = challenge.getDetail(ChallengeDetail.MODE_CHALLENGER).getUser();
		// sieger der herausforderung
		var winner:User = challenge.getWinner();
		// nachricht, je nachdem, ob sieger, verlierer, oder unentschieden
		if (user.getID() == winner.getID()) {
			// sieger
			message_txt.text = "Herzlichen Glückwunsch!\r\nSie haben gewonnen.";
		}
		if (user.getID() != winner.getID()) {
			// verlierer
			message_txt.text = "Schade!\r\nSie haben leider verloren.";
		}
		if (winner.getID() == 0) {
			// unentschieden
			message_txt.text = "Unentschieden!";
		}

		// result des eingeloggten users soll immer links stehen
		if (user.getID() != challenger.getID()) {
			// positionen der results tauschen
			var x:Number = result1_mc._x;
			// rechts nach links
			result1_mc._x = result0_mc._x;
			// links nach rechts
			result0_mc._x = x;
		}

		// weiter
		next_btn.onRelease = Delegate.create(this, doNext);
	}

	private function doNext():Void
	{
		// siegerehrung beenden
		GameController.getInstance().finishAward();
	}

}