/**
 * @author gerd
 */
 
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;
import mx.remoting.RecordSet;
import mx.utils.Iterator;

import com.adgamewonderland.agw.*;

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventskalender.beans.*;

import com.adgamewonderland.dhl.adventskalender.connectors.*;

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.HighscoreUI extends MovieClip {
	
	private static var LIST_COUNT:Number = 50;
	
	private var myCalendarUI:CalendarUI;
	
	private var score:Score;
	
	private var game:Game;
	
	private var rank:Number;
	
	private var myLso:SharedObject;
	
	private var game_txt:TextField;
	
	private var points_txt:TextField;
	
	private var name_txt:TextField;
	
	private var email_txt:TextField;
	
	private var error_txt:TextField;
	
	private var rank_txt:TextField;
	
	private var send_btn:Button;
	
	private var win_btn:Button;
	
	private var close_btn:Button;
	
	private var list_mc:MovieClip;
	
	private var scrollbar_mc:ScrollbarUI;
	
	public function HighscoreUI() {
		myCalendarUI = CalendarUI(_parent);
		// infos ueber spiel
		this.game = null;
		// infos ueber erzielte punkte
		this.score = null;
		// erzielte platzierung
		this.rank = 0;
		// lso zum speichern / laden von nickname und email
		this.myLso = SharedObject.getLocal("dhl_adventskalender");
	}
	
	public function showInput(game:Game, points:Number ):Void
	{
		// infos ueber spiel
		setGame(game);
		// infos ueber erzielte punkte
		setScore(new Score());
		// gid
		getScore().setGid(getGame().getId());
		// score
		getScore().setScore(points);
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "initInput");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// zur dateneingabe
		gotoAndPlay("frInput");
	}
	
	public function initInput():Void
	{
		// name des spiels
		game_txt.autoSize = "left";
		game_txt.text = getGame().getName();
		// erzielte punktzahl
		points_txt.autoSize = "left";
		points_txt.text = String(getScore().getScore());
		
	 	// button send
	 	send_btn.onRelease = function () {
	 		this._parent.sendScore();
	 	};
	 	// button gewinnformular
	 	win_btn.onRelease = function () {
	 		this._parent.stopHighscore(GameUI.MODE_WIN);
	 	};
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.stopHighscore(GameUI.MODE_CLOSE);
	 	};
		// tabsetter
		var index:Number = 0;
		name_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		// nickname
	 	name_txt.text = (typeof myLso.data.nickname != "undefined" ? myLso.data.nickname : "");
		// email
	 	email_txt.text = (typeof myLso.data.email != "undefined" ? myLso.data.email : "");
	}
	
	public function stopHighscore(mode:Number ):Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onHighscoreFinished", mode);
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frClose1");
	}
	
	public function sendScore():Void
	{
		// user
		var user:User = new User();
		user.setName(name_txt.text);
		user.setEmail(email_txt.text);
		
		// abbrechen, wenn fehlerhaft
		if (!checkForm(user)) {
			// meldung
			error_txt.text = "Angaben nicht korrekt!";
			// abbrechen
			return;
		}
		// meldung anzeigen
		error_txt.text = "Daten werden gesendet!";
		// button ausblenden
		send_btn._visible = false;
		// nickname lokal speichern
		myLso.data.nickname = user.getName();
		// email lokal speichern
		myLso.data.email = user.getEmail();
		// speichern
		myLso.flush();
		
		// user
		getScore().setUser(user);
		// score senden lassen
		CalendarConnector.saveScore(getScore(), this, "onScoreSent");
	}
	
	public function onScoreSent(re:ResultEvent ):Void
	{
		// testen, ob senden erfolgreich
		if (re.result == 0) {
			// meldung anzeigen
			error_txt.text = "Senden fehlgeschlagen!";
			// button einblenden
			send_btn._visible = true;
			// abbrechen
			return;	
		}
		// erzielte platzierung
		setRank(re.result);
		
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onHighscoreFinished", GameUI.MODE_HIGHSCORE);
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frClose1");
	}
	
	public function showOutput():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "initOutput");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// zur dateneingabe
		gotoAndPlay("frOutput");
	}
	
	public function initOutput():Void
	{
		// name des spiels
		game_txt.autoSize = "left";
		game_txt.text = getGame().getName();
		// erzielte punktzahl
		points_txt.autoSize = "left";
		points_txt.text = String(getScore().getScore());
		// erzielte platzierung
		rank_txt.autoSize = "left";
		rank_txt.text = String(getRank());
		
	 	// button gewinnformular
	 	win_btn.onRelease = function () {
	 		this._parent.stopHighscore(GameUI.MODE_WIN);
	 	};
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.stopHighscore(GameUI.MODE_CLOSE);
	 	};
	 	// highscoreliste laden lassen
		CalendarConnector.loadHighscore(getGame().getId(), LIST_COUNT, this, "onHighscoreLoaded");
	}
	
	public function onHighscoreLoaded(re:ResultEvent ):Void
	{
		// liste als record set
		var highscore:RecordSet = RecordSet(re.result);
		// iterator fuer alle user
		var iterator:Iterator = highscore.getIterator();
		// dummy
		var dummy_mc:MovieClip = list_mc.dummy_mc;
		// hoehe des dummy
		var ydiff:Number = dummy_mc._height + 1;
		// aktuell angezeigter platz
		var position:Number = 0;
		// schleife ueber alle user
		while (iterator.hasNext()) {
			// naechter angezeigter platz
			position++;
			// aktueller user aus record set
			var user:Object = iterator.next();
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy_mc._y + (position - 1) * ydiff;
			// dummy duplizieren
			var pos_mc:MovieClip = dummy_mc.duplicateMovieClip("pos" + position + "_mc", position + 1, constructor);
			// position mit fuehrender 0
			pos_mc.position_txt.autoSize = "right";
			pos_mc.position_txt.text = String(position);
			// nickname
			pos_mc.nickname_txt.autoSize = "left";
			pos_mc.nickname_txt.text = user["nickname"];
			// score
			pos_mc.score_txt.autoSize = "left";
			pos_mc.score_txt.text = user["score"];
		}
		// dummy unsichtbar
		dummy_mc._visible = false;
		// scrollbar initialisieren
		scrollbar_mc.setScrollTarget(list_mc);
	}
	
	public function onHighscoreFinished(mode:Number ):Void
	{
		// je nach modus verzweigen
		if (mode == GameUI.MODE_HIGHSCORE) {
			showOutput();
		} else if (mode == GameUI.MODE_WIN) {
			myCalendarUI.showWin();
		} else if (mode == GameUI.MODE_CLOSE) {
			myCalendarUI.showCalendar();
		}
	}
	
	private function checkForm(user:User ):Boolean
	{
		// eingaben valide
		var valid:Boolean = false;
		// formprocessor
		var fp:Formprocessor = new Formprocessor();
		// fehler
		var errors:Array = fp.checkForm([1, "username", user.getName(), 3, "useremail", user.getEmail()]);
		// valide, wenn keine fehler
		valid = (errors.length == 0);
		// zureuck geben
		return valid;
	}
	
	public function getScore():Score {
		return score;
	}

	public function setScore(score:Score):Void {
		this.score = score;
	}

	public function getGame():Game {
		return game;
	}

	public function setGame(game:Game):Void {
		this.game = game;
	}

	public function getRank():Number {
		return rank;
	}

	public function setRank(rank:Number):Void {
		this.rank = rank;
	}

}