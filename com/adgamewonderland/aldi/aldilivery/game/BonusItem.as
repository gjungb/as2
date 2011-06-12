import com.adgamewonderland.aldi.aldilivery.game.BaseItem;

class com.adgamewonderland.aldi.aldilivery.game.BonusItem extends BaseItem
{	
	var factor:Number; 
	
	// --------------------------------------------
	
	var onCatching:Function;
	var onLoose:Function;
	
	// --------------------------------------------
	
	function onCaught() : Void
	{
		this.removeMovieClip();
	}
	
	function onCatchLine(x:Number) : Void
	{
		this.onEnterFrame = this.onEnterFrame_loose;		
	}
	
	function onEnterFrame_loose() : Void
	{
		var x0:Number = this._x;
		var y0:Number = this._y;
				
		this.vy += this.G*0.5;
		this._y += this.vy;
		this._x += this.vx;
		this.vy += this.G*0.5;
		
		this.onCatching(this,this._x); // fangbare Position	
		
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
	
	// --------------------------------------------
	
	function BonusItem()
	{		
	}
}
