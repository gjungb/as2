/* Topnavi
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Topnavi
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		22.05.2004
zuletzt bearbeitet:	27.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

class com.adgamewonderland.eplus.soccer.game.Topnavi extends MovieClip {

	// Attributes
	
	private var instructions_mc:MovieClip, tipps_mc:MovieClip, topteam_mc:MovieClip, highscore1_mc:MovieClip, highscore2_mc:MovieClip;
	
	private var nickname_txt:TextField, rank_txt:TextField, score_txt:TextField;
	
	// Operations
	
	public  function Topnavi()
	{
		// infos ueber user anzeigen
		showUserinfo();
		// buttons initialisieren
		initButtons();
	}
	
	private function initButtons():Void
	{
		// callback bei klick auf "meine tipps"
		tipps_mc.onRelease = function () {
			// bisherige tipps aufrufen
			_global.Game.showTippresult();
		}
		// deaktivieren
		setTippsActive(false);
	}
	
	private  function showUserinfo()
	{
		// user holen
		var user:User = _global.Game.user;
		// textfelder automatische breite
		nickname_txt.autoSize = "left";
		// textfelder automatische breite
		rank_txt.autoSize = score_txt.autoSize = "right";
		// nickname
		nickname_txt.text = user.nickname;
		// rank
		rank_txt.text = user.rank.toString();
		// score
		score_txt.text = user.score.toString();
	}
	
	public function setTippsActive(bool:Boolean ):Void
	{
		// de- / aktivieren
		tipps_mc.enabled = bool;
		// button faden
		tipps_mc._alpha = (bool ? 100 : 50);
	}

} /* end class Topnavi */
