import de.kruesch.math.*;
import de.kruesch.event.*;
import de.kruesch.osterspiel.actors.*;

class de.kruesch.osterspiel.logic.Battlefield 
{
	private var enemies:Array;
	private var ball:Ball;
	private var bonus:BonusCar;
	private var hitEnemy:Enemy;

	var gameOver:Boolean;

	private var targetX:Number;
	private var pace:Number = 0;

	private var event:EventBroadcaster;

	private static var BALL_HIT_SPEED:Number = -25;
	private static var HITPOWER:Number = 40;

	// Event Handling
	function addListener(o) : Void		{ event.addListener(o); }
	function removeListener(o) : Void	{ event.removeListener(o); }

	private function checkBonusCollision() : Boolean
	{
		if (bonus==null) return false;

		var pos:Vector = ball.getPos();
		var a:Vector = pos;
		var b:Vector = pos.plus(ball.dir);
		var l:Line = new Line(a,b);

		var c:Circle = bonus.getBounding();
		if (c.intersectLine(l)!=null) return true;
		
		if (c.pos.distanceTo(a)<c.r) return true;
		if (c.pos.distanceTo(b)<c.r) return true;

		for (var i=0; i<enemies.length; i++)
		{
			var e:Enemy = enemies[i];					
			if (!e.knockedOut) continue;

			var u = e.getPos();
			var v:Vector = u.plus(e.dir);
			var l2:Line = new Line(u,v);
			if (c.intersectLine(l2)!=null) 
			{
				e.dir.y = 0;
				return true;
			}
		}

		return false;
	}

	private function checkEnemyCollision() : Boolean
	{
		var pos:Vector = ball.getPos();
		var a:Vector = pos;
		var b:Vector = pos.plus(ball.dir);
		var l:Line = new Line(a,b);

		var hit:Boolean = false;
		hitEnemy = null;
		
		for (var i=0; i<enemies.length; i++)
		{			
			var e2:Enemy = enemies[i];
			var c:Circle = e2.getBounding();
			c.r += ball.r;

			var p:Vector = c.intersectLine(l);
			
			if (p==null) 
			{
				var dist:Number = pos.distanceTo(c.pos);

				if (dist<c.r) 
				{
					p = pos;
				}
			} 

			if (p!=null)
			{			
				hit = true;

				if (ball.dir.y>BALL_HIT_SPEED) 
				{
					e2.y += ball.dir.y*2;
					return true;
				}

				var v:Vector = c.pos.minus(p);
				if (v.y>0) v.y = -v.y;
				v.x /= 2;
				if ((v.x<v.y)||(v.x>-v.y))
				{
					var sgn:Number = v.x<0 ? 1 : -1;
					v.x = v.y*sgn;
				}
				var a:Number = Math.atan2(v.y,v.x);				

				e2.dir = v.normalize().multiply(HITPOWER);
				if (!e2.knockedOut) 
				{
					hitEnemy = e2;
					e2.knockOut();
				}

				e2.moveBy(e2.dir);
			}
		}

		return hit;
	}

	private function doCollisions(e:Enemy) : Void
	{
		var pos:Vector = e.getPos();
		var a:Vector = pos;
		var b:Vector = pos.plus(e.step);
		var l:Line = new Line(a,b);
		if ((a.x==b.x)&&(a.y==b.y)) return;

		// Prüfe Kollision
		for (var i=0; i<enemies.length; i++)
		{
			var e2:Enemy = enemies[i];
			if ((e==e2)||(e2.knockedOut)) continue;
			
			var c:Circle = e2.getBounding();
			c.r = (c.r + e.r)*1.5; // Kollisionsradius

			var p:Vector = c.intersectLine(l);
			
			if (p==null) 
			{
				var dist:Number = pos.distanceTo(c.pos);

				if (dist<c.r) 
				{
					p = pos;
				}
			} 			

			if (p!=null)
			{				
				var v:Vector = c.pos.minus(p);
				if (v.y>0) v.y = -v.y;
				v.x /= 2;
				if ((v.x<v.y)||(v.x>-v.y))
				{
					var sgn:Number = v.x<0 ? 1 : -1;
					v.x = v.y*sgn;
				}
				var a:Number = Math.atan2(v.y,v.x);				

				e2.dir = v.normalize().multiply(HITPOWER);
				e2.moveBy(e2.dir);

				e2.knockOut();
				event.send("onEnemyCollision",e2.typ);			
			}
		}
	
		e.moveStep();
		e.update();
	}

	private function killAll() : Void
	{
		for (var i:Number=0; i<enemies.length; i++)
		{
			var e:Enemy = enemies[i];

			var vx:Number = -e.dir.x;
			var vy:Number = -e.dir.y*2;
			if (vy>0) vy = -vy;

			e.dir = new Vector(vx,vy);
			e.knockOut();
		}
	}

