/* Cardfanpa
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Cardfanpa
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		10.06.2004
zuletzt bearbeitet:	10.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*;

class com.adgamewonderland.eplus.soccer.microsite.Cardfanpa extends Card {

	// Attributes
	
	private var rabatt_mc:MovieClip;
	
	// Operations
	
	public  function Cardfanpa()
	{
		// aktivitaet ueberwachen
		this.watch("active", onChangeActivity);
	}
	
	public function onChangeActivity(prop, oldval, newval):Boolean
	{
		// je nach neuer activity
		switch (newval) {
			// einschalten
			case true :
				// rabatt stoerer animieren
				rabatt_mc.play();
				break;
			// ausschalten
			case false :
				// rabatt stoerer stoppen
				rabatt_mc.gotoAndStop("frStop");
				
				break;
		
		}
		// neuen wert uebernehmen
		return (newval);
	}

} /* end class Cardfanpa */
