/* HighscoreUI
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			HighscoreUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			blaupunkt
erstellung: 		21.04.2004 (e-plus)
zuletzt bearbeitet:	08.08.2005
durch			gj
status:			in bearbeitung
*/

import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

import com.adgamewonderland.blaupunkt.dtmracing.remoting.*;

import com.adgamewonderland.blaupunkt.dtmracing.statistic.*;

import com.adgamewonderland.blaupunkt.dtmracing.ui.*;

class com.adgamewonderland.blaupunkt.dtmracing.ui.HighscoreUI extends MovieClip {

	// Attributes
	
	private var myMode:String;
	
	private var myPosition:Object;
	
	private var myTracks:Array;
	
	private var myButtons:Array;
	
	private var list_mc:MovieClip;
	
	private var dropdown_mc:DropdownUI;
	
	private var prev_btn:Button;
	
	private var next_btn:Button;
	
	private var headline_txt:TextField;
	
	private var rank_txt:TextField;
	
	private var score_txt:TextField;
	
	// Operations
	
	public function HighscoreUI()
	{
		 // modus, in dem die liste angezeigt wird (allstars, track)
		myMode = "";
		// angezeigte positionen (start, count)
		myPosition = {start : 1, count : 10, end : 100};
		// rennstrecken
		myTracks = ChallengeController.getInstance().getTracks();
		// dropdown initialisieren
//		initDropdown(); (geht nicht, da noch nicht bekannt)
		// buttons
		myButtons = [prev_btn, next_btn];
		// buttons initialisieren
		initButtons();
		// punktzahl
		score_txt.autoSize = "right";
	}
	
	public function set mode(str:String ):Void
	{
		// mode
		myMode = str;
	}
	
	public function get mode():String
	{
		// mode
		return (myMode);
	}
	
	public function set position(obj:Object ):Void
	{
		// position
		myPosition = obj;
	}
	
	public function get position():Object
	{
		// position
		return (myPosition);
	}
	
	public function changeMode(modestr:String ):Void
	{
		// abbrechen, wenn nicht veraendert
		if (modestr == mode) return;
		// neuen wert speichern
		mode = modestr;
		// dropdown aktualisieren
		initDropdown(modestr);
	}
	
	public function changeTrack():Void
	{
		// ganz nach links
		changePosition(0);
	}
	
	public function changePosition(dir:Number ):Void
	{
		// je nach richtung
		switch (dir) {
			// ganz nach links
			case 0 :
				// start auf 1
				position.start = 1;
				// ende auf count
//				position.end = position.count;
			
				break;
			// nach links
			case -1 :
				// testen, ob erlaubt
				if (position.start - position.count > 0) position.start -= position.count;
			
				break;
			// nach rechts
			case 1 : 
				// testen, ob erlaubt
				if (position.start + position.count <= position.end) position.start += position.count;
			
				break;
		}
		// buttons updaten
		updateNavi();
		// liste loeschen
		clearList();
		// liste laden
		loadHighscore(dropdown_mc.current);
	}
	
	public function initDropdown():Void
	{
		// dropdown einklappen
		dropdown_mc.showItems(false);
		// callback
		var callback:String = "changeTrack";
		// ydiff
		var ydiff:Number = 14;
		// name des dropdown
		var name:String = "Allstars";
		// sichtbare items im dropdown
		var items:Array = ["Allstars"];
		// unsichtbare werte im dropdown
		var values:Array = [0];
		// schleife ueber rennstrecken
		for (var i:Number = 0; i < myTracks.length; i++) {
			// aktuelle strecke
			var track:Track = myTracks[i];
			// trainingsstrecke auslassen
			if (track.getTid() == ChallengeController.TID_TRAINING) continue;
			// name der strecke
			items.push(track.getName());
			// tid der strecke
			values.push(track.getTid());
		}
		// dropdown aufbauen
		dropdown_mc.initDropdownUI(name, items, values, this, callback, ydiff);
		// einblenden
		dropdown_mc._visible = true;
		// allstars auswaehlen
		dropdown_mc.onSelectItem(0);
	}
	
