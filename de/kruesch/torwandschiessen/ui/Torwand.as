import de.kruesch.torwandschiessen.geom.*;

class de.kruesch.torwandschiessen.ui.Torwand extends MovieClip
{
	// L?cher-Kombinationen
	public static var HOLES_MITTE : Number		= 1;
	public static var HOLES_UNTEN_OBEN : Number = 2;
	public static var HOLES_OBEN_UNTEN : Number = 3;

	// Loch IDs
	public static var LEFTHOLE : Number		= 1;
	public static var RIGHTHOLE : Number	= 2;
	
	// "Einrasten"
	private static var SNAP_DISTANCE:Number = 40;

	// L?cher offen?
	private var _leftHoleOpen : Boolean;
	private var _rightHoleOpen : Boolean;

	private var _leftHolePos : Point;
	private var _rightHolePos : Point;
	
	// Torwand Ausdehnung
	private var _topLeft : Point;
	private var _bottomRight : Point;
	
	// MCs
	private var _leftHoleMC:MovieClip,_rightHoleMC : MovieClip;
	private var _latteLeft:MovieClip, _latteRight:MovieClip;
	
	// Torloch Kombinationen
	private var _holes:Number;

	
	// setze Loch
	function setHoles(modus:Number) : Void
	{
		switch(modus)
		{
			case HOLES_UNTEN_OBEN:
				this.gotoAndStop("HOLES_UNTEN_OBEN");
				_leftHoleOpen = true;
				_rightHoleOpen = true;
				break;
				
			case HOLES_OBEN_UNTEN:
				this.gotoAndStop("HOLES_OBEN_UNTEN");
				_leftHoleOpen = true;
				_rightHoleOpen = true;
				break;
				
			case HOLES_MITTE:
				this.gotoAndStop("HOLES_MITTE");
				_leftHoleOpen = true;
				_rightHoleOpen = true;
				break;
		}
		
		_holes = modus;

		updatePositions();
	}

	// Löcher öffnen
	function clear() : Void
	{
		_leftHoleOpen = false;
		_rightHoleOpen = false;

		setHoleOpen(LEFTHOLE,true);
		setHoleOpen(RIGHTHOLE,true);		
	}
	
	function getHoles() : Number
	{
		return _holes; 
	}
	
	// update Positionen der Löcher
	private function updatePositions() : Void
	{
		var pos = {x:_leftHoleMC._x,y:_leftHoleMC._y};
		this.localToGlobal(pos);		
		_leftHolePos = new Point(pos.x,pos.y);
		
		var pos = {x:_rightHoleMC._x,y:_rightHoleMC._y};
		this.localToGlobal(pos);
		_rightHolePos = new Point(pos.x,pos.y);
	}
	
	// true:Loch auf, false:Loch zu
	function setHoleOpen(hole:Number,open:Boolean) : Void
	{
		var l:Boolean = _leftHoleOpen;
		var r:Boolean = _rightHoleOpen;
		
		switch (hole)
		{
			case LEFTHOLE:
				_leftHoleOpen = open;			
				break;

			case RIGHTHOLE:
				_rightHoleOpen = open;
				break;
		}
		
		if (_leftHoleOpen && (!l)) _latteLeft.gotoAndPlay("open");
		if (!_leftHoleOpen && l) _latteLeft.gotoAndPlay("close");
		
		if (_rightHoleOpen && (!r)) _latteRight.gotoAndPlay("open");
		if (!_rightHoleOpen && r) _latteRight.gotoAndPlay("close");
	}
	
	// Torloch offen?
	function isHoleOpen(hole:Number) : Boolean
	{
		switch (hole)
		{
			case LEFTHOLE:
				return _leftHoleOpen;
				break;

			case RIGHTHOLE:
				return _rightHoleOpen;
				break;
		}
	}
	
	// Position an Loch einrasten
	function snapToHole(p:Point) : Point 
	{
		var d:Number,dx:Number,dy:Number;		
		
		dx = p.x - _leftHolePos.x;
		dy = p.y - _leftHolePos.y;
		d = Math.sqrt(dx*dx + dy*dy);
	
		if (d<SNAP_DISTANCE) 
		{
			return _leftHolePos.clone();
		}
		
		dx = p.x - _rightHolePos.x;
		dy = p.y - _rightHolePos.y;
		d = Math.sqrt(dx*dx + dy*dy);
		
		if (d<SNAP_DISTANCE) 
		{
			return _rightHolePos.clone();
		}
		
		return p;
	}
	
	function hitTest(p:Point) : Boolean
	{
		return (	(p.x>_topLeft.x) 
				 && (p.y>_topLeft.y) 
				 &&	(p.x<_bottomRight.x) 
				 &&	(p.y<_bottomRight.y));
	}
	
	function getBottom() : Number
	{
		return _bottomRight.y;
	}
	
	// Treffer in linkes Tor?
	function willHitLeftGoal(p:Point) : Boolean
	{
		var dx:Number = Math.abs(p.x-_leftHolePos.x);
		var dy:Number = Math.abs(p.y-_leftHolePos.y);
		
		if (_leftHoleOpen && (dx<2) && (dy<2)) return true;
		
		return false;
	}
	
	// Treffer in rechtes Tor?
	function willHitRightGoal(p:Point) : Boolean
	{
		var dx:Number = Math.abs(p.x-_rightHolePos.x);
		var dy:Number = Math.abs(p.y-_rightHolePos.y);
		
		if (_rightHoleOpen && (dx<2) && (dy<2)) return true;
		
		return false;
	}
	
	// wird vernageltes Loch treffen?
	function willHitClosed(p:Point) : Boolean
	{
		var dx:Number = Math.abs(p.x-_leftHolePos.x);
		var dy:Number = Math.abs(p.y-_leftHolePos.y);
		
		if ((!_leftHoleOpen) && (dx<2) && (dy<2)) return true;
		
		dx = Math.abs(p.x-_rightHolePos.x);
		dy = Math.abs(p.y-_rightHolePos.y);
		
		if ((!_rightHoleOpen) && (dx<2) && (dy<2)) return true;
		
		return false;
	}

	// c'tor
	function Torwand()
	{
		_leftHoleOpen = true;
		_rightHoleOpen = true;
		
		_topLeft = new Point(this._x,this._y);
		
		_bottomRight = new Point(this._x+_width,this._y+_height);
		
		setHoles(Torwand.HOLES_UNTEN_OBEN);
		trace([_topLeft,_bottomRight]);
	}
};

