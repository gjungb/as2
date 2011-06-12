import com.adgamewonderland.duden.sudoku.challenge.beans.Challenge;
import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeDetail;
import com.adgamewonderland.duden.sudoku.challenge.beans.User;

class com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeImpl extends Challenge
{

	public function ChallengeImpl() {
		super();
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeImpl", ChallengeImpl);
	}

	public function getDetail(mode:Number):ChallengeDetail
	{
		// detail passend zum modus zurueck geben
		return (this.details[mode]);
	}

	public function addDetail(mode:Number, detail:ChallengeDetail):Void
	{
		// detail passend zum modus speichern
		this.details[mode] = detail;
	}

	public function getWinner():User
	{
		// gewinner ermitteln (bei unentschieden wird leerer user zurueck gegeben)
		var winner:User = new User();
		// details des herausforderers
		var challengerdetail:ChallengeDetail = getDetail(ChallengeDetail.MODE_CHALLENGER);
		// details des herausforderers
		var opponentdetail:ChallengeDetail = getDetail(ChallengeDetail.MODE_OPPONENT);
		// gewinner je nach status
		if (challengerdetail.getStatus() == ChallengeDetail.STATUS_WON) {
			winner = challengerdetail.getUser();
		}
		if (opponentdetail.getStatus() == ChallengeDetail.STATUS_WON) {
			winner = opponentdetail.getUser();
		}
		// zurueck geben
		return winner;
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeImpl\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}
		str += getDetail(ChallengeDetail.MODE_CHALLENGER) + "\r";
		str += getDetail(ChallengeDetail.MODE_OPPONENT) + "\r";

		return str;
	}
}