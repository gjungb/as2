class com.adgamewonderland.aldi.aldilivery.game.DeliverMan extends MovieClip
{
	var speed:Number;   // slow..fast | 0..1
	private var v:Number; 		// Geschwindigkeit
		
	var X_LEFT:Number = 150;  	// Linke Grenze
	var X_RIGHT:Number = 520;	// Rechte Grenze
	
	private var A_SLOW:Number = 0.5;
	private var VMAX_SLOW:Number = 7;
	private var SLOWDOWN:Number = 0.004;
	
	private var A_FAST:Number = 2;
	private var VMAX_FAST:Number = 14;
	
	private var dir:Number = 1; // Direction
	private var loading:Boolean;
	
	private var munchCounter:Number; // Zähler für 'Iss PowerUp Mode'
	private var TIME_MUNCH:Number = 20; // Zeit für 'Iss PowerUp Mode'
	
	private var arrowKeyDown:Boolean;
	
	// --------------------------------------------------
	
	var onPower:Function;
	
	// --------------------------------------------------
	
	function onEnterFrame_end() : Void
	{
		this.gotoAndStop("default");
		var speed1:Number = 1-speed;
		var a:Number = this.A_SLOW * speed1 + this.A_FAST * this.speed;
		
		this.v -= a*0.8;
		if (this.v<0) this.v = 0;
		this._x += this.dir*this.v;				
	}
	
	function onEnterFrame_run() : Void
	{
		var wasArrowKeyDown:Boolean = this.arrowKeyDown;
		this.arrowKeyDown = Key.isDown(37) || Key.isDown(39);
		
		if (Key.isDown(37)) this.dir = -1;
		if (Key.isDown(39)) this.dir = 1;
		
		if (this.arrowKeyDown && !wasArrowKeyDown) this.munchCounter = 0;
		
		this.loading = Key.isDown(32);
				
		var speed1:Number = 1-speed;
		var a:Number = this.A_SLOW * speed1 + this.A_FAST * this.speed;
		var vMax:Number = this.VMAX_SLOW * speed1 + this.VMAX_FAST * this.speed;
		
		// Bremsen, wenn Fang
		if (this.loading) vMax *= 0.6; 
		
		if (arrowKeyDown) 
		{
			this.v += a;
		} 
		else 
		{
			this.v -= a*0.8;
		}
		if (this.v<0) this.v = 0;
		
		if (this.v>vMax) this.v = vMax;
		this._x += this.dir*this.v;				
		
		if (this._x<this.X_LEFT) this._x = this.X_LEFT;
		if (this._x>this.X_RIGHT) this._x = this.X_RIGHT;		
		
		this.speed -= this.SLOWDOWN;		
		if (this.speed<0) 
		{
			this.speed = 0;
			this.onPower(0);
			this.onPower = null;
		} 
		else 
		{
			this.onPower(this.speed);
		}
		
		// -----------------------------------------------
		// spiele Animation
		
		if (this.munchCounter>0)
		{
			this.munchCounter--;
			return;
		}
		
		if (this.loading)
		{
			this.gotoAndStop("load");
		} 
		else 
		{
			if (arrowKeyDown)
			{
				if (dir==-1) this.gotoAndStop("left");
				if (dir==1) this.gotoAndStop("right");
			} 
			else 
			{
				this.gotoAndStop("default");
			}
		}
	}
	
	function isCatching() : Boolean
	{
		return Key.isDown(32);
	}
	
	function speedUp() : Void
	{
		this.speed = 1;
	}
	
	function munch() : Void
	{
		this.munchCounter = this.TIME_MUNCH;
		this.speedUp();
		this.gotoAndStop("munch");
	}
	
	function run() : Void
	{
		this.onEnterFrame = this.onEnterFrame_run;
	}
	
	function end() : Void
	{
		this.onEnterFrame = this.onEnterFrame_end;
	}
	
	// ------------------------------------------------------------------
	
	function DeliverMan()
	{		
		this.v = 0;
		this.speed = 0;
		this.munchCounter = 0;
		
		onEnterFrame = onEnterFrame_run;
	}
}
