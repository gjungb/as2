/**
 * @author gerd
 */
 
import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;
 
class com.adgamewonderland.digitalbanal.elfmeterduell.ui.ScoreUI extends MovieClip {
	
	private var nick_challenger_txt:TextField;
	
	private var nick_opponent_txt:TextField;
	
	private var next_btn:Button;
	
	public function ScoreUI() {
		// textfelder zentriert
		nick_challenger_txt.autoSize = "center";
		nick_opponent_txt.autoSize = "center";
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
		
	 	// button weiter
	 	next_btn.onRelease = function () {
	 		this._parent.showResult();
	 	};
	}
	
	public function showResult():Void
	{
		// gelbe karte ausblenden
		CardaniUI.getCardaniUI().showCardani(false);
		// ergebnis anzeigen
		ResultUI.getResultUI().showResult();
	}
}