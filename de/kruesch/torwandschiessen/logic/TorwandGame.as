import de.kruesch.torwandschiessen.ui.*;
import de.kruesch.event.*;
import de.kruesch.torwandschiessen.geom.*;
import de.kruesch.torwandschiessen.logic.*;
import mx.utils.Delegate;

// Steuert dern Spielablauf
class de.kruesch.torwandschiessen.logic.TorwandGame implements IFrameListener
{
	private var _event:EventBroadcaster;
	
	private var _pointer:DirectionPointer; 	// Pfeil
	private var _torwand:Torwand; 			// Torwand
	private var _ball:Ball; 				// Ball
	private var _ballGiver:BallGiver; 		// Ball Geber
	private var _ballReserve:BallReserve; 	// Ball Reserve
	
	private var _targetpos:Point;
	private var _timer:Timer;
	private var _hasHitGoal:Boolean;
	
	// Anzahl Tore
	private var _goalCount:Number;
	private var _leftCount:Number; // Anzahl Tore links
	private var _rightCount:Number; // Anzahl Tore rechts
	
	// 'Settings'
	private static var MAX_BALLS_PER_HOLE:Number = 3;
	private static var GOALS_PER_ROUND:Number = 6;
	
	private var _alive:Boolean;
	private var _roundTimer:Timer;
	private var _startTime:Number;	
	private var _totalTime:Number;
			
	// c'tor
	function TorwandGame(b:Ball,t:Torwand,p:DirectionPointer,g:BallGiver,r:BallReserve)
	{
		_pointer = p;
		_torwand = t;
		_ball = b;
		_ballReserve = r;
				
		_ballGiver = g;
		_ballGiver.addListener(this);	
		
		_event = new EventBroadcaster();
		
		reset();
	}
			
	// Stubs
	function onEnterFrame() : Void {}
	function onMouseDown() : Void {}
		
	// zurücksetzen
	function reset() : Void
	{
		_torwand.setHoles(Torwand.HOLES_UNTEN_OBEN);
		_ballReserve.reset();
		
		_ball._visible = false;
		_pointer._visible = false;
		_hasHitGoal = false;
		
		_leftCount = 0;
		_rightCount = 0;		
		_goalCount = 0;
		_torwand.clear();
		
		_alive = false;
	}

	// Ändere Positionen der Torwandlöcher
	function changeTorwand() : Void
	{
		var m:Number = _torwand.getHoles();
		var changed = false;
		while (!changed)
		{
			var n:Number = Math.floor(Math.random()*3 + 1);
			m = _torwand.getHoles();
			changed = m!=n;
			if (changed) _torwand.setHoles(n);
		}
	}

	// neue Runde
	function startRound(seconds:Number,changeHoles:Boolean) : Void
	{
		_alive = true;
		_roundTimer = new Timer(seconds*1000,Delegate.create(this,this.onTimeOut));

		_leftCount = 0;
		_rightCount = 0;
		_goalCount = 0;
		
		_totalTime = seconds;
		_startTime = getTimer();
	
		_ballReserve.setBalls(GOALS_PER_ROUND-1);

		_leftCount = 0;
		_rightCount = 0;		
		_goalCount = 0;
		trace("clear");
		_torwand.clear();

		giveBall();
	}
	
	function onTimeOut() : Void
	{		
		_alive = false;
		_timer.abort();
		
		OEFTimer.removeListener(this);
		Mouse.removeListener(this);
		
		_event.send("onTimeout");
	}
	
	// ziele aufs Tor 	
	function startKicking() : Void
	{		
		if (_leftCount>=MAX_BALLS_PER_HOLE) _torwand.setHoleOpen(Torwand.LEFTHOLE,false);
		if (_rightCount>=MAX_BALLS_PER_HOLE) _torwand.setHoleOpen(Torwand.RIGHTHOLE,false);
				
		onEnterFrame = onEnterFrame_readyToKick;
		onMouseDown = onMouseDown_readyToKick;
		
		OEFTimer.addListener(this);
		Mouse.addListener(this);
	}
	
	function onGoal() : Void
	{				
		if (!_alive) return;	
		
		giveBall();
	}
	
	function onRoundFinished() : Void 
	{
		var t:Number = Math.round((getTimer()-_startTime)/1000);
		_event.send("onFinishRound",t);
	}
	
	function onMiss() : Void
	{	
		if (!_alive) return;
		
		giveBall();
	}

	// Gib Ball
	function giveBall() : Void
	{
		if (!_alive) return;
		
		_ballGiver.giveBall();		
					
		_ball._x = 490 + (Math.random()*2*50 - 50); // 460 +/- 50
		_pointer._x = _ball._x;
		
		_ball._xscale = _ball._yscale = 100;
		_ball._alpha = 100;
		_ball._y = 495;	
		_ball._visible = false;		
	}
	
