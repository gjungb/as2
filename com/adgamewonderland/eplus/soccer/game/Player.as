/* Player
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Player
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		21.04.2004
zuletzt bearbeitet:	24.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.game.*;

class com.adgamewonderland.eplus.soccer.game.Player {

	// Attributes
	
	private var myPlayerid:Number;
	
	private var myFirstname:String;
	
	private var myLastname:String;
	
	private var myClub:String;
	
	private var myNumber:String;
	
	private var myPosition:String;
	
	private var isActive:Boolean;
	
	private var myMatches:String;
	
	private var myGoals:String;
	
	private var myGelb:String;
	
	private var myRot:String;
	
	private var myAge:String;
	
	private var myFigure:Figure;
	
	// Operations
	
	public  function Player(obj:Object )
	{
		// schleife ueber alle attribute
		for (var i in obj) {
			// speichern
			this[i] = obj[i];
		}
		// figur, die den spieler im tipp darstellt
		figure = null;
	}
	
	public function set playerid(str:String ):Void
	{
		myPlayerid = Number(str);
	}
	
	public function get playerid():Number
	{
		return (myPlayerid);
	}
	
	public function set firstname(str:String ):Void
	{
		myFirstname = str;
	}
	
	public function get firstname():String
	{
		return (myFirstname);
	}
	
	public function set lastname(str:String ):Void
	{
		myLastname = str;
	}
	
	public function get lastname():String
	{
		return (myLastname);
	}
	
	public function set club(str:String ):Void
	{
		myClub = str;
	}
	
	public function get club():String
	{
		return (myClub);
	}
	
	public function set number(str:String ):Void
	{
		myNumber = str;
	}
	
	public function get number():String 
	{
		return (myNumber);
	}
	
	public function set position(str:String ):Void
	{
		myPosition = str;
	}
	
	public function get position():String
	{
		return (myPosition);
	}
	
	public function set active(bool:Boolean ):Void
	{
		isActive = bool;
	}
	
	public function get active():Boolean
	{
		return (isActive);
	}
	
	public function set matches(str:String ):Void
	{
		myMatches = str;
	}
	
	public function get matches():String 
	{
		return (myMatches);
	}
	
	public function set goals(str:String ):Void
	{
		myGoals = str;
	}
	
	public function get goals():String 
	{
		return (myGoals);
	}
	
	public function set gelb(str:String ):Void
	{
		myGelb = str;
	}
	
	public function get gelb():String 
	{
		return (myGelb);
	}
	
	public function set rot(str:String ):Void
	{
		myRot = str;
	}
	
	public function get rot():String 
	{
		return (myRot);
	}
	
	public function set age(str:String ):Void
	{
		myAge = str;
	}
	
	public function get age():String 
	{
		return (myAge);
	}
	
	public function set figure(obj:Figure ):Void
	{
		myFigure = obj;
	}
	
	public function get figure():Figure 
	{
		return (myFigure);
	}

} /* end class Player */
