import de.kruesch.osterspiel.ui.*;
import de.kruesch.osterspiel.actors.*;
import de.kruesch.event.*;
import de.kruesch.osterspiel.logic.*;
import mx.utils.Delegate;

class de.kruesch.osterspiel.logic.OsterGame implements IFrameListener
{
	// Logik
	private var field:Battlefield;
	private var kickController:KickController;
	
	// MCs
	private var ground:MovieClip;
	private var ball:Ball;
	private var kicker:MovieClip;
	private var winner:Enemy;

	// ID Zaehler
	private var counter:Number;

	// Timing
	private var interval:Number;
	private var timer:Number;
	private var endTime:Number;
	private var bonusTimer:Timer;
	
	// Event
	private var _event:EventBroadcaster;

	// Parameter
	private static var TIME_MAX:Number = 100;
	private static var TIME_MIN:Number = 25;
	private static var TIME_F:Number = 0.98;

	private static var BONUSTIME_MIN:Number = 15 * 1000;
	private static var BONUSTIME_MAX:Number = 30 * 1000;
	
	private static var KICKER_XMIN:Number = 90;
	private static var KICKER_XMAX:Number = 600;
	
	// c'tor
	function OsterGame(w:MovieClip,k:KickController,b:Ball,p:MovieClip)
	{
		ground = w; 
		kickController = k;
		ball = b;
		kicker = p;

		BonusCar.setGround(w);

		kickController.addListener(this);
		reset();

		_event = new EventBroadcaster();		
	}
	
	// Event Handling
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }

	function reset() : Void
	{
		counter = 0;
		interval = TIME_MAX;

		field = new Battlefield(ball);
		field.addListener(this);		

		ball._visible = true;	

		for (var m in ground)
		{
			var mc:MovieClip = ground[m];
			if (mc._name.substr(0,6)=="enemy_") mc.removeMovieClip();
		}
	}

	function start() : Void
	{
		reset();				
		OEFTimer.addListener(this);

		kickController.enable();
		kicker.setKicking();
		onEnterFrame = onEnterFrame_Game;	

		setBonusTime();	
	}

	function onBonusHit() : Void
	{
		_event.send("onBonusHit");
	}

	function onEnemyHit(typ:Number) : Void
	{
		_event.send("onEnemyHit",typ);
	}

	function onBonusStart() : Void
	{
		_event.send("onBonusStart");
	}

	function onBonusEnd() : Void
	{
		_event.send("onBonusEnd");
	}

	function onKickOff(strength:Number) : Void
	{
		kickController.disable();
		field.kickBall( 1.6 * (kicker._x-355), strength*1.5 );
		kicker.gotoAndPlay("kickoff");
		ball.bounce();

		_event.send("onKickOff");
	}

	function onBallShot() : Void
	{
		kickController.enable();		
	}

	function onBonusTime() : Void
	{
		if (field.gameOver) return;
		field.createBonus();		

		setBonusTime();		
	}

	function onEnemyCollision(typ:Number) : Void
	{
		_event.send("onEnemyCollision",typ);
	}

	function onGoal() : Void
	{
		_event.send("onGoal");
	}

	function setBonusTime() : Void
	{
		var waitingTime:Number = BONUSTIME_MIN + (BONUSTIME_MAX - BONUSTIME_MIN)*Math.random();
		bonusTimer = new Timer(waitingTime,Delegate.create(this,this.onBonusTime));
	}

	private function addEnemy(typ:Number) : Void
	{
		var linkageID:String;
		switch (typ)
		{
			case 3: linkageID = "huhn3"; break;
			case 2: linkageID = "huhn2"; break;
			case 1: linkageID = "huhn1"; break;
		}
		var e:Enemy = Enemy(ground.attachMovie(linkageID,"enemy_"+(counter++),100));
		
		var left:Boolean = Math.random()>0.5;
		var x:Number;

		if (left)
		{
			x = -800 - Math.random()*800;
		} 
		else 
		{
			x = 800 + Math.random()*600;
		}
		
		e.moveTo(x,-1300);
		field.addEnemy(e);
	}

	function nextEnemy() : Void
	{
		if (field.gameOver) return;

		timer = 0;
		endTime = interval + 30*Math.random();

		interval *= TIME_F;
		if (interval<TIME_MIN) interval = TIME_MIN;
		if (endTime<(TIME_MIN+10)) endTime = (TIME_MIN+10);
		
		var dt:Number = TIME_MAX - TIME_MIN;
		var n:Number = (interval - TIME_MIN) /dt; // 1..0		
		var r:Number = Math.random(); // 0..1

		var enemyTyp:Number = 1;

		// n <= 0.5
		// n <= 0.2 
		if (n<0.7)
		{
			if (n<0.3)
			{
				var m:Number = n/0.3; // 1..0
				enemyTyp = r>m ? 3 : 2;
			} 
			else 
			{
				var m:Number = (n-0.3) / (0.7-0.3); // 1..0
				enemyTyp = r>m ? 2 : 1;
			}
		} 

		addEnemy(enemyTyp);
	}

	function onEnterFrame() : Void {}

	function onEnterFrame_Game() : Void
	{	
		timer++;
		if (timer>=endTime)
		{
			nextEnemy();
		}
		
		var kx:Number = kicker._x*0.7 + _root._xmouse*0.3;
		if (kx<KICKER_XMIN) kx = KICKER_XMIN;
		if (kx>KICKER_XMAX) kx = KICKER_XMAX;
		kicker._x = kx;
		kicker.swapDepths(60000);
		ground.trees.swapDepths(60001);		

		field.step(kx);				

		if (kickController.enabled)
		{			
			ball.y = 40;
			ball._visible = true;
			ball.x = 1.57 * (kicker._x-350);
			ball.update();
			ball.idle();
		}
	}

	function onGameOver(e:Enemy) : Void
	{
		winner = e;
		kicker.tx = kicker._x;		
		
		if (kicker._x<280) kicker.tx = 280;
		if (kicker._x>550) kicker.tx = 550;
				
		timer = 0;
		kickController.disable();

		ball._visible = true;

		onEnterFrame = onEnterFrame_GameOver;		
	}

	function onGameOverEnd() : Void
	{
		OEFTimer.removeListener(this);
		_event.send("onGameOver");
	}

	function onEnterFrame_GameOver() : Void
	{
		timer ++;
		kicker._x = kicker._x*0.6 + kicker.tx*0.4;
		winner._x = winner._x*0.8 + (kicker.tx-148)*0.2; 
		winner._y = winner._y*0.8 + 470*0.2;

		if (timer==10)
		{
			winner._xscale = winner._yscale = 100;
			kicker.gotoAndStop("ko");
			winner.gotoAndPlay("win");
			winner.swapDepths(64000);

			onGameOverEnd();
		}
	}
};
