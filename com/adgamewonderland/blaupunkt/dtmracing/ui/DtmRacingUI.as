/* 
 * Generated by ASDT 
*/ 

/*
klasse:			DtmRacingUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			blaupunkt
erstellung: 		08.06.2005
zuletzt bearbeitet:	08.08.2005
durch			gj
status:			in bearbeitung
*/

import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.adgamewonderland.blaupunkt.dtmracing.challenge.*;

import com.adgamewonderland.blaupunkt.dtmracing.remoting.*;

import com.adgamewonderland.blaupunkt.dtmracing.ui.*;

class com.adgamewonderland.blaupunkt.dtmracing.ui.DtmRacingUI extends NavigationUI {
	
	public static var NEXT_LOGIN:Number = 0;
	
	public static var NEXT_REGISTER:Number = 1;
	
	public static var NEXT_MAIN:Number = 2;
	
	public static var NEXT_CHALLENGE:Number = 3;
	
	public static var NEXT_RACE:Number = 4;
	
	public static var NEXT_RESULT:Number = 5;
	
	public static var NEXT_AWARD:Number = 6;
	
	private var myNext:Number;
	
	private var metanavi_mc:MetanaviUI;
	
	private var login_mc:LoginUI;
	
	private var register_mc:RegisterUI;
	
	private var main_mc:MainUI;
	
	private var challenge_mc:ChallengeUI;
	
	private var race_mc:RaceUI;
	
	private var result_mc:ResultUI;
	
	private var award_mc:AwardUI;
	
	public function DtmRacingUI()
	{
		// vererbung
		super.constructor.apply(super, arguments);
		// frame, der als naechster angezeigt werden soll
		myNext = NEXT_MAIN;
	}
	
	public function setNext(next:Number ):Void
	{
		// frame, der als naechster angezeigt werden soll
		myNext = next;
	}
	
	public function getNext():Number
	{
		// frame, der als naechster angezeigt werden soll
		return myNext;
	}
	
	public function logoutUser():Void
	{
		// ggf. rennen resetten
		race_mc.stopRace();
		// challenge controller resetten
		ChallengeController.getInstance().onLogoutUser();
		// nach dem login zur main
		setNext(NEXT_MAIN);
		// zum login
		showLogin();
	}
	
	public function stopRace():Void
	{
		// metanavi stop buttons
		metanavi_mc.showStop(null);
		// rennen resetten
		race_mc.stopRace();
		// zur challenge
		showChallenge();
	}
	
	public function showLogin():Void
	{
		// metanavi ausblenden
		metanavi_mc.setButtonsVisible(false);
		// metanavi nicht abdecken
		metanavi_mc.showBlind(false);
		// metanavi stop buttons
		metanavi_mc.showStop(null);
		// sound stoppen
		_global.SoundCollection.stopCollection();
		// login aufrufen
		navigate("frLogin", TIME_NAVIGATE, "login_mc", "", []);
	}
	
	public function showRegister():Void
	{
		// registrierung aufrufen
		navigate("frRegister", TIME_NAVIGATE, "register_mc", "", []);
	}
	
	public function showMain():Void
	{
		// metanavi einblenden
		metanavi_mc.setButtonsVisible(true);
		// metanavi nicht abdecken
		metanavi_mc.showBlind(false);
		// metanavi stop buttons
		metanavi_mc.showStop(null);
		// main aufrufen
		navigate("frMain", TIME_NAVIGATE, "main_mc", "", []);
	}
	
	public function showChallenge():Void
	{
		// metanavi einblenden
		metanavi_mc.setButtonsVisible(true);
		// bei gast metanavi abdecken
		if (ChallengeController.getInstance().getStatus() == Challenge.STATUS_GUEST) metanavi_mc.showBlind(true);
		// challenge aufrufen
		navigate("frChallenge", TIME_NAVIGATE, "challenge_mc", "", []);
	}
	
	public function showRace():Void
	{
		// metanavi einblenden
		metanavi_mc.setButtonsVisible(true);
		// metanavi abdecken
		metanavi_mc.showBlind(true);
		// metanavi stop buttons
		metanavi_mc.showStop(ChallengeController.getInstance().getStatus());
		// sound stoppen
		_global.SoundCollection.stopCollection();
		// race aufrufen
		navigate("frRace", TIME_NAVIGATE, "race_mc", "loadRace", []);
	}
	
	public function showResult():Void
	{
		// metanavi einblenden
		metanavi_mc.setButtonsVisible(true);
		// metanavi nicht abdecken
		metanavi_mc.showBlind(false);
		// metanavi stop buttons
		metanavi_mc.showStop(null);
		// sound starten
		_global.SoundCollection.startCollection();
		// result aufrufen
		navigate("frResult", TIME_NAVIGATE, "result_mc", "", []);
	}
	
	public function showAward():Void
	{
		// metanavi einblenden
		metanavi_mc.setButtonsVisible(true);
		// metanavi nicht abdecken
		metanavi_mc.showBlind(false);
		// metanavi stop buttons
		metanavi_mc.showStop(null);
		// sound starten
		_global.SoundCollection.startCollection();
		// award aufrufen
		navigate("frAward", TIME_NAVIGATE, "award_mc", "", []);
	}
	
	public function getMetanavi():MetanaviUI
	{
		// zurueck geben
		return metanavi_mc;	
	}
	
}