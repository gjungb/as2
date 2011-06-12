import mx.utils.Delegate;
import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.ea.bat.ui.SnapSlider extends MovieClip
{
	// 'Snap' Buttons
	private var snapInBtn:MovieClip;
	private var snapOutBtn:MovieClip;
	private var noBtn:MovieClip;

	// MCs
	private var slider:MovieClip; 
	private var thumb:MovieClip;
	private var scrollBar:MovieClip;
	private var tfValue:TextField;

	// Flags
	private var _isSnappingOut:Boolean;
	private var _isSnappingIn:Boolean;
	private var _isDragging:Boolean;
	private var _hasFocus:Boolean;	

	// Collaps Listener
	private var _collapsListener:Object;

	// Konstanten
	private var DX_COLLAPS:Number = 40;
	private var DY_COLLAPS:Number = 20;

	private var THUMB_X0:Number = 7;
	private var THUMB_X1:Number = 121;

	private var THUMB_XCENTER:Number = 8;
	private var THUMB_Y:Number = 6;

	// Enum
	private var _state:Number;
	private var SNAPPEDIN:Number = -1;
	private var SNAPPEDOUT:Number = 1;
	private var SNAPPING:Number = 0;

	// Interval
	private var outsideIvID:Number;	
	
	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------

	private var _value:Number;	// aktueller Wert	
	private var _min:Number;	// Maximalwert
	private var _max:Number;	// Minimalwert

	// -------------------------------------------------------------------

	// Konstruktor
	function SnapSlider()
	{
		_event = new EventBroadcaster();

		snapInBtn.useHandCursor = snapOutBtn.useHandCursor = false;		
		
		snapInBtn._visible = true;
		snapOutBtn._visible = false;
		noBtn._visible = false;

		_isSnappingIn = false;

		var ref = this;
		_collapsListener = {
								onMouseDown:function(){ref.onMouseDownOutside();},
								onMouseMove:function(){ref.onMouseMoveOutside();}
							};

		scrollBar = slider["barBtn"];
		scrollBar.useHandCursor = false;

		scrollBar.onPress = function() {ref.onScrollBarDown()};
		scrollBar.onRelease = function() {ref.onScrollBarUp()};
		scrollBar.onReleaseOutside = function() {ref.onScrollBarOut()};		

		thumb = slider["thumb"];
		thumb.useHandCursor = false;
		thumb.onPress = function() {ref.onThumbDown();};
		thumb.onRelease = thumb.onReleaseOutside = function() {ref.onThumbUp();};

		slider["back"].onPress = null;
		slider["back"].useHandCursor = false;

		tfValue.restrict = "0-9.,";
		tfValue.onKillFocus = Delegate.create(this,onKillFocus);
		tfValue.onSetFocus = Delegate.create(this,onSetFocus);

		_isDragging = false;
		_hasFocus = false;

		outsideIvID = -1;

		_state = SNAPPEDOUT;

		// ----------------

		init();
	}

	function init() : Void
	{
		minimum = 1;
		maximum = 15;
		value = 6;
	}

	function updateView() : Void
	{
		thumb._x = Math.round(THUMB_X0 + (THUMB_X1 - THUMB_X0) * (_value - _min) / (_max - _min));

		var str:String = value.toString();
		var digits:Array = str.split(".");
		if (digits.length>1)
		{
			tfValue.text = digits.join(",");
		} 
		else 
		{
			tfValue.text = digits[0]+",0";
		}
	}

	function onValueChanged() : Void
	{
		_event.send("onValueChanged",this,value);
	}

	// -------------------------------------------------------------------
	
	function set value(val:Number) : Void
	{
		_value = Math.max(Math.min(Math.round(val*10)/10,_max),_min); 		
		updateView();
	}
	
	function get value() : Number { return Math.round(10*_value)/10; }
	
	function set minimum(val:Number) : Void
	{
		_min = val;
		if (_min>_max) _max = _min;
		if (_value<_min) _value = _min;

		updateView();
	}
	
	function get minimum() : Number { return Math.round(10*_min)/10; }
		
	function set maximum(val:Number) : Void
	{
		_max = val;
		if (_max<_min) _min = _max;
		if (_value>_max) _value = _max;
		
		updateView();
	}
	
	function get maximum() : Number { return Math.round(10*_max)/10; }

	// -------------------------------------------------------------------

	function isOverScrollbar() : Boolean
	{
		var over:Boolean = (slider._xmouse>=(THUMB_X0-8)) && (slider._xmouse<=(THUMB_X1+8)) && (Math.abs(slider._ymouse-THUMB_Y)<6);
		over = slider.hitTest(_root._xmouse,_root._ymouse);
		return over;
	}

	function onScrollBarDown() : Void
	{		
		if (_isSnappingIn || _isSnappingOut) return;

		onEnterFrame = onEnterFrame_ScrollBar;
	}

	function onScrollBarUp() : Void
	{
		delete onEnterFrame;
		if (_isSnappingIn || _isSnappingOut) return;

		if (_isDragging) onThumbUp();

		onValueChanged();
	}

	function onScrollBarOut() : Void
	{
		delete onEnterFrame;
		if (_isSnappingIn || _isSnappingOut) return;

		_isDragging = true;
		onThumbUp();

		onValueChanged();
	}

	function onEnterFrame_ScrollBar() : Void
	{
		var xm:Number = Math.max(Math.min(slider._xmouse-THUMB_XCENTER,THUMB_X1),THUMB_X0);
		var x:Number = Math.round(thumb._x*0.4+xm*0.6);

		var dx:Number = x-thumb._x;
		var sgn:Number = dx<0 ? -1 : 1;

		if (Math.abs(xm-x)<=8)
		{
			delete onEnterFrame;
			onThumbDown();
			return;
		}

		dx = dx*sgn;
		dx = dx<6 ? 6 : (dx>15 ? 15 : dx);
		thumb._x += sgn*dx;

		onEnterFrame_Dragging();
	}
	
	// -------------------------------------------------------------------

	function onThumbDown() : Void
	{
		if (_isSnappingIn || _isSnappingOut) return;

		_isDragging = true;
		thumb._x = slider._xmouse-THUMB_XCENTER;
		thumb.startDrag(false,THUMB_X0,thumb._y,THUMB_X1,thumb._y);

		onEnterFrame = onEnterFrame_Dragging;
	}

	function onThumbUp() : Void
	{
		if (_isSnappingIn || _isSnappingOut) return;
		if (!_isDragging) return;
		
		if (!isOverScrollbar())
		{
			snapOut();
		} 
		else 
		{
			stopDrag();
		}

		onValueChanged();
	}

	function stopDrag() : Void
	{
		delete onEnterFrame;

		thumb.stopDrag();
		_isDragging = false;
	}

	function onEnterFrame_Dragging() : Void
	{
		var n:Number = (thumb._x-THUMB_X0) / (THUMB_X1-THUMB_X0);
		value = _min + (_max-_min) * n;
	}

	// -------------------------------------------------------------------

	function onMouseDownOutside() : Void
	{		
		if (_hasFocus) 
		{
			stopWait();
			return;
		}

		if (!this.hitTest(_root._xmouse,_root._ymouse,true)) 
		{
			this.snapOut();
		}
	}

	function onMouseMoveOutside() : Void
	{
		if (_hasFocus) 
		{
			stopWait();
			return;
		}

		var bounds:Object = this.getBounds();
		if (   (_xmouse<(bounds.xMin-DX_COLLAPS))||(_xmouse>(bounds.xMax+DX_COLLAPS))
			|| (_ymouse<(bounds.yMin-DY_COLLAPS))||(_ymouse>(bounds.yMax+DY_COLLAPS)))
		{
			// snapOut();
			wait();
		} 
		else 
		{
			stopWait();
		}
	}

	// -------------------------------------------------------------------

	function stopWait() : Void
	{
		if (outsideIvID>-1) clearInterval(outsideIvID);
		outsideIvID = -1;
	}

	function wait() : Void
	{
		if (outsideIvID==-1) outsideIvID = setInterval(this,"onOutsideInterval",2000);
	}

	function onOutsideInterval() : Void
	{
		clearInterval();			
		snapOut();
	}

	// -------------------------------------------------------------------
	
	function onSetFocus(tf:TextField) : Void
	{
		snapIn();

		// Key.addListener(this);		
		var str:String = value.toString().split(".").join(",");
		if (str.indexOf(",")==-1) str = str+",0";

		tfValue.text = str;
		_hasFocus = true;
	}
	
	function onKillFocus(tf:TextField) : Void
	{
		// Key.removeListener(this);
		parseValueFromText();
		
		updateView();
		_hasFocus = false;
		
		if ( (!_isSnappingIn) && (!slider.hitTest(_root._xmouse,_root._ymouse)) ) snapOut();

		onValueChanged();
	}
	
	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER))
		{
			parseValueFromText();
			updateView();

			onValueChanged();
			return;
		}

		if (Key.isDown(Key.ESCAPE))
		{
			parseValueFromText();
			updateView();

			onValueChanged();
			snapOut();
			return;
		}
	}

	function parseValueFromText() : Void
	{	
		var str:String = tfValue.text.split(",").join(".");
		var n:Number = parseFloat(str);
		if (isNaN(n)) return;

		value = n;
	}

	// -------------------------------------------------------------------

	function onIn() : Void
	{
		noBtn._visible = false;
		snapInBtn._visible = false;
		snapOutBtn._visible = true;

		Mouse.addListener(_collapsListener);

		_isSnappingOut = false;
		_isSnappingIn = false;

		_state = SNAPPEDIN;
	}

	function onOut() : Void
	{
		noBtn._visible = false;
		snapInBtn._visible = true;
		snapOutBtn._visible = false;

		//_isSnappingOut = false;
		_isSnappingIn = false;

		_state = SNAPPEDOUT;
	}

	function snapIn() : Void
	{		
		if (_isSnappingIn || (_state==SNAPPEDIN)) return;

		_isSnappingIn = true;
		_isSnappingOut = false;
		_state = SNAPPING;

		stopDrag();
		stopWait();

		noBtn._visible = true;
		snapInBtn._visible = false;
		snapOutBtn._visible = false;
		
		Key.addListener(this);
		Mouse.removeListener(_collapsListener);

		this.gotoAndPlay("in");

		updateView();
	}

	function snapOut() : Void
	{
		if (_isSnappingOut || (_state==SNAPPEDOUT)) return;

		stopDrag();
		stopWait();

		_isSnappingOut = true;
		_isSnappingIn = false;
		_state = SNAPPING;

		noBtn._visible = true;
		snapInBtn._visible = false;
		snapOutBtn._visible = false;

		Mouse.removeListener(_collapsListener);
		Key.removeListener(this);

		this.gotoAndPlay("out");		
		updateView();
	}
};