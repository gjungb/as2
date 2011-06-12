/* Shooter
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Shooter
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		25.03.2004
zuletzt bearbeitet:	25.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Shooter extends MovieClip {

	// Attributes
	
	public var ball_mc:MovieClip;
	
	public var keyListener:Object;
	
	// Operations
	
	public  function Shooter()
	{
		// key listener
		keyListener = new Object();
		// referenz auf shooter
		keyListener.parent = this;
		// callback
		keyListener.onKeyDown = function () {
			// auf SPACE reagieren
			if (Key.getCode() == Key.SPACE) {
				this.parent.startShooter();
			}
		}
		// registrieren
		Pinball.registerShooter(this);
	}
	
	public  function setActive (bool:Boolean )
	{
		// aktivitaet umschalten
		switch (bool) {
			// einschalten
			case true:
				// auf tastendruck reagieren
				Key.addListener(keyListener);
				// ball anzeigen
				nextFrame();
			
				break;
			
			// ausschalten
			case false:
				// nicht auf tastendruck reagieren
				Key.removeListener(keyListener);
			
				break;
		}
	}
	
	public function startShooter ()
	{
		// deaktivieren
		setActive(false);
		// animation abspielen
		play();
		// am ende ball registrieren
		onEnterFrame = function () {
			// fortschritt ueberwachen
			switch (_totalframes - _currentframe) {
				// vorletzter frame
				case 1:
					// ball initialiseren
					Pinball.initBall(ball_mc._x, ball_mc._y);
				
					break;
					
				// letzter frame
				case 0:
					// level starten
					Pinball.startLevel(1);
					// ueberwachung beenden
					delete(onEnterFrame);
				
					break;
			}
		}
	}

} /* end class Shooter */
