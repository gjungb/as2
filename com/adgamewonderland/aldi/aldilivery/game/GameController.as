import de.kruesch.event.EventBroadcaster;
import com.adgamewonderland.aldi.aldilivery.game.*;
import mx.utils.Delegate;

class com.adgamewonderland.aldi.aldilivery.game.GameController
{
	private var itemDepth:Number; // MovieClip Tiefe
	private var player:DeliverMan;
	private var gameField:MovieClip;
	
	// LinkageIDs
	private var itemIDs:Array = ["beer", "cds", "coffee", "flakes", "juice", "pasta", "tandil", "tempo", "tempos", "toffifee", "water", "wipes"]; // ["CHEESE","BOTTLE","CHEESE","LOBSTER","SALT","TURKEY","MEAT"];
	private var specialID:String = "beer";
	private var powerUpID:String = "POWERUP";
	private var x2ID:String = "X2";
	private var x3ID:String = "X3";
	private var extraLiveID:String = "LIVE+";
	
	// Timer, Werte in Frames
	private var time:Number;
	private var totalTime:Number;
	
	private var itemTime:Number;
	private var interval:Number; 
	
	// Wahrscheinlichkeiten
	
	var P_BONUS:Number = 0.10; 
	var P_POWER:Number = 0.20; // 0.20 - 0.10
	var P_LIVE:Number = 0.25; // 0.25 - 0.20
	
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
	
	// ----------------------------------------------
		
	// Startpunkt Würfe
	private var X0:Number = -70;
	private var Y0:Number = 260;
	
	// Wurf Range
	private var XMIN:Number = 190;
	private var XMAX:Number = 500;
	
	private var H_MIN:Number = 120;
	private var H_MAX:Number = 250;
	
	private var W_BOUNCE:Number = 100; // Weite
	private var DW_BOUNCE:Number = 150; // Variation
	
	private var H_BOUNCE:Number = 250; // Höhe
	private var DH_BOUNCE:Number = 80; // Variation
	
	// ----------------------------------------------
	
	function nextItem() : Void
	{
		var p:Number = Math.random();
		
		if (p<this.P_BONUS) 
		{
			var f:Number = Math.random()>0.5 ? 3 : 2;
			this.throwBonus(f);
			return;
		}
		
		if (p<this.P_POWER)
		{
			this.throwPowerUp();
			return
		}
		
		if (p<this.P_LIVE)
		{
			this.throwBonus(-1);
			return;
		}
		
		var n:Number = Math.floor(this.itemIDs.length*Math.random()*0.999999999999999);
		var id:String = this.itemIDs[n];
		
		this.throwDeliverable(this.itemIDs[n],id==specialID);		
	}
	
	function onThrown(y:Number) : Void
	{
		this._event.send("onItemThrown",y);
	}
	
	function onCatchPowerUp(item:PowerUpItem,x:Number) : Void
	{
		var dx:Number = x - this.player._x;
	
		if ((dx>-30)&&(dx<45))
		{
			item.eat();
			this.player.munch();
			this.onItemEnd();	
			this._event.send("onPowerUp");
			this.player.onPower = Delegate.create(this,this.onSpeedUp);
			return;
		}
		
		if (Math.abs(dx)<90) item.bounce();
	}
	
	function onLoosePowerUp(item:PowerUpItem) : Void
	{
		this.onItemEnd();
	}
	
	function onCatchPos(item:DeliverItem,x:Number) : Void
	{
		if (!this.player.isCatching()) 
		{
			item.isBouncing = false;			
			return;
		}
			
		var dx:Number = x - this.player._x;

		if ((dx>45)||(dx<-30)) 
		{
			item.isBouncing = false;
			return;
		}
		
		if (!item.isBouncing && item.canBounce)
		{
			this._event.send("onItemBounced");
			this.bounceItem(item);
			return;
		}
		
		this._event.send("onItemCaught");
		item.isBouncing = false;
		item.deliver();
	}
	
	function onLooseItem(item:DeliverItem) : Void
	{
		this._event.send("onItemLost");
		this.onItemEnd();
	}
	
	function onDelivered(item:DeliverItem) : Void
	{
		this._event.send("onItemDelivered",item.hasBounced);
		this.onItemEnd();
	}
	
