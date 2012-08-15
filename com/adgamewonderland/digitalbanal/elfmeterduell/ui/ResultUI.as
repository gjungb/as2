/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.ResultaniUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.InterstitialUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.NoticeUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.CardUI;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.ResultUI extends MovieClip implements IUserListener {
	
	private var mode:Number;
	
	private var keeper1_mc:MovieClip;
	
	private var keeper2_mc:MovieClip;
	
	private var keeper3_mc:MovieClip;
	
	private var keeper4_mc:MovieClip;
	
	private var keeper5_mc:MovieClip;
	
	private var keeper6_mc:MovieClip;
	
	private var defend1_mc:MovieClip;
	
	private var defend2_mc:MovieClip;
	
	private var defend3_mc:MovieClip;
	
	private var defend4_mc:MovieClip;
	
	private var defend5_mc:MovieClip;
	
	private var defend6_mc:MovieClip;
	
	private var shot1_mc:MovieClip;
	
	private var shot2_mc:MovieClip;
	
	private var shot3_mc:MovieClip;
	
	private var shot4_mc:MovieClip;
	
	private var shot5_mc:MovieClip;
	
	private var shot6_mc:MovieClip;
	
	private var miss1_mc:MovieClip;
	
	private var miss2_mc:MovieClip;
	
	private var miss3_mc:MovieClip;
	
	private var comment1_mc:MovieClip;
	
	private var comment2_mc:MovieClip;
	
	private var comment3_mc:MovieClip;
	
	private var comment4_mc:MovieClip;
	
	private var comment5_mc:MovieClip;
	
	private var comment6_mc:MovieClip;
	
	private var comment7_mc:MovieClip;
	
	private var comment8_mc:MovieClip;
	
	private var comment9_mc:MovieClip;
	
	private var comment10_mc:MovieClip;
	
	private var comment11_mc:MovieClip;
	
	private var comment12_mc:MovieClip;
	
	private var resultani_mc:ResultaniUI;
	
	private var interstitial_mc:InterstitialUI;
	
	private var jubeltor_snd:Sound;
	
	private var jubelgehalten_snd:Sound;
	
	public function ResultUI() {
		// ausblenden
		_visible = false;
		// jubeltor
		jubeltor_snd = new Sound(this);
		jubeltor_snd.attachSound("jubeltor");
		// jubelgehalten
		jubelgehalten_snd = new Sound(this);
		jubelgehalten_snd.attachSound("jubelgehalten");
		
		// als listener registrieren
		GameController.getInstance().addListener(this);
	}
	
	public static function getResultUI():ResultUI
	{
		return (_root.content_mc.result_mc);
	}
	
	public function showResult():Void
	{
		// notice einblenden
		NoticeUI.getNoticeUI().showNotice(NoticeUI.NOTICE_RESULT, true);
		// einblenden
		_visible = true;
		// schuesse ausblenden
		showAnimation("shot", null);
		// keeper ausblenden
		showAnimation("keeper", null);
		// abwehr ausblenden
		showAnimation("defend", null);
		// daneben ausblenden
		showAnimation("miss", null);
		// kommentar ausblenden
		showAnimation("comment", null);
		
		// 1. herausforderer angriff
		initShots(GameDetail.MODE_CHALLENGER);
	}
	
	private function initShots(mode:Number ):Void
	{
		// modus speichern
		setMode(mode);
		// aktuelles game
		var game:GameImpl = GameController.getInstance().getGame();
		// details herausforderer
		var challengerdetails:GameDetail = game.getDetail(GameDetail.MODE_CHALLENGER);
		// details gegner
		var opponentdetails:GameDetail = game.getDetail(GameDetail.MODE_OPPONENT);
		// nach pause animation anzeigen
		var interval:Number;
		// funktion
		var doStart:Function = function(target:ResultUI ):Void {
			// je nach modus
			switch (target.getMode()) {
				// herausforderer angriff
				case GameDetail.MODE_CHALLENGER :
					// schuesse zeigen
					target.showShots(challengerdetails.getOffense(), opponentdetails.getDefense());
					// statistikanimation zeigen
					target.resultani_mc.showResultani(true, challengerdetails.getUser().getNickname(), opponentdetails.getUser().getNickname());
				
					break;
				// gegner angriff
				case GameDetail.MODE_OPPONENT :
					// schuesse zeigen
					target.showShots(opponentdetails.getOffense(), challengerdetails.getDefense());
					// statistikanimation zeigen
					target.resultani_mc.showResultani(true, opponentdetails.getUser().getNickname(), challengerdetails.getUser().getNickname());
				
					break;
			}	
			// interval loeschen
			clearInterval(interval);
		}
		// umschalten
		interval = setInterval(doStart, 2000, this);
	}
	
	private function showShots(offense:String, defense:String ):Void
	{
		// in arrays fuer bessere handhabung
		var offarr:Array = offense.split("");
		var defarr:Array = defense.split("");
		// counter
		var counter:Number = 0;
		// nach pause animation anzeigen
		var interval:Number;
		// funktion
		var doStart:Function = function(target:ResultUI ):Void {
			// schuss
			var shot:Number = offarr[counter];
			// abwehr
			var keeper:Number = defarr[counter];
			// tor?
			var goal:Boolean = (shot != 0 && shot != keeper);
			if (shot != 0) {
				// schuss anzeigen
				target.showAnimation("shot", shot);
			} else {
				// miss anzeigen
				target.showAnimation("miss", Math.ceil(Math.random() * 3));
			}
			// keeper anzeigen
			target.showAnimation("keeper", keeper);
			// statistikanimation zeigen
			target.resultani_mc.countShot(target.getMode(), counter + 1, goal);
			
			// alle schuesse fertig
			if (++counter > offarr.length) {
				// interval loeschen
				clearInterval(interval);
				// je nach modus
				if (target.getMode() == GameDetail.MODE_CHALLENGER) {
					// 2. gegner angriff
					target.initShots(GameDetail.MODE_OPPONENT);
					// interstitial abspielen
					target.showInterstitial();
				} else {
					// beenden
					target.closeResult();
				}
			} else {
				// tor oder nicht
				switch (goal) {
					// tor
					case true :
						// sound abspielen
						target.jubeltor_snd.start(0, 1);
						
						break;
					// kein tor
					case false :
						// abwehr anzeigen
						if (shot != 0) target.showAnimation("defend", keeper);
						// sound abspielen
						target.jubelgehalten_snd.start(0, 1);
					
						break;
				}
				
				// kommentar anzeigen
				target.showComment(goal, shot == 0);
				// kommentarsound abspielen
				target.playCommentmc(goal, shot == 0);
			}
		};
		// umschalten
		interval = setInterval(doStart, 4000, this);
	}
	
	public function showAnimation(type:String, num:Number ):Void
	{
		// counter
		var counter:Number = 0;
		// alle ausblenden
		while (this[type + (++counter) + "_mc"] != undefined) {
			this[type + counter + "_mc"]._visible = false;
		}
		// einblenden
		this[type + num + "_mc"]._visible = true;
		// abspielen
		this[type + num + "_mc"].gotoAndPlay(2);
	}
	
	public function showInterstitial():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(interstitial_mc, "onInterstitialFinished", null);
		// abspielen verfolgen
		interstitial_mc.onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		interstitial_mc.gotoAndPlay("frIn");
	}
	
	public function onInterstitialFinished():Void
	{
	}
	
	public function pauseAnimation(type:String, bool:Boolean ):Void
	{
		// counter
		var counter:Number = 0;
		// alle durchschleifen
		while (this[type + (++counter) + "_mc"] != undefined) {
			// stoppen oder abspielen
			if (this[type + counter + "_mc"]._visible) {
				// stoppen
				if (bool) {
					this[type + counter + "_mc"].stop();
				// abspielen
				} else {
					this[type + counter + "_mc"].play();
				}
			}
		}
	}
	
	public function showComment(goal:Boolean, missed:Boolean ):Void
	{
		// einzublendender kommentar
		var comment_mc:MovieClip;
		// moegliche kommentare
		var comments:Array;
		// goal
		if (goal) {
			comments = new Array(comment1_mc, comment2_mc, comment3_mc, comment4_mc, comment5_mc);
		} else {
			// miss
			if (missed) {
				comments = new Array(comment11_mc, comment12_mc);
				
			} else {
				// gehalten
				comments = new Array(comment6_mc, comment7_mc, comment8_mc, comment9_mc, comment10_mc);
			}	
		}
		// per zufall
		comment_mc = comments[Math.floor(Math.random() * comments.length)];
		// durchsichtig
		comment_mc._alpha = 0;
		// einblenden
		comment_mc._visible = true;
		// einfaden
		Fader.fade(comment_mc, 0, 100, 500, 20);
		// nach pause ausfaden
		var interval:Number;
		// funktion
		var doFade:Function = function():Void {
			// ausfaden
			Fader.fade(comment_mc, 100, 0, 500, 20);
			// interval loeschen
			clearInterval(interval);
		}
		// ausfaden
		interval = setInterval(doFade, 1000);
	}
	
	public function playComment(goal:Boolean, missed:Boolean ):Void
	{
		// abzuspielender kommentar
		var comment_snd:Sound = new Sound(this);
		// name der mp3
		var mp3:String = "";
		// goal
		if (goal) {
			mp3 = "goal" + Math.ceil(Math.random() * 11) + ".mp3";
		} else {
			// miss
			if (missed) {
				mp3 = "missed" + Math.ceil(Math.random() * 1) + ".mp3";
				
			} else {
				// gehalten
				mp3 = "saved" + Math.ceil(Math.random() * 4) + ".mp3";
			}	
		}
//		// callback
//		comment_snd.onLoad = function(success:Boolean ):Void {
//			trace(success);
//			trace(this.duration);
//			this.start();
//		};
		// sound laden und abspielen
		comment_snd.loadSound("comments/" + mp3, true);
	}
	
	public function playCommentmc(goal:Boolean, missed:Boolean ):Void
	{
		// neues movie
		var comment_mc:MovieClip = createEmptyMovieClip("comment_mc", 1000);
		// name der swf
		var swf:String = "";
		// goal
		if (goal) {
			swf = "goal" + Math.ceil(Math.random() * 11) + ".swf";
		} else {
			// miss
			if (missed) {
				swf = "missed" + Math.ceil(Math.random() * 1) + ".swf";
				
			} else {
				// gehalten
				swf = "saved" + Math.ceil(Math.random() * 4) + ".swf";
			}	
		}
		// laden
		comment_mc.loadMovie("comments/" + swf);
	}
	
	public function closeResult():Void
	{
		// notice ausblenden
		NoticeUI.getNoticeUI().showNotice(NoticeUI.NOTICE_RESULT, false);
		// ausblenden
		_visible = false;
		// aktuelles game
		var game:GameImpl = GameController.getInstance().getGame();
		// einloggter user
		var user:User = GameController.getInstance().getUser();
		
		// details herausforderer
		var challengerdetails:GameDetail = game.getDetail(GameDetail.MODE_CHALLENGER);
		// details gegner
		var opponentdetails:GameDetail = game.getDetail(GameDetail.MODE_OPPONENT);
		
//		// wie viele tore hat der eingeloggte user geschossen
//		var goalsplayer1:Number;
//		// wie viele tore hat der andere user geschossen
//		var goalsplayer2:Number;
//		// ist der eingeloggte user challenger oder opponent?
//		if (challengerdetails.getUser().getUserID() == user.getUserID()) {
//			trace("user ist challenger");
//			// tore eingeloggter user
//			goalsplayer1 = challengerdetails.getGoals();
//			// tore anderer user
//			goalsplayer2 = opponentdetails.getGoals();
//		} else {
//			trace("user ist opponent");
//			// tore eingeloggter user
//			goalsplayer1 = opponentdetails.getGoals();
//			// tore anderer user
//			goalsplayer2 = challengerdetails.getGoals();
//		}
		// hat der eingeloggte user gewonnen
		var won:Boolean = game.getWinner() == user.getUserID();
		// ergebnis anzeigen
		if (won) {
			CardUI.getCardUI().showScorewon();
		} else {
			// unentschieden
			if (challengerdetails.getGoals() == opponentdetails.getGoals()) {
				CardUI.getCardUI().showScoredraw();
			} else {
				// verloren
				CardUI.getCardUI().showScorelost();
			}
		}
	}
	
	public function resetResultUI():Void
	{
		// interval loeschen
//		clearInterval(interval);
		// ausblenden
		_visible = false;
	}
	
	public function onUserLogin(user:User ):Void
	{
	}
	
	public function onUserLogout(user:User ):Void
	{
		// resetten
		resetResultUI();
	}
	
	public function onUserUpdate(user:User ):Void
	{
	}
	
	public function getMode():Number {
		return mode;
	}

	public function setMode(mode:Number):Void {
		this.mode = mode;
	}

}