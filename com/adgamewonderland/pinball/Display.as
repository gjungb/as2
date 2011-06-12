/* Display
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Display
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		13.02.2004
zuletzt bearbeitet:	13.02.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Display extends MovieClip{

	// Attributes

	public var myNames:Array;

	public var name11_txt:TextField;

	public var name12_txt:TextField;

	public var name21_txt:TextField;

	public var name22_txt:TextField;

	public var myScores:Array;

	public var score11_txt:TextField;

	public var score12_txt:TextField;

	public var score21_txt:TextField;

	public var score22_txt:TextField;

	public var myBalls:Array;

	public var balls11_txt:TextField;

	public var balls12_txt:TextField;

	public var balls21_txt:TextField;

	public var balls22_txt:TextField;
	
	public var outline_mc:MovieClip;

	// Operations

	public  function Display()
	{
		// namen
		myNames = [name11_txt, name12_txt, name21_txt, name22_txt];
		// punkte
		myScores = [score11_txt, score12_txt, score21_txt, score22_txt];
		// kugeln
		myBalls = [balls11_txt, balls12_txt, balls21_txt, balls22_txt];

		// registrieren
		Pinball.registerDisplay(this);

	}

	public  function updatePlayer(num:Number , player:Player )
	{
		// name
		myNames[num * 2].text = player.name;
		myNames[num * 2 + 1].text = player.name;
		// punkte
		myScores[num * 2].text = player.score;
		myScores[num * 2 + 1].text = player.score;
		// kugeln
		myBalls[num * 2].text = player.balls;
		myBalls[num * 2 + 1].text = player.balls;
		// outline
		outline_mc._y = myNames[num * 2]._y;

	}

} /* end class Display */