	function onCatchingBonus(item:BonusItem,x:Number) : Void
	{
		var dx:Number = Math.abs(x - this.player._x);
		if (dx<30)
		{
			var multiplier:Number = item.factor;
			item.onCaught();
			
			if (multiplier<0) 
			{
				this._event.send("onExtraLive");
			} 
			else 
			{
				this._event.send("onBonusItem",multiplier);
			}
			
			this.onItemEnd();
		}
	}
	
	function onLooseBonus(item:BonusItem) : Void
	{
		this.onItemEnd();
	}
	
	function onSpeedUp(s:Number) : Void
	{
		this._event.send("onPower",s);
	}
	
	// ----------------------------------------------
	
	function throwPowerUp(linkageID:String) : Void
	{
		var item:PowerUpItem = PowerUpItem(this.throwItem(this.powerUpID));
		
		item.onCatchPos = Delegate.create(this,this.onCatchPowerUp);
		item.onLoose = Delegate.create(this,this.onLoosePowerUp);
	}
	
	function throwDeliverable(linkageID:String,bounce:Boolean) : Void
	{
		var item:DeliverItem = DeliverItem(this.throwItem(linkageID));
		item.canBounce = bounce;
		item.onCatchPos = Delegate.create(this,this.onCatchPos);
		item.onLoose = Delegate.create(this,this.onLooseItem);
		item.onDelivered = Delegate.create(this,this.onDelivered);
	}
	
	function throwBonus(factor:Number) : Void
	{
		var linkageID:String = extraLiveID;
		if (factor==2) linkageID = x2ID;
		if (factor==3) linkageID = x3ID;		
		
		var item:BonusItem = BonusItem(this.throwItem(linkageID));
		item.factor = factor;		
		item.onCatching = Delegate.create(this,this.onCatchingBonus);
		item.onLoose = Delegate.create(this,this.onLooseBonus);
	}
	
	// Special - "Bounce"
	function bounceItem(item:DeliverItem) : Void
	{
		var x0:Number = item._x;
		var y0:Number = item._y;
		
		var x1:Number = item._x + this.W_BOUNCE + Math.random()*this.DW_BOUNCE;		
		var dy:Number = this.H_BOUNCE + Math.random()*this.DH_BOUNCE;		
		if (x1>this.XMAX) x1 = this.XMAX;
		
		item.hasBounced = true;
		item.isBouncing = true;
		item.kickOff(x0,y0,x1-x0,dy);
	}
	
	function throwItem(linkageID:String) : MovieClip
	{		
		this.itemDepth = (this.itemDepth+1) % 50;
		var name:String = "item" + this.itemDepth;
		
		this.gameField.attachMovie( linkageID,
									name, 
									this.itemDepth+1,
									{ _x:this.X0, _y:this.Y0 }
								  );

		var dx:Number = this.XMIN - this.X0 + (this.XMAX - this.XMIN) * Math.random();
		var dy:Number = this.H_MIN + (this.H_MAX - this.H_MIN) * Math.random();
		
		var item = this.gameField[name];
		item.kickOff(this.X0, this.Y0, dx, dy);
		
		item.onThrown = Delegate.create(this,this.onThrown);
		
		return item
	}
	
	// -------------------------------------------------
	
	function onTick() : Void
	{
		if (this.itemTime>this.interval)
		{
			this.itemTime = 0;			
		}
		
		if (this.itemTime==0) this.nextItem();
		
		this.time++;
		this.itemTime++;
		
		var t:Number = this.time/this.totalTime;
		this._event.send("onTick",this,t);
	}
	
	function stop() : Void
	{
		for (var m in this.gameField)
		{
			if (m.substr(0,4)=="item") this.gameField[m].removeMovieClip();
		}
		
		this.player.end();
		this.gameField.onEnterFrame = null;
	}
	
	function start(t:Number,iv:Number) : Void
	{
		this.totalTime = t;
		this.time = 0;
		
		this.itemTime = 0;
		this.interval = iv;
		
		this.gameField.onEnterFrame = Delegate.create(this,this.onTick);
		
		// Platziere in der Mitte
		this.player._x = (this.player.X_RIGHT + this.player.X_LEFT) / 2;
		this.player.run();
	}
	
	function onItemEnd() : Void
	{
		
	}
	
	// -------------------------------------------------	
		
	// Konstruktor
	function GameController(gameMC:MovieClip,p:DeliverMan)
	{
		this.gameField = gameMC;
		this.player = p;
		this.player.onPower = Delegate.create(this,this.onSpeedUp);
		
		this._event = new EventBroadcaster();
	}
}
