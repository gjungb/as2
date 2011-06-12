import de.kruesch.torwandschiessen.geom.*; 
import de.kruesch.event.*;

// Kontroller Klasse für Schuss und Ballflugberechnung
class de.kruesch.torwandschiessen.logic.BallKick implements IFrameListener
{
	private static var SPEED:Number = 60;
	private static var ZDISTANCE : Number = 300; // z-Distanz
	private static var SCALING : Number = 8; // Z-Skalierung

	private var _vec : Vector3D; // Richtung
	private var _dEnd : Number; // End Distanz
	private var _dNear: Number; // Nahbereich
	private var _dFar : Number; // Distanz Unendlichkeit
	private var _start : Point; // Ball Startpunkt
	private var _time : Number; // Z�hler
	
	private var _event:EventBroadcaster;

	private var _ballMC : MovieClip; // Target

	// c'tor
	function BallKick(ball:MovieClip,start:Point)
	{	
		_ballMC = ball;
		_start = start;
		
		_event = new EventBroadcaster();
	}
	
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }

	function onEnterFrame() : Void
	{
		var done:Boolean = false;
		
		_time++;

		var dz:Number = _vec.z*SPEED/100;
		var z:Number = _time * dz;
		if (z>_dEnd) 
		{
			OEFTimer.removeListener(this);			
			 _time = _dEnd / dz;
			 z = _dEnd;
			 done = true;
		}	

		if (z>_dNear)
		{
			trace([z,_dNear,_dFar]);
			_ballMC._alpha = 100*(_dFar-z)/(_dFar-_dNear);
		}
		
		_ballMC._x = _start.x - _time * SPEED * _vec.x;
		_ballMC._y = _start.y - _time * SPEED * _vec.y;				

		var s = 100*SCALING / (z+SCALING);
		if (s<0) s = 0;

		_ballMC._xscale = _ballMC._yscale = s;
		
		if (done) _event.send("onKicked");
	}

	function kickOff(dx:Number,dy:Number,distance:Number,dNear:Number,dFar:Number) : Void
	{		
		_time = 0;

		_vec = new Vector3D(dx,dy,ZDISTANCE);
		_vec.normalize();

		_dEnd = distance;
		_dFar = dFar;
		_dNear = dNear;
		
		OEFTimer.addListener(this);
	}
};


