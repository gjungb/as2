/* 
 * Generated by ASDT 
*/ 

/*
klasse:			UserStatisticUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.06.2005
zuletzt bearbeitet:	08.08.2005
durch			gj
status:			in bearbeitung
*/

import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.adgamewonderland.agw.net.*;

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

import com.adgamewonderland.blaupunkt.dtmracing.remoting.*;

import com.adgamewonderland.blaupunkt.dtmracing.statistic.*;

import com.adgamewonderland.blaupunkt.dtmracing.ui.*;

class com.adgamewonderland.blaupunkt.dtmracing.ui.UserStatisticUI extends MovieClip {
	
	private var _myMode:Number;
	
	private var myTid:Number;
	
	private var myStatistic:UserStatistic;
	
	private var myInterval:Number;

    private var persbest1_txt:TextField;

    private var persbest2_txt:TextField;

    private var racetime1_txt:TextField;

    private var racetime2_txt:TextField;

    private var rank1_txt:TextField;

    private var rank2_txt:TextField;
	
    private var numraces1_txt:TextField;
	
    private var numraces2_txt:TextField;

    private var numwins1_txt:TextField;

    private var numwins2_txt:TextField;

    private var numlosses1_txt:TextField;

    private var numlosses2_txt:TextField;

    private var ratewins1_txt:TextField;

    private var ratewins2_txt:TextField;

    private var scoreallstars1_txt:TextField;

    private var scoreallstars2_txt:TextField;
    
    private var nickname1_txt:TextField;
    
    private var nickname2_txt:TextField;
	
	public function UserStatisticUI()
	{
		// tid
		myTid = null;
		// alle textfelder linksbuendig
		for (var i:String in this) {
			// textfeld
			if ((this[i] instanceof TextField) && (this[i].type == "dynamic")) this[i].autoSize = "left";
		}
		// ausser nicknamen
		nickname1_txt.autoSize = nickname2_txt.autoSize = "none";
		// persoenliche bestzeit ausblenden
		persbest1_txt._visible = persbest2_txt._visible = false;
	}
	
	public function init():Void
	{
		// sofort statistik aufrufen (schlaegt fehl)
//		loadUserStatistic();
		// nach pause statistik nochmal aufrufen
		myInterval = setInterval(this, "loadUserStatistic", 1000);
	}
	
	public function loadUserStatistic():Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// uid des users 
		var uid:Number;
		// je nach modus
		switch (_myMode) {
			// challenger
			case ChallengeDetail.MODE_CHALLENGER :
				// eingeloggter user
				uid = ChallengeController.getInstance().getUser().getUid();
				
				break;
			// opponent
			case ChallengeDetail.MODE_OPPONENT :
				// herausgeforderter gegner
				uid = ChallengeController.getInstance().getOpponent().getUid();
				// wenn unbekannt, nur email anzeigen
				if (uid == undefined) {
					// alle textfelder spiegelstriche
					var subst:String = "-";
					rank1_txt.text = rank2_txt.text = subst;
					scoreallstars1_txt.text = scoreallstars2_txt.text = subst;
					numraces1_txt.text = numraces2_txt.text = subst;
					numwins1_txt.text = numwins2_txt.text = subst;
					numlosses1_txt.text = numlosses2_txt.text = subst;
					ratewins1_txt.text = ratewins2_txt.text = subst;
					// email anstatt nickname
					nickname1_txt.text = nickname2_txt.text = ChallengeController.getInstance().getOpponent().getEmail();
					// abbrechen
					return;
				}
			
				break;
		}
		// statistik laden
		StatisticConnector.loadUserStatistic(uid, this, "onUserStatisticLoaded");
	}
	
	public function onUserStatisticLoaded(re:ResultEvent ):Void
	{
		// neue statistik
		myStatistic = UserStatistic(RemotingBeanCaster.getCastedInstance(new UserStatistic(), re.result));
		// statistiken des users auf den strecken
		var trackstats:Array = myStatistic.getTrackstats();
		// alle in UserTrackStatistic casten
		for (var i:String in trackstats) {
			// neue statistik
			var statistic:UserTrackStatistic = UserTrackStatistic(RemotingBeanCaster.getCastedInstance(new UserTrackStatistic(), trackstats[i]));
			// speichern
			trackstats[i] = statistic;
		}
		// anzeigen
		showUserStatistic(myStatistic);
		// statistik des users auf der strecke
		if (myTid != null) showUserTrackStatistic(myTid);
		// allstar platzierung laden
		loadRankAllstars();
	}
	
	public function showUserStatistic(statistic:UserStatistic ):Void
	{
		// schleife ueber alle variablen
		for (var index:String in statistic) {
			// aktueller wert
			var value:Number = statistic[index];
			// als string
			var str:String = String(value);
			// quote in prozent
			if (index == "ratewins") {
				// prozent
				str += "%";
			}
			// 0 durch spiegelstrich ersetzen
			if (value == 0) str = "-";
			// textfelder befuellen
			this[index + "1_txt"].text = this[index + "1_txt"].text = str;
		}
	}
	
	public function showUserTrackStatistic(tid:Number ):Void
	{
		// tid
		myTid = tid;
		// statistik des users auf der strecke
		var statistic:UserTrackStatistic = getUserTrackStatistic(tid);
		// persoenliche bestzeit einblenden
		persbest1_txt._visible = persbest2_txt._visible = true;
		// abbrechen, wenn nicht gefunden
		if (statistic == null) {
			// racetime ausblenden
			racetime1_txt.text = racetime2_txt.text = "-";
			// abbrechen
			return;
		}
		// racetime anzeigen
		racetime1_txt.text = racetime2_txt.text = TimeFormater.getMinutesSecondsMilliseconds(statistic.getRacetime());
	}
	
	public function getUserTrackStatistic(tid:Number ):UserTrackStatistic
	{
		// alle statistiken des users auf der strecke
		var trackstats:Array = myStatistic.getTrackstats();
		// schleife ueber alle
		for (var i:String in trackstats) {
			// aktuelle statistik
			var statistic:UserTrackStatistic = trackstats[i];
			// zurueck geben, wenn zu dieser strecke gehoerig
			if (statistic.getTid() == tid) return statistic;
		}
		// nichts gefunden
		return null;
	}
	
	public function loadRankAllstars():Void
	{
		// punktzahl
		var score:Number = Number(scoreallstars1_txt.text);
		// platzierung laden lassen
		StatisticConnector.loadRankAllstars(score, this, "onRankAllstarsLoaded");
	}
	
	public function onRankAllstarsLoaded(re:ResultEvent ):Void
	{
		// anzeigen
		rank1_txt.text = rank2_txt.text = String(re.result);
		// anzeige auch in highscoreliste updaten
		MainUI(_parent._parent).getHighscore().updateAllstars();
	}
	
	public function getScoreAllstars():String
	{
		return(scoreallstars1_txt.text);
	}
	
	public function getRankAllstars():String
	{
		return(rank1_txt.text);
	}
}