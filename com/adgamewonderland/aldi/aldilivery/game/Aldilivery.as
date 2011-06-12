import com.adgamewonderland.aldi.aldilivery.game.DeliverMan;
import com.adgamewonderland.aldi.aldilivery.game.GameController;

import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.aldi.aldilivery.game.Aldilivery
{
	var level:Number;
	var score:Number;
	var lives:Number;
	var bonusFactor:Number;
	
	private var ctrl:GameController;
	
	private var INITIAL_LIVES:Number = 5;
	private var SCORE_NORMAL:Number = 10;
	private var SCORE_SPECIAL:Number = 20;
	private var INTERVAL_LEVEL1:Number = 25*3.5; 	// Wurfinterval Level 1
	private var INTERVAL_DEC:Number = 12; 		// Abnahme Wurfinterval Level zu Level
	
	private var DURATION:Number = 25*40;
	
	/*
	event onGameOver()
	event onLevelComplete(a:Aldilivery,l:Number)		
	event onExtraLive()	
	event onBonusFactor(f:Number)
	event onPowerUp()	
	event onItemLost()
	event onItemBounced()	
	event onItemDelivered(score:Number)
	event onItemThrown(ypos:Number)
	event onUpdateStatus(a:Aldilivery,t:Number)
	event onPowerChanged(p:Number)
	*/
	
	// ----------------------------------------------
	
	private var _event:EventBroadcaster;
	
	function addListener(o:Object) : Void
	{
		_event.addListener(o);
	}
	
	function removeListener(o:Object) : Void
	{
		_event.removeListener(o);
	}
	
	// -------------------------------------	
	// Leben
	
	function onGameOver() : Void
	{
		this.ctrl.stop();
		
		_event.send("onUpdateStatus",this,0);
		_event.send("onGameOver", score);
	}
	
	function onExtraLive() : Void
	{
		if (lives>0) 
		{
			_event.send("onExtraLive");
			
			lives++;
		}
	}
	
	function onItemLost() : Void
	{
		lives--;
		onBonusItem(1);
		
		_event.send("onItemLost");		
		
		if (lives<1) onGameOver();
	}
	
	// -------------------------------------
	
	function onTick(gc:GameController,t:Number) : Void
	{
		_event.send("onUpdateStatus",this,t);
		
		if (t>=1)
		{
			gc.stop();
			
			if (lives>0)
			{ 
				_event.send("onLevelComplete",this,level);
			}
		}
	}
	
	function onPower(p) : Void
	{
		_event.send("onPowerChanged",p);
	}
	
	// -------------------------------------
	
	function onBonusItem(factor:Number) : Void
	{  
		var oldFactor:Number = this.bonusFactor;
		
		if ((this.bonusFactor<2) || (factor==1))
		{
			this.bonusFactor = factor;
			_event.send("onBonusFactor",factor);			
		} 
		else 
		{
			this.bonusFactor += factor;
			_event.send("onBonusFactor",this.bonusFactor);
		}
		
		trace([oldFactor,factor,this.bonusFactor]);
	}
	
	function onPowerUp() : Void
	{
		_event.send("onPowerUp");
	}
	
	function onItemDelivered(bounced) : Void
	{
		score += (bounced ? SCORE_SPECIAL : SCORE_NORMAL) * bonusFactor;
		
		_event.send("onItemDelivered",score);
	}
	
	// -------------------------------------
	
	function onItemThrown(y) : Void
	{ 
		_event.send("onItemThrown",y);
	}
	
	function onItemCaught() : Void
	{
		_event.send("onItemCaught");
	}
	
	function onItemBounced() : Void
	{
		_event.send("onItemBounced");
	}
	
	// -------------------------------------
	
	function nextLevel() : Void
	{
		if (lives<1) 
		{
			onGameOver();
			return;
		}
		
		level++;		
		ctrl.start( DURATION, INTERVAL_LEVEL1 - (level-1)*INTERVAL_DEC );
	}
	
	function start() : Void
	{
		level = 1;
		score = 0;
		lives = INITIAL_LIVES;
		onBonusItem(1);
		
		ctrl.start(DURATION,INTERVAL_LEVEL1);
	}
	
	// -------------------------------------
	
	function Aldilivery(g:MovieClip,d:DeliverMan)
	{
		ctrl = new GameController(g,d);		
		ctrl.addListener(this);
		
		this._event = new EventBroadcaster();		
	}
}
