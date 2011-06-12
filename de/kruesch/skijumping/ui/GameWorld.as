import de.kruesch.event.*;
import de.kruesch.skijumping.PathFunctions;

class de.kruesch.skijumping.ui.GameWorld extends MovieClip 
	implements IFrameListener
{
	private var skiman : MovieClip; // Skifahrer MC
	private var _x0:Number,_y0:Number; // Startposition

	// c'tor
	function GameWorld()
	{
		// OEFTimer.addListener(this);

		this._x0 = this.skiman._x;
		this._y0 = this.skiman._y;
	}

	// setzte Position des Skifahrer MC
	function setPos(x:Number,y:Number,r:Number) : Void
	{
		this.skiman._x = this._x0 - x;
		this.skiman._y = this._y0 + y;		
		this.skiman._rotation = r;
//		trace(x);
	}

	function setDigState() : Void
	{
		this.skiman.gotoAndStop("dig");
	}

	function setFlyingState() : Void
	{
		this.skiman.gotoAndStop("flying");
	}

	function setLandingState() : Void
	{
		this.skiman.gotoAndStop("land");
	}
	
	// Ansicht scrollen
	function onEnterFrame() : Void
	{
		var sx:Number = this.skiman._x;
		var sy:Number = this.skiman._y;

		var x:Number = this._x0 - sx;
		var y:Number = sy - this._y0;

		if (sx<-400)
		{
			this._x = 600-400-sx;
		} 
		else 
		{
			this._x = 600;
		}

		var yg:Number = PathFunctions.getGroundDist(x,y);
//		this._y = 300-sy-yg*0.54;
		this._y = 300 - sy - yg; // * 0.66;
	}
	
	// ~ finalize
	function onUnload() : Void
	{
		// OEFTimer.removeListener(this);
	}
};
