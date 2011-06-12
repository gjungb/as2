import de.kruesch.event.*;
import de.kruesch.skijumping.*;
import de.kruesch.skijumping.ui.GameWorld;	

class de.kruesch.skijumping.GameController implements IFrameListener
{	
	private var _mover : MoveEngine;	
	private var _state : JumpState;	
	private var _strength : Number;
	private var _event : EventBroadcaster;
	
	private var MAX_STRENGTH = 27;
	
	private static var EV_STRENGTH = "onStrengthChanged";
	private static var EV_LANDED = "onJumpLanded";
	private static var EV_FINISHED = "onJumpFinished";
	
	// c'tor
	function GameController(m:MoveEngine)
	{
		_mover = m;
		_mover.addListener(this);
		
		_event = new EventBroadcaster();
	}	
	
	function addListener(o:Object) : Void  
	{
		_event.addListener(o);
	}
	
	function removeListener(o:Object) : Void 
	{
		_event.removeListener(o);
	}
	
	// Stubs, die Funktionen werden dynamisch zugewiesen
	function onMouseDown()  : Void {}
	function onMouseUp()  : Void {}
	function onEnterFrame() : Void {}		
	
	function onSkiLanded(meters:Number) : Void 
	{
		_event.send(EV_LANDED, meters);
	}
	
	function onSkiFinish() : Void 
	{
		// gameover aufrufen
		_event.send(EV_FINISHED);
	}
	
	function onSkiJump() : Void
	{	
		if (this._state==JumpState.PREPARE) strength = 0;		
		
		setState(JumpState.JUMP);		
		_mover.setJumpStrength( strength/MAX_STRENGTH );
	}
	
	function onMouseDown_start() : Void 
	{
		_mover.start(); 
		setState(JumpState.ACCELERATE);
	}
	
	function onMouseDown_prepare() : Void
	{			
		if (!_mover.canAccelerate) return;
		setState(JumpState.PREPARE);
	}	
	
	function onEnterFrame_accel() : Void
	{		
		// TEST
//		if (_mover.canAccelerate) 
//		{
//			setState(JumpState.PREPARE);
//			return;
//		}
		
		strength-=2;
		if (strength<0) strength = 0;			
	}
				
	function onEnterFrame_prepare() : Void
	{
		strength++;
		/*
		if (!_mover.isOverDue) 
		{
			strength++;
		} 
		else 
		{
			strength-=25;
		}
		*/
	}
	
	function onMouseUp_prepare() : Void
	{		
		if (_mover.canJumpOff())
		{
			setState(JumpState.JUMP);
		} 
		else 
		{
			setState(JumpState.ACCELERATE);
		}
	}

	function set strength(n:Number) : Void
	{
		if (n<0) n = 0;
		var temp:Number = _strength;
		_strength = n;
		
		var s:Number = _strength/MAX_STRENGTH;
		if (s>1) s = 1;

		// Update-Event
		if (temp!=n) _event.send( EV_STRENGTH, s );
	}
	
	function get strength() : Number
	{
		return _strength;
	}
	
	private function setState(s:JumpState) : Void
	{
//		trace("setState: "+s);
		_state = s;
		switch(s) 
		{
			// Warten
			case JumpState.IDLE: 		Mouse.addListener(this);
										onMouseUp = null;
										onMouseDown = onMouseDown_start;
										strength = 0;
										_mover.reset();
										break;
					
			// Losfahren							
			case JumpState.ACCELERATE:	onMouseDown = onMouseDown_prepare;
										onMouseUp = null;
										OEFTimer.addListener(this);
										onEnterFrame = onEnterFrame_accel;
										break;
										
			
			// Sprungkraft einstellen				
			case JumpState.PREPARE:		onMouseUp = onMouseUp_prepare;
										onMouseDown = null;									
										onEnterFrame = onEnterFrame_prepare;
										OEFTimer.addListener(this);
										break;					
			
			// Sprungverlauf
			case JumpState.JUMP:		Mouse.removeListener(this);
										OEFTimer.removeListener(this);
										onEnterFrame = null;
										break;
			
			// Ende
			case JumpState.FINISHED: 	Mouse.removeListener(this);
										break;			
		}
	}	
	
	function start() : Void
	{
		setState(JumpState.IDLE);
	}	
	
	function toString() : String
	{
		return "[GameController]";
	}
}
