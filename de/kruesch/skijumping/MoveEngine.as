import de.kruesch.event.*;
import de.kruesch.skijumping.*;
import de.kruesch.skijumping.ui.GameWorld;

class de.kruesch.skijumping.MoveEngine implements IFrameListener
{
	private var _game : GameWorld;
	private var x:Number = 0, y:Number = 0;
	private var vx:Number,vy:Number;
	private var ax:Number,ay:Number;
	
	private static var EV_JUMP = "onSkiJump";
	private static var EV_LANDED = "onSkiLanded";
	private static var EV_FINISH = "onSkiFinish";

	private static var FACTOR_METERS:Number = 0.07;
	
	private var _event:EventBroadcaster;
	
	// c'tor
	function MoveEngine(g:GameWorld) 
	{
		_event = new EventBroadcaster();
		_game = g;
	}
	
	// Event Handling
	function addListener(o:Object) : Void
	{
		_event.addListener(o);
	}
	
	function removeListener(o:Object) : Void
	{
		_event.removeListener(o);
	}
	
	// Status-Properties
	function get canJumpOff() : Boolean
	{
		return (x>280) && (x<360);
	}
	
	function get isOverDue() : Boolean
	{
		return (x>=360) && (x<380);
	}
	
	function get canAccelerate() : Boolean
	{
		return (x>19) && (x<280);
	}
	
	function reset() : Void 
	{
		OEFTimer.removeListener(this);
		
		x = 0;
		vx = 0;
		ax = 0.01;		

		_game.setPos(0,0,0);	

		_game.setDigState();
	}

	function start() : Void 
	{		
		_game.setPos(0,0);
		
		x = 0;
		vx = 0;
		ax = 0.01;		
		
		onEnterFrame = onEnterFrame_dig;	
		OEFTimer.addListener(this);		

		_game.setDigState();
	}
	
	function setJumpStrength(n:Number) : Void
	{
		n = Math.sqrt(n) * 1.1;
		
		vx = 8+11.5*n + Math.random()*1;
		vy = 4-12*n;
		ay = 1.8-1.2*n;
	}
	
	function onEnterFrame() : Void {}
	
	// Schanze
	private function onEnterFrame_dig() : Void
	{
		// Position
		y = PathFunctions.getDigY(x);	
		
		// Rotation	
		var dx = 10;
		var y2 = PathFunctions.getDigY(x+dx);
		var dy = (y2-y);
		var d = 10/Math.sqrt(dy*dy+100);	
		var r = -180*Math.atan2(dy,10)/Math.PI;	
		if (r>0) r = 0;
		
		_game.setPos(x,y,r);
		
		// Move forward
		ax += 0.03;
		vx += ax;
		x += vx*d;		
		
		if (x>380) transitJump();
	}
	
	private function transitJump() : Void
	{		
		onEnterFrame = onEnterFrame_fly;
		_event.send(EV_JUMP);
	}
	
	private function onEnterFrame_fly() : Void
	{
		// Bewegen
		x += vx;
		y += vy;
		
		// Luftwiderstand
		vx *= 0.99;
		
		// Schwerkraft
		vy += ay;		
		
		var d = PathFunctions.getGroundDist(x,y);
		if (d<=0) 
		{
			onEnterFrame_landing();
			transitLanding();
			return;
		}
		
		// MC positionieren
		_game.setPos(x,y,0);

		_game.setFlyingState();
	}
	
	private function transitLanding() : Void
	{
		if (x<900) 
		{
			onEnterFrame = onEnterFrame_shortLanding;
		} 
		else 
		{		
			onEnterFrame = onEnterFrame_landing;
		}

		var meters:Number = x*FACTOR_METERS;
		// runden auf eine nachkommastelle
		meters = Math.round(meters * 10) / 10;
		
		_event.send(EV_LANDED,meters);

		_game.setLandingState();
	}
	
	private function onEnterFrame_shortLanding() : Void
	{
		x += vx;
		vx -= 0.15;
		
		if (vx<0) 
		{
			transitFinish();			
			return;
		}
		
		y = PathFunctions.getGroundY(x);
		var y2:Number = PathFunctions.getGroundY(x+10);
		var r = -180*Math.atan2(y2-y,10)/Math.PI;			
		
		_game.setPos(x,y,r);
	}
	
	private function onEnterFrame_landing() : Void
	{
		x += vx;
//		vx -= x > (PathFunctions.DIST_MAX + 100) ? 0.6 : 0.1; // 0.01;
		vx *= x > (PathFunctions.DIST_MAX + 100) ? 0.8 : 0.95;
		
		if (vx < 1) 
		{
			transitFinish();			
			return;
		}
		
		y = PathFunctions.getGroundY(x);
		var y2:Number = PathFunctions.getGroundY(x+10);
		var r = -180*Math.atan2(y2-y,10)/Math.PI;					
		
		_game.setPos(x,y,r);
	}	
	
	private function transitFinish() : Void
	{
		onEnterFrame = null;
		OEFTimer.removeListener(this);
		
		_event.send(EV_FINISH);			
	}
}

