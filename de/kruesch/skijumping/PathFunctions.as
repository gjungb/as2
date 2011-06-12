class de.kruesch.skijumping.PathFunctions
{
	// Schanze
	private static var DIG_WIDTH = 380;
	private static var DIG_HEIGHT = 191;	
	
	private static var X1 = 45 / DIG_WIDTH;
	private static var Y1 = 19 / DIG_HEIGHT;
	private static var X2 = 240 / DIG_WIDTH;
	private static var Y2 = 158 / DIG_HEIGHT;
	
	// Grund dy/dx
	private static var GROUND_DY = 0.43195876288659793814432989690722;
	private static var GROUND_LOT = Math.cos(Math.atan(GROUND_DY));
	private static var GROUND_Y = 131; // 242; // 117;
	
	static var DIST_MAX = 1400; // 1572;
	private static var GROUND_END_DY = 10/82;
	private static var GROUND_END_Y = GROUND_Y + GROUND_DY*DIST_MAX;
	
	// Funktion für die Positionsberechnung auf der Schanze
	private static function f_dig(x:Number) : Number
	{
		// Anfang (Phase 1)
		if (x<=0) return 0;	
		
		// Hinter dem Abflug (Phase 5)
		if (x>=1) return 1-(x-1)*0.3;
		
		// von gerade auf Abfahrt (Phase 2)
		if (x<X1) return Y1 - Y1*Math.cos( (x/X1) *Math.PI/2 );
		
		// Absprung (Phase 4)
		if (x>X2) 
		{			
			var n:Number = Math.pow( (x-X2)/(1-X2) , 0.7 ); 			
			return 	Y2 + (1-n) * (Y2-Y1) * (x-X2)/(X2-X1) 
					   +   n   * ( 1-Y2) * (x-X2)/(1-X2);
		}
		
		// Abfahrt (Phase 3)
		return Y1 + (Y2-Y1) * (x-X1)/(X2-X1);
	}
	
	// Berechne y-Position auf der Schanze
	static function getDigY(x:Number) : Number
	{
		return DIG_HEIGHT * f_dig(x/DIG_WIDTH);
	}	
	
	// Berechne Boden-y-Wert
	static function getGroundY(x:Number) : Number
	{
		if (x<DIST_MAX) return GROUND_Y + GROUND_DY * x;

		var x0:Number = x-DIST_MAX;
		var y0:Number = GROUND_Y + GROUND_DY * x;	
		var y1:Number = GROUND_END_Y + GROUND_END_DY * x0;
		
		var n:Number = x0>50 ? 1 : x0/50;
		
		return y1;
	}	
	
	// Berechne Abstand zum Boden
	static function getGroundDist(x:Number,y:Number) : Number
	{
		var gy:Number = GROUND_Y + GROUND_DY * x;
		return -(y-gy)*GROUND_LOT;
	}
	
	// Verstecke c'tor
	private function PathFunctions() {}
}

