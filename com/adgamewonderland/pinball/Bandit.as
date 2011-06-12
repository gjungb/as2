/* Bandit
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Bandit
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.02.2004
zuletzt bearbeitet:	29.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.Pinball

class com.adgamewonderland.pinball.Bandit extends MovieClip{

	// Attributes
	
	public var myRollers:Array;
	
	public var roller1_mc:MovieClip;
	
	public var roller2_mc:MovieClip;
	
	public var roller3_mc:MovieClip;
	
	public var myIntervals:Array;
	
	public var myResults:Array;
	
	// Operations
	
	public  function Bandit()
	{
		// roller mcs auf buehne
		myRollers = [roller1_mc, roller2_mc, roller3_mc];
		// interval ids
		myIntervals = [];
		// starten
		startBandit();
	}
	
	public  function startBandit()
	{
		// sound abspielen
		_root.sound_mc.setSound("sbandit", 1);
		// ergebnisse der einzelnen roller
		myResults = [];
		// alle roller auf zufaellige ausgangsposition
		for (var i in myRollers) {
			// aktueller roller
			var roller:MovieClip = myRollers[i];
			// laufen lassen
			startRoller(roller);
			// zeit bis stop
			var time:Number = Math.round(2000 + Math.random() * 5000);
			// nach unterschiedlichen zeiten anhalten
			myIntervals[Number(i)] = setInterval(this, "stopRoller", time, Number(i));
		}
	}
	
	public  function stopBandit()
	{
		// abbrechen, wenn nicht alle symbole gleich
		if (!(myResults[0] == myResults[1] && myResults[1] == myResults[2])) return;
		
		// je nach symbol weiter machen
		switch (myResults[0]) {
			// biene maja
			case 1 :
				// saver deaktivieren
				_parent.savers_mc.setActive(false);
			
				break;
			// flip
			case 2 :
				// 1000 punkte
				Pinball.countScore(1000);
			
				break;
			// ameise
			case 3 :
				// saver aktivieren
				_parent.savers_mc.setActive(true);
			
				break;
		}
	}
	
	private  function startRoller(roller:MovieClip )
	{
		// zufaellig loslaufen
		roller.gotoAndPlay(Math.ceil(Math.random()*roller._totalframes));
	}
	
	public  function stopRoller(num:Number )
	{
		// interval loeschen
		clearInterval(myIntervals[num]);
		// aktueller roller
		var roller:MovieClip = myRollers[num];
		// anhalten
		roller.stop();
		
		// abstand zwischen den einzelnen symbolen (in frames)
		var framediff:Number = roller._totalframes / myRollers.length;
		// testen, ob symbol ganz zu sehen
		if (roller._currentframe % framediff != 0) {
			roller.nextFrame();
		}
		// nummer des angezeigten symbols
		var symbol:Number = Math.ceil(roller._currentframe/ framediff);
		// in ergebnismenge schreiben
		myResults.push(symbol);
		// wenn alle fertig, auswerten
		if (myResults.length == myRollers.length) stopBandit();
	}

} /* end class Bandit */
