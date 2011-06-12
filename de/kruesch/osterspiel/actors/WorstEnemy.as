import de.kruesch.math.*;
import de.kruesch.osterspiel.actors.*;

class de.kruesch.osterspiel.actors.WorstEnemy extends Enemy
{
	function BadEnemy()
	{
		knockedOut = false;

		dir = new Vector(0,0);
		step = new Vector(0,0);

		r = 30;		 // Grösse / Radius
		speed = 3.0; // Geschwindigkeit
		rebirth = 2; // Anzahl Wiedergeburten (Aufstehen)
		typ = 3;	 // Gegner Typ
	}
}

