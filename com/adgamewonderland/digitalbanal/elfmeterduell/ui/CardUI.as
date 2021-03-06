﻿/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.connectors.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.CardaniUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.InstructionsUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.PricesUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.HighscoreUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.LoginUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.RegisterUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.RegisteredUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.UserdataUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.ChallengeUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.ChallengedUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.ScoreUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.Score2UI;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.CardUI extends MovieClip implements IUserListener {
	
	private static var TIME_NAVIGATE:Number = 50;
	
	public static var NEXT_INSTRUCTIONS:String = "frInstructions";
	
	public static var NEXT_PRICES:String = "frPrices";
	
	public static var NEXT_HIGHSCORE:String = "frHighscore";
	
	public static var NEXT_LOGIN:String = "frLogin";
	
	public static var NEXT_REGISTERED:String = "frRegistered";
	
	public static var NEXT_USERDATA:String = "frUserdata";
	
	public static var NEXT_CHALLENGE:String = "frChallenge";
	
	public static var NEXT_CHALLENGED:String = "frChallenged";
	
	public static var NEXT_SCORE:String = "frScore";
	
	public static var NEXT_SCOREWON:String = "frScorewon";
	
	public static var NEXT_SCORELOST:String = "frScorelost";
	
	public static var NEXT_SCOREDRAW:String = "frScoredraw";
	
	private var cardani_mc:CardaniUI;
	
	private var instructions_mc:InstructionsUI;
	
	private var prices_mc:PricesUI;
	
	private var highscore_mc:HighscoreUI;
	
	private var login_mc:LoginUI;
	
	private var register_mc:RegisterUI;
	
	private var registered_mc:RegisteredUI;
	
	private var userdata_mc:UserdataUI;
	
	private var challenge_mc:ChallengeUI;
	
	private var challenged_mc:ChallengedUI;
	
	private var score_mc:ScoreUI;
	
	private var scorewon_mc:Score2UI;
	
	private var scorelost_mc:Score2UI;
	
	private var nextframe:String;
	
	public function CardUI() {
		// cardani
		cardani_mc = CardaniUI.getCardaniUI();
		
		// als listener registrieren
		GameController.getInstance().addListener(this);
	}
	
	public static function getCardUI():CardUI
	{
		return (CardaniUI.getCardaniUI().card_mc);
	}
	
	public function showInstructions():Void
	{
		// instructions aufrufen
		navigate(NEXT_INSTRUCTIONS, TIME_NAVIGATE, "instructions_mc", "", []);
	}
	
	public function showPrices():Void
	{
		// prices aufrufen
		navigate(NEXT_PRICES, TIME_NAVIGATE, "prices_mc", "", []);
	}
	
	public function showHighscore():Void
	{
		// highscore aufrufen
		navigate(NEXT_HIGHSCORE, TIME_NAVIGATE, "highscore_mc", "", []);
	}
	
	public function showLogin():Void
	{
		// login aufrufen
		navigate(NEXT_LOGIN, TIME_NAVIGATE, "login_mc", "init", []);
	}
	
	public function showRegistered():Void
	{
		// registered aufrufen
		navigate(NEXT_REGISTERED, TIME_NAVIGATE, "registered_mc", "init", []);
	}
	
	public function showUserdata():Void
	{
		// userdata aufrufen
		navigate(NEXT_USERDATA, TIME_NAVIGATE, "userdata_mc", "init", []);
	}
	
	public function showChallenge():Void
	{
		// challenge aufrufen
		navigate(NEXT_CHALLENGE, TIME_NAVIGATE, "challenge_mc", "init", []);
	}
	
	public function showChallenged():Void
	{
		// challenged aufrufen
		navigate(NEXT_CHALLENGED, TIME_NAVIGATE, "challenged_mc", "init", []);
	}
	
	public function showScore():Void
	{
		// score aufrufen
		navigate(NEXT_SCORE, TIME_NAVIGATE, "score_mc", "init", []);
	}
	
	public function showScorewon():Void
	{
		// scorewon aufrufen
		navigate(NEXT_SCOREWON, TIME_NAVIGATE, "scorewon_mc", "init", []);
	}
	
	public function showScorelost():Void
	{
		// scorelost aufrufen
		navigate(NEXT_SCORELOST, TIME_NAVIGATE, "scorelost_mc", "init", []);
	}
	
	public function showScoredraw():Void
	{
		// scoredraw aufrufen
		navigate(NEXT_SCOREDRAW, TIME_NAVIGATE, "scoredraw_mc", "init", []);
	}
	
	public function onUserLogin(user:User ):Void
	{
	}
	
	public function onUserLogout(user:User ):Void
	{
		// login anzeigen
		showLogin();
	}
	
	public function onUserUpdate(user:User ):Void
	{
	}
	
	private function navigate(frame:String, pause:Number, target:String, method:String, args:Array ):Void
	{
		// cardani einblenden
		cardani_mc.showCardani(true);
		// hinspringen
		gotoAndStop(frame);
		// funktion zur uebergabe der parameter an ziel
		var invokeMethod = function(target:Object ) {
			// uebergeben
			target[method](args[0], args[1]);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause aufrufen
		var interval:Number = setInterval(invokeMethod, pause, this[target]);
	}
	
	public function getNextframe():String {
		return nextframe;
	}

	public function setNextframe(nextframe:String):Void {
		this.nextframe = nextframe;
	}

}