import com.adgamewonderland.duden.sudoku.challenge.beans.Challenge;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;
import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail;
import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeImpl;
import com.adgamewonderland.duden.sudoku.challenge.beans.Result;
import com.adgamewonderland.agw.util.TimeFormater;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.ResultUI extends MovieClip {

	private var _mode:Number;

	private var nickname_txt:TextField;

	private var time_txt:TextField;

	private var errors_txt:TextField;

	private var penaltytime_txt:TextField;

	private var totaltime_txt:TextField;

	private var score_txt:TextField;

	private var bonus_txt:TextField;

	private var totalscore_txt:TextField;

	public function ResultUI() {
		// alle textfelder linksbuendig
		for (var i:String in this) {
			if (this[i] instanceof TextField) TextField(this[i]).autoSize = "left";
		}
	}

	public function onLoad():Void
	{
		// aktuelle herausforderung
		var challenge:ChallengeImpl = GameController.getInstance().getChallenge();
		// details der herausforderung
		var challengedetail:ChallengeDetail = challenge.getDetail(_mode);
		// nickname anzeigen
		nickname_txt.text = challengedetail.getUser().getNickname();
		// ergebnis
		var result:Result = challengedetail.getResult();
		// ergebnis anzeigen
		showResult(result);
	}

	private function showResult(result:Result ):Void
	{
		// alle werte anzeigen
		time_txt.text = TimeFormater.getHoursMinutesSeconds(result.getTime(), ":");
		errors_txt.text = String(result.getErrors());
		penaltytime_txt.text = TimeFormater.getHoursMinutesSeconds(result.getPenaltytime(), ":");
		totaltime_txt.text = TimeFormater.getHoursMinutesSeconds(result.getTime() + result.getPenaltytime(), ":");
		score_txt.text = String(result.getScore());
		bonus_txt.text = String(result.getBonus());
		totalscore_txt.text = String(result.getScore() + result.getBonus());
	}

}