	// -> Callback: Ball gegeben
	function onBallGiven() : Void
	{
		if (!_alive) return;		
		
		_ball._visible = true;
		_ball.playReady();
		
		startKicking();
	}
	
	// -------------------------------------------------------------------------------
	
	// Ball Treffer oder nicht-Treffer Callbacks
	
	function onKicked() : Void {}
	
	function onKicked_Out() : Void
	{
		if (!_alive) return;
		
		_event.send("onOut");
		_ballGiver.wait();
				
		_timer = new Timer(2000,Delegate.create(this,this.onMiss));
	}
	
	function onKicked_Torwand() : Void
	{
		if (!_alive) return;
		
		_event.send("onMiss");
		
		_ball._y = _torwand.getBottom();		
		
		_timer = new Timer(1000,Delegate.create(this,this.onMiss));
	}
	
	function onKicked_Closed() : Void
	{
		if (!_alive) return;
		
		_event.send("onLatte");
		
		_ball._y = _torwand.getBottom();
		
		_timer = new Timer(1000,Delegate.create(this,this.onMiss));
	}
	
	function onKicked_Goal() : Void
	{
		if (!_alive) return;
		
		_event.send("onGoal",_goalCount);
		
		_hasHitGoal = true;
				
		_ball.playGoal();	
		_ballReserve.dec(); // entferne Ball			
		
		if (_goalCount==GOALS_PER_ROUND) 
		{
			this.onRoundFinished();
		} 
		else 
		{		
			_ballGiver.wait();
			_timer = new Timer(3000,Delegate.create(this,this.onGoal));		
		}
	}
	
	// -------------------------------------------------------------------------------
	
	// Zielen
	function onEnterFrame_readyToKick() : Void
	{		
		var xm:Number = _ball._xmouse;
		var ym:Number = _ball._ymouse;
		
		var x:Number = _ball._x - xm*10;
		var y:Number = _ball._y - ym*3-70;
		
		if (!isMouseInHitArea())
		{
			_pointer.pointTo(0,200);
			_pointer._visible = false;
			return;
		}
		
		var dy:Number = 5+200*(ym<-10 ? 0 : ym+10)/45;
		
		var tor_dy:Number = _ball._y - _torwand.getBottom();
		
		_targetpos = new Point(x,_ball._y-tor_dy-dy);		
		_targetpos = _torwand.snapToHole(_targetpos);		
		
		// Mouse.hide();		
		_pointer._visible = true;
		_pointer.pointTo(xm*10,tor_dy+dy);

		if (_global.CHEAT) 
		{
			_root.tracemc.clear();
			_root.tracemc.lineStyle(0,0,100);
			_root.tracemc.moveTo(_ball._x,_ball._y);
			_root.tracemc.lineTo(_targetpos.x,_targetpos.y);
		}		
	}	
	
	// Abschuss
	function onMouseDown_readyToKick() : Void
	{
		if (!isMouseInHitArea()) return;
		
		// do Kick off
		var dFar:Number = 4;
		var dNear:Number = 3;
		var distance:Number = _torwand.hitTest(_targetpos) ? 3 : 4;
		
		var kick:BallKick = new BallKick(_ball,new Point(_ball._x,_ball._y));
		kick.kickOff( _ball._x-_targetpos.x, _ball._y - _targetpos.y,distance,dNear,dFar);	
				
		// verstecke Pfeil
		_pointer._visible = false;			
		_hasHitGoal = false;		
		
		// Berechne Trefferposition voraus und 
		// setze Callback entsprechend
		if (!_torwand.hitTest(_targetpos)) 
		{
			onKicked = onKicked_Out;
		} else {
			onKicked = onKicked_Torwand;
		}
		if (_torwand.willHitClosed(_targetpos)) onKicked = onKicked_Closed;
		
		if (_torwand.willHitLeftGoal(_targetpos)) 
		{
			_leftCount ++;
			_goalCount++;
			onKicked = onKicked_Goal;
		}
		if (_torwand.willHitRightGoal(_targetpos)) 
		{
			_rightCount ++;
			_goalCount++;
			onKicked = onKicked_Goal;
		}
		
		OEFTimer.removeListener(this);
		Mouse.removeListener(this);
		kick.addListener(this);				
	}
	
	// Mouse in Ballnähe?
	function isMouseInHitArea() : Boolean
	{
		var xm:Number = _ball._xmouse;
		var ym:Number = _ball._ymouse;
	
		if ((ym>35)||(ym<-25)||(Math.abs(xm)>35)) return false;
		
		return true;	
	}	
	
	function addListener(o) { _event.addListener(o); }
	function removeListener(o) { _event.removeListener(o); }
};
