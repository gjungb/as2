class com.adgamewonderland.aldi.aldilivery.game.BaseItem extends MovieClip
{
	private var vx:Number; 				// Geschwindigkeit x
	private var vy:Number;				// Geschwindigkeit y
	
	private var G:Number = 0.6; 			// Schwerkraft	
	private var G_DEL:Number = 0.8; 
	private var Y_GROUND:Number = 310;	// Boden
	private var X_KICK:Number = -40.0;
	private var Y_CATCH = 260; 			// Fanglinie
	
	private var thrown:Boolean;
	
	// ---------------------------------------------------------------
	
	function onThrown() : Void {}
	function onCatchLine(x:Number) : Void {} // abstract
	
	function onEnterFrame_throw() : Void
	{
		if ((this._x>this.X_KICK) && (!this.thrown))
		{
			this.thrown = true;
			this.onThrown(this._y);
		}
		
		var x0:Number = this._x;
		var y0:Number = this._y;
				
		this.vy += this.G*0.5;
		this._y += this.vy;
		this._x += this.vx;
		this.vy += this.G*0.5;
		
		if ((this._y>this.Y_CATCH)&&(this.vy>0))
		{
			delete this.onEnterFrame;
			
			var j:Number = this.Y_CATCH - y0;			
			if (j<0) j = 0;
			var k:Number = this._y - y0;
			
			var x:Number = x0 + (this._x - x0) * j/k;
			
			this.onCatchLine(x);
		}
	}
	
	function kickOff(x0:Number, y0:Number, dx:Number, dy:Number) : Void
	{
		this._x = x0;
		this._y = y0;
		
		var t:Number = Math.sqrt(2*dy/this.G);  // Zeit von Wurf bis Scheitelpunkt
		var t_total:Number = 2*t; 		  		// Gesamtwurfzeit in Frames
		
		this.vx = dx/t_total;
		this.vy = -this.G*t;				
		
		this.onEnterFrame = this.onEnterFrame_throw;
	}
	
	// ---------------------------------------------------------------
	
	function BaseItem()
	{		
		this.thrown = false;
	}
}
