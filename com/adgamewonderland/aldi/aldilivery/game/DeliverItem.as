import com.adgamewonderland.aldi.aldilivery.game.BaseItem;
class com.adgamewonderland.aldi.aldilivery.game.DeliverItem extends BaseItem
{
	var canBounce:Boolean;
	var isBouncing:Boolean;
	var hasBounced:Boolean;
	
	private var delivering:Boolean; 	// wird ausgeliefert	
	private var lost:Boolean; 			// verloren	
	
	private var G_DEL:Number = 1; 
	
	// Scheitel bei Wurf in LKW 
	private var Y_DELIVERPATH_TOP:Number = 190;
	
	// Zielpunkt LKW
	private var X_DELIVEREVENT:Number = 570; // löse Event etwas früher aus (-> Arm-Animation)
	private var X_DELIVERTARGET:Number = 730;
	private var Y_DELIVERTARGET:Number = 255;
	
	private var deliverSignaled:Boolean;
		
	// ------------------------------------------------
	
	// Callbacks
	var onDelivered:Function;  // ausgeliefert
	var onCatchPos:Function;   // in fangbarer Position
	var onLoose:Function;
	
	// ------------------------------------------------
	
	function onCatchLine(x:Number) : Void
	{
		this.onCatchPos(this,x); // fangbare Position			
		if (!this.delivering && !isBouncing) this.onEnterFrame = this.onEnterFrame_loose;
	}
	
	function onEnterFrame_deliver() : Void
	{		
		this._x += this.vx;
		
		this.vy += this.G_DEL*0.5;
		this._y += this.vy;
		this.vy += this.G_DEL*0.5;
		
		if ((this._x>this.X_DELIVEREVENT) && (!this.deliverSignaled))
		{
			this.onDelivered(this);
			this.deliverSignaled = true;
		}
		
		if (this._x>this.X_DELIVERTARGET)
		{
			delete onEnterFrame;
			this.removeMovieClip(); // tschüss
		}
	}
	
	function onEnterFrame_loose() : Void
	{
		var x0:Number = this._x;
		var y0:Number = this._y;
		
		this.vy += this.G*0.5;
		this._x += this.vx;
		this._y += this.vy;
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
			
			this.onLoose();
			this.gotoAndPlay("lost");
		}
	}
	
	// Bewege von aktueller Position in den LKW
	function deliver() : Void
	{
		var dy1:Number = this._y - this.Y_DELIVERPATH_TOP;
		var dy2:Number = this.Y_DELIVERTARGET - this.Y_DELIVERPATH_TOP;
		
		// s = a/2 *t²
		var t1:Number = Math.sqrt(2*dy1/this.G_DEL);
		var t2:Number = Math.sqrt(2*dy2/this.G_DEL);
		var t:Number = t1 + t2;
		
		var dx:Number = this.X_DELIVERTARGET - this._x;
		this.vx = dx/t;
		this.vy = -this.G_DEL*t1; // v = a/t;
		
		this.deliverSignaled = false;
		this.delivering = true;
		this.onEnterFrame = this.onEnterFrame_deliver;
	}
	
	// --------------------------------------------------------------------
	
	function DeliverItem()
	{		
		this.isBouncing = false;
		this.delivering = false;
		this.hasBounced = false;
	}
}
