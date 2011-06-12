/* Player
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Player
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		12.02.2004
zuletzt bearbeitet:	25.03.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.pinball.Player{

	// Attributes

	public var myName:String;

	public var myScore:Number;

	public var myBalls:Number;

	// Operations

	public  function Player(name:String , score:Number , balls:Number )
	{
		// name
		myName = name;
		// punktzahl
		myScore = score;
		// baelle
		myBalls = balls;

	}

	public function get name():String {
		return (myName);
	}

	public function get score():Number {
		return (myScore);
	}

	public function get balls():Number {
		return (myBalls);
	}
	
	public function addScore(score:Number )
	{
		// addieren
		myScore += score;
	}
	
	public function addBalls(balls:Number )
	{
		// addieren / subtrahieren
		myBalls += balls;
	}

} /* end class Player */