	function moveBall() : Void
	{
		ball.update();
		ball.y += ball.dir.y;
		ball.dir = ball.dir.multiply(0.99);		
	}

	function walk(e:Enemy)
	{
		var dx:Number = targetX - e.x;
		if (dx<-50) dx = -50;
		if (dx>50) dx = 50;

		var ny:Number = -1000/(e.y-10);		
		var nx:Number = (dx/(18+ny*2.2)) + Math.random()*pace*2 - pace;

		e.dir = new Vector(nx*e.speed,2.3*e.speed);		
		var pos:Vector = e.getPos();
		var pos2 = pos.plus(e.dir);

		for (var i:Number=0; i<enemies.length; i++)
		{
			var e2:Enemy = enemies[i];
			if ((e==e2)||(e.y>=e2.y)) continue;
		
			var e2pos:Vector = e2.getPos();

			var dist:Number = pos2.distanceTo(e2.getPos());
			if (dist<(e2.r+e.r)) 
			{
				e.dir.y = 1*e.speed;
				e.dir.y = nx*3;
				var nx:Number = e2pos.x - pos.x;
				var sgn:Number = nx<0 ? 1 : -1;

				e.dir.x = Math.abs(e.dir.x)*sgn*e.speed;
				break;
			} 
		}
		
		e.moveStep();
		e.update();
	}

	function step(x:Number) : Void
	{
		// Ball in Bewegung?
		if (!ball.moving) 
		{
			ball._visible = false;			
		}

		// Bonus unterwegs?
		if (bonus!=null) 
		{
			bonus.x += bonus.dir*26;
			if (bonus.dir<0)
			{
				if (bonus.x<-1250)
				{
					removeBonus();
				}
			} 
			else 
			{
				if (bonus.x>1250)
				{
					removeBonus();
				}
			}

			bonus.update();
		}

		pace = (pace+1)%5;
		if (pace==0) 
		{
			targetX = 1.6*(x-325)-40;
		}

		// enemies.sort(function(a,b) { return a.y-b.y; });	

		for (var i:Number=0; i<enemies.length; i++)
		{
			enemies[i].initMove();
		}

		var hitBonus:Boolean = checkBonusCollision();
		if (hitBonus) 
		{
			event.send("onBonusHit");
			killAll();
			removeBonus();
		}

		// Ball
		if (ball.moving) 
		{	
			moveBall();

			var hit:Boolean = checkEnemyCollision();	
			if (hit && (hitEnemy!=null) ) event.send("onEnemyHit",hitEnemy.typ);

			if (hit || hitBonus)
			{
				ball.moving = false;									
				event.send("onBallShot");
			} 
			else 
			{				
				if ((ball.y<-1150)||(ball.dir.y>-1.5))
				{
					if (ball.moving) event.send("onBallShot");
					ball.moving = false;

					// Nest?
					if (Math.abs(ball.x)<230) event.send("onGoal");
				}
			}
		}

		for (var i:Number=0; i<enemies.length; i++)
		{
			var e:Enemy = enemies[i];
		
			if (e.knockedOut) 
			{
				doCollisions(e);
			} 
			else 
			{
				walk(e);

				if ((!gameOver) && (e.y>-40)) 
				{
					gameOver = true;
					removeEnemy(e);
					event.send("onGameOver",e);
				}
			}
		}
	}

	function kickBall(x:Number,strength:Number)
	{
		var s:Number = 1 + (strength/5);

		ball._visible = true;
		ball.moving = true;
		ball.x = x;
		ball.y = 40;		
		ball.dir = new Vector(0,-s);
		ball.update();
	}

	function addEnemy(e:Enemy) : Void
	{
		enemies.push(e);
		e.setBattlefield(this);
	}

	function createBonus() : Void
	{
		if (bonus!=null) return;

		bonus = BonusCar.create();	

		var dir:Number = Math.random()<0.5 ? -1 : 1;
		bonus.setDirection(dir);
		bonus.y = -350 - Math.random()*200;
		bonus.x = -bonus.dir*1250;		

		event.send("onBonusStart");
	}

	function removeBonus() : Void
	{
		bonus.removeMovieClip();
		bonus = null;

		event.send("onBonusEnd");
	}

	function removeEnemy(e:Enemy) : Void
	{
		for (var i=0; i<enemies.length; i++)
		{
			if (enemies[i]==e) 
			{
				enemies.splice(i,1);
				return;
			}
		}
	}

	function cleanUp() : Void
	{
		for (var i:Number=0; i<enemies.length; i++)
		{
			enemies[i].removeMovieClip();
		}
	}

	function Battlefield(b:Ball)
	{
		enemies = [];
		ball = b;

		targetX = 400;
		pace = 0;
		ball.moving = false;

		gameOver = false;

		event = new EventBroadcaster();
	}
}
