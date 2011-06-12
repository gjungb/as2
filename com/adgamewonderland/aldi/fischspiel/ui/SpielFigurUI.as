/**
 * Allgemeine Spielfigur
 *
 * @author Harry
 */
class com.adgamewonderland.aldi.fischspiel.ui.SpielFigurUI extends MovieClip {
	private var bFirst:Boolean 		= true;
	private var oldMouseX:Number 	= 0;
	private var oldMouseY:Number 	= 0;

	private var timerIdBewegung:Number = -1;
	private var bewegungStepX:Number = 0;
	private var bewegungStepY:Number = 0;
	private var bewegungSteps:Number = 0;

	function SpielFigurUI() {
		super();
	}

	public function onUnload() : Void {
		if (timerIdBewegung != -1)
			clearInterval(timerIdBewegung);
	}

	/**
	 * Klebt das Objekt an die Koordinaten.
	 * Richtung wird durch Drehung simmuliert
	 * und die vorhergehende Position wird
	 * nachgehalten.
	 *
	 */
	public function FollowMouse (x:Number,y:Number) : Void {
		var xoffset	:Number = 0;
		var richtung:Number = 0;	// 0 ist nach rechts
									// 1 ist nach links

		if (bFirst) {
			bFirst		= false;
			oldMouseX 	= x;
			oldMouseY 	= y;
			richtung 	= 1;
		}
		else {
			if (oldMouseX <= x)
				richtung = 0;
			else
				richtung = 1;
			oldMouseX = x;
			oldMouseY = y;
		}

		if (richtung == 1) {
			xoffset 	= _width * 0.75;
			_rotation 	= 180;
		}
		if (richtung == 0) {
			xoffset		= _width * -1 * 0.75;
			_rotation 	= 0;
		}

		_x = x + xoffset;
		_y = y;
	}

	/**
	 * Bewegt das Objekt von Punkt 1 nach Punkt 2
	 * innerhalb einer gewissen Zeit.
	 * Die Bewegung wird mit einem Timer bewerkstelligt.
	 */
	public function initAutomaticMove (x1:Number,y1:Number,x2:Number,y2:Number,time:Number) : Void {
		/*
		timerIdBewegung = setInterval(
			objectReference:Object,
			methodName:String,
			interval:Number,
			[param1:Object, param2, ..., paramN]
		) : Number
		 *
		 */
		_x = x1;
		_y = y1;

		var deltaX:Number = x2 - x1;
		var deltaY:Number = y2 - y1;

		var strecke:Number = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		bewegungStepX = deltaX / strecke;
		bewegungStepY = deltaY / strecke;

		var interval:Number = time / strecke;
		bewegungSteps = strecke;

		timerIdBewegung = setInterval(
			this,
			"doAutomaticMove",
			interval
		);
	}

	private function doAutomaticMove () : Void {
		_x = _x + bewegungStepX;
		_y = _y + bewegungStepY;

		bewegungSteps--;

		if (bewegungSteps < 0) {
			clearInterval(timerIdBewegung);
			timerIdBewegung = -1;
		}
	}
}