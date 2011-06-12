import com.adgamewonderland.aldi.aldilivery.game.BaseItem;

class com.adgamewonderland.aldi.aldilivery.game.PowerUpItem extends BaseItem
{
	private var Y_BOUNCE = 220; 			// Sprungscheitelpunkt	
	private var bouncing:Boolean;
	
	// ---------------------------------------------------------------------------
	
	var onCatchPos:Function;
	var onBouncePos:Function;
	var onLoose:Function;
	
	// ---------------------------------------------------------------------------
	
	function onCatchLine(x:Number) : Void
	{
		this.onEnterFrame = this.onEnterFrame_loose;
		this.onCatchPos(this,x); // fangbare Position	
	}
	
	function onEnterFrame_loose() : Void
	{
		var x0:Number = this._x;
		var y0:Number = this._y;
				
		this.vy += this.G*0.5;
		this._y += this.vy;
		this._x += this.vx;
		this.vy += this.G*0.5;
		
		if ((this._y>this.Y_GROUND)&&(this.vy>0))
		{
			delete this.onEnterFrame;			
			
			var j:Number = this.Y_GROUND-y0;			
			if (j<0) j = 0;
			var k:Number = this._y - y0;
			
			var x:Number = x0 + (this._x - x0) * j/k;
			
			this._x = x;
			this._y = Y_GROUND;
			
			if (this.bouncing)
			{
				var dy:Number = this._y - this.Y_BOUNCE;
				var t:Number = Math.sqrt(2*dy/this.G);  // Zeit von Wurf bis Scheitelpunkt
				
				var vy0:Number = this.vy;
				this.vy = -this.G*t;
				
				this.vx = (-this.vx * this.vy/vy0)*0.2;
				
				this.onEnterFrame = this.onEnterFrame_bounce;
			} 
			else 
			{			
				this.onLoose();
				this.gotoAndPlay("lost");
			}
		}
	}
	
	function onEnterFrame_bounce() : Void
	{
		var x0:Number = this._x;
		var y0:Number = this._y;
				
		this.vy += this.G*0.5;
		this._y += this.vy;
		this._x += this.vx;
		this.vy += this.G*0.5;
		
		if ((this._y>this.Y_CATCH)&&(this.vy>0))
		{
			delete this.onEnterFrame;
			
			var j:Number = this.Y_CATCH-y0;	
			if (j<0) j = 0;
			var k:Number = this._y - y0;
			
			var x:Number = x0 + (this._x - x0) * j/k;
						
			this.onEnterFrame = this.onEnterFrame_loose;
			this.onCatchPos(this,x); // fangbare Position
			this.bouncing = false;
		}
	}
	
	// ---------------------------------------------------------------------------
	
	function eat() : Void
	{
		this.removeMovieClip();
	}
	
	function bounce() : Void
	{		
		this.bouncing = true;		
	}
		
	// ---------------------------------------------------------------------------
	
	function CandyItem()
	{		
	}
}
