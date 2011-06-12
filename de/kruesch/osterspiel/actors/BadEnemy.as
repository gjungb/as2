import de.kruesch.math.*;
import de.kruesch.osterspiel.actors.*;

class de.kruesch.osterspiel.actors.BadEnemy extends Enemy
{
	function BadEnemy()
	{
		knockedOut = false;

		dir = new Vector(0,0);
		step = new Vector(0,0);

		r = 35;			// Grösse / Radius
		speed = 2.2;	// Geschwindigkeit
		rebirth = 2;	// Anzahl Wiedergeburten (Aufstehen)
		typ = 2;		// Gegner Typ
	}
}

