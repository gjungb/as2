/**
 * @author gerd
 */
 
import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;
 
import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.Score2UI extends MovieClip {
	
	private var nick_challenger_txt:TextField;
	
	private var nick_opponent_txt:TextField;
	
	private var goals_challenger_txt:TextField;
	
	private var goals_opponent_txt:TextField;
	
	public function Score2UI() {
		// text zentriert
		nick_challenger_txt.autoSize = "center";
		nick_opponent_txt.autoSize = "center";
		goals_challenger_txt.autoSize = "center";
		goals_opponent_txt.autoSize = "center";
	}
	
	public function init():Void
	{
		// aktuelles game
		var game:GameImpl = GameController.getInstance().getGame();
		// details herausforderer
		var challengerdetails:GameDetail = game.getDetail(GameDetail.MODE_CHALLENGER);
		// details gegner
		var opponentdetails:GameDetail = game.getDetail(GameDetail.MODE_OPPONENT);
		// nicknamen anzeigen
		nick_challenger_txt.text = challengerdetails.getUser().getNickname();
		nick_opponent_txt.text = opponentdetails.getUser().getNickname();
		// anzahl tore anzeigen
		goals_challenger_txt.text = String(challengerdetails.getGoals());
		goals_opponent_txt.text = String(opponentdetails.getGoals());
		// navigation einblenden
		NavigationUI.getNavigationUI().showNavi(true);
		
		// spiel resetten
		GameController.getInstance().resetGame();
	}
}