	private function loadHighscore(tid:Number ):Void
	{
		// allstars
		if (tid == 0) {
			// liste der punktzahlen laden
			StatisticConnector.loadScoreAllstars(position.start - 1, position.count, this, "onHighscoreLoaded");
			// allstars platzierung und punktzahl
			updateAllstars();
			
//			// punktzahl des users
//			var score:String = MainUI(_parent).getInfobox().getUserStatisticUI().getScoreAllstars();
//			// platzierung des users
//			var rank:String = MainUI(_parent).getInfobox().getUserStatisticUI().getRankAllstars();
//			// anzeigen
//			if (score != "") {
//				// anzeigen
//				rank_txt.text = rank;
//				score_txt.text = score;
//				
//			} else {
//				// spiegelstriche
//				rank_txt.text = score_txt.text = "-";
//			}
		// strecke	
		} else {
			// liste der bestzeiten laden
			StatisticConnector.loadScoreTrack(tid, position.start - 1, position.count, this, "onHighscoreLoaded");
			// statitic des users auf dieser strecke
			var statistic:UserTrackStatistic = MainUI(_parent).getInfobox().getUserStatisticUI().getUserTrackStatistic(tid);
			// wenn vorhanden, platzierung laden
			if (statistic != null) {
				// rennzeit
				var racetime:Number = statistic.getRacetime();
				// anzeigen
				score_txt.text = TimeFormater.getMinutesSecondsMilliseconds(racetime);
				// platzierung laden
				StatisticConnector.loadRankTrack(tid, racetime, this, "onRankTrackLoaded");
			} else {
				// spiegelstriche
				rank_txt.text = score_txt.text = "-";
			}
		}
	}
	
	public function onHighscoreLoaded(re:ResultEvent ):Void
	{
//		// positionen anzeige updaten
//		updatePosition();
		// anzeigen
		showHighscore(re.result);
	}
	
	public function updateAllstars():Void
	{
		// punktzahl des users
		var score:String = MainUI(_parent).getInfobox().getUserStatisticUI().getScoreAllstars();
		// platzierung des users
		var rank:String = MainUI(_parent).getInfobox().getUserStatisticUI().getRankAllstars();
		// anzeigen
		if (score != "") {
			// anzeigen
			rank_txt.text = rank;
			score_txt.text = score;
			
		} else {
			// spiegelstriche
			rank_txt.text = score_txt.text = "-";
		}
	}
	
	public function onRankTrackLoaded(re:ResultEvent ):Void
	{
		// platzierung anzeigen
		rank_txt.text = String(re.result);
	}
	
	private function showHighscore(highscore:Array ):Void
	{
		// dummy
		var dummy:MovieClip = list_mc.dummy_mc;
		// hoehe des dummy
		var ydiff = dummy._height - 2;
		// platzierung
		var rank:Number = position.start - 1;
		// aktuelle punktzahl
		var score:Number = Number.MAX_VALUE;
		
		// schleife ueber alle user
		for (var i = 1; i <= highscore.length; i ++) {
			// aktueller user
			var user:Object = highscore[i - 1];
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy._y + (i - 1) * ydiff;
			// score
			constructor._myScore = (dropdown_mc.current == 0 ? user.score + " PKT" : TimeFormater.getMinutesSecondsMilliseconds(user.score));
			// wenn neuer score, rank hochzaehlen
			if (constructor._myScore != score) {
				// rank
				rank ++;
				// neuen score merken
				score = constructor._myScore;	
			}
			// rank
			constructor._myRank = rank + ".";
//			constructor._myRank = position.start + (i - 1) + ".";
			// nickname
			constructor._myNickname = user.nickname;
			// email (fuer herausforderung
			constructor._myEmail = user.email;
			// referenz auf main
			constructor._myMainUI = MainUI(_parent);
			// dummy duplizieren
			var pos_mc:MovieClip = dummy.duplicateMovieClip("pos" + i + "_mc", i + 1, constructor);
			// callback bei klick
			pos_mc.onRelease = function() {
				// herausfordern
				this._myMainUI.initChallenge(this._myEmail);
			};
		}
		// dummy unsichtbar
		dummy._visible = false;
	}
	
	private function clearList():Void
	{
		// zaehler
		var i = 0;
		// schleife ueber alle angezeigten user
		while (list_mc["pos" + (++i) + "_mc"] instanceof MovieClip) list_mc["pos" + i + "_mc"].removeMovieClip();
		// punkte / rennzeit loeschen
		score_txt.text = "";
		// position loeschen
		rank_txt.text = "";
	}
	
	private function updateNavi():Void
	{
		// nach links button
		prev_btn._visible = (position.start - position.count > 0);
		// nach rechts button
		next_btn._visible = (position.start + position.count <= position.end);
	}
	
//	private function updatePosition():Void
//	{
//		// position anzeigen
//		rank_txt.autoSize = "left";
//		rank_txt.text = "Platz " + position.start + " - " + (position.start + position.count - 1);
//	}
	
	private function initButtons():Void
	{
		// nach links button
		prev_btn.onRelease = function () {
			this._parent.changePosition(-1);
		};
		// nach rechts button
		next_btn.onRelease = function () {
			this._parent.changePosition(1);
		};
	}
	
	private function showButtons(bool:Boolean ):Void
	{
		// schleife ueber alle buttons
		for (var i:String in myButtons) myButtons[i].enabled = bool;
	}

} /* end class HighscoreUI */
