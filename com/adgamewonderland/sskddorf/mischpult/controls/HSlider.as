import mx.utils.Delegate;
import de.kruesch.event.*;
import com.adgamewonderland.sskddorf.mischpult.utils.StringParser;

class com.adgamewonderland.sskddorf.mischpult.controls.HSlider extends MovieClip
{
	// Event Handling
	private var _event:EventBroadcaster;
	
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }
	
	/* ----------------------------------------------------------- */
	
	private var thumb:MovieClip;
	private var tfInput:TextField;
	private var barBtn:Button;
	private var btnLock:MovieClip;
	
	/* ----------------------------------------------------------- */
	
	private var xMin:Number = 8;
	private var xMax:Number = 260;
	private var thumbX:Number = 14;
	private var xClick:Number;
	private var xForValue:Number;
	
	/* ---------------------------------------------------------- */
	
	private var _value:Number;	// aktueller Wert	
	private var _min:Number;	// Maximalwert
	private var _max:Number;	// Minimalwert
	
	/* Value */
	function set value(val:Number) : Void
	{
		_value = Math.max(Math.min(val,_max),_min); // Bereich eingrenzen: [_start,_limit]
		
		updateView();
	}
	
	function get value() : Number
	{
		return Math.round(_value);
	}

	/* Minimum */	
	function set minimum(value:Number) : Void
	{
		_min = value;
		if (_min>_max) _max = _min;
		if (_value<_min) _value = _min;

		updateView();
	}
	
	function get minimum() : Number
	{
		return _min;
	}
		
	/* Maximum */
	function set maximum(value:Number) : Void
	{
		_max = value;
		if (_max<_min) _min = _max;
		if (_value>_max) _value = _max;
		
		updateView();
	}
	
	function get maximum() : Number
	{
		return _max;
	}
	
	function get percent() : Number
	{
		return 100* (value-_min) / (_max-_min);
	}
	
	function set percent(p:Number) : Void
	{
		value = _min + (_max-_min) * p /100;
	}
	
	/* ----------------------------------------------------------- */
	
	function slideToValue(v:Number) : Void
	{
		_value = Math.max(Math.min(v,_max),_min);
		setTextFieldValue(_value);
		
		xForValue = valueToPos(_value);
		onEnterFrame = onEnterFrame_ToValue;
	}
	
	function slideToPercent(p:Number) : Void
	{
		slideToValue(_min + (_max-_min) * p /100);
	}
	
	/* ----------------------------------------------------------- */
	
	function moveValueBy(diff:Number ):Number
	{
		var remains:Number = Math.min(0, _value + diff);
		value = _value + diff;
		return remains;
	}
	
	/* ----------------------------------------------------------- */
	
	function onStartDrag() : Void
	{
		if (!locked && _max != _min) {
			xClick = thumb._xmouse;
			onEnterFrame = onEnterFrame_Dragging;
		}
	}
	
	function onStopDrag() : Void
	{
		delete onEnterFrame;
	}
	
	function onEnterFrame_Dragging() : Void
	{
		var xm:Number = Math.min(Math.max(this._xmouse-xClick,xMin),xMax);
		thumb._x = xm;
		
		var v:Number = _value;
		_value = posToValue(thumb._x);
		setTextFieldValue(_value);
		
		if (_value!=v) onValueChanged(Math.round(v));
	}
	/* ----------------------------------------------------------- */
	
	function onScrollbarPress() : Void
	{
		onEnterFrame = onEnterFrame_ToPos;
	}
	
	function onScrollbarRelease() : Void
	{
		delete onEnterFrame;
	}
	
	function onEnterFrame_ToPos() : Void
	{
		var xm:Number = Math.max(Math.min(_xmouse-thumbX,xMax),xMin);
				
		var x:Number = thumb._x*0.9 + xm*0.1;	
		var dx:Number = x-thumb._x;
		
		var sgn:Number = dx<0 ? -1 : 1;
		
		if (Math.abs(xm-x)<=3)
		{
			xClick = thumb._xmouse;
			onEnterFrame = onEnterFrame_Dragging;
			return;
		}
		
//		var sgn:Number = dx<0 ? -1 : 1;
		dx = dx*sgn;
		dx = dx<6 ? 6 : (dx>15 ? 15 : dx);
		thumb._x += sgn*dx;

		var v:Number = _value;
		_value = posToValue(thumb._x);
		setTextFieldValue(value);
		
		if (_value!=v) onValueChanged();
	}
	
	/* ----------------------------------------------------------- */
	
	function onSetFocus(tf:TextField) : Void
	{
		Key.addListener(this);
		
		tfInput.text = value.toString();
	}
	
	function onKillFocus(tf:TextField) : Void
	{
		Key.removeListener(this);
		
		parseValueFromText();	
		setTextFieldValue(_value);	
		
		xForValue = valueToPos(_value);		
		onEnterFrame = onEnterFrame_ToValue;
		
		onValueChanged();
	}
	
	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER))
		{
			parseValueFromText();
			tfInput.text = value.toString();
		
			xForValue = valueToPos(_value);	
			onEnterFrame = onEnterFrame_ToValue;
			
			onValueChanged();
		}
	}
	
	function onEnterFrame_ToValue() : Void
	{
		var x:Number = thumb._x*0.9 + xForValue*0.1;
		var dx:Number = x-thumb._x;
		
		var sgn:Number = dx<0 ? -1 : 1;
		if (Math.abs(xForValue-x)<=3)
		{
			thumb._x = xForValue;
			delete onEnterFrame;
			return;
		}
		
//		var sgn:Number = dx<0 ? -1 : 1;
		dx = dx*sgn;
		dx = dx<6 ? 6 : (dx>15 ? 15 : dx);
		thumb._x += sgn*dx;
	}
	
	/* ----------------------------------------------------------- */
	
	private var locked:Boolean;
	
	function lock() : Void
	{
		locked = true;
		
		// Maus drüber ? 
		if (btnLock.hitTest(_root._xmouse,_root._ymouse,true))
		{			
		}
		
		btnLock.gotoAndStop("down");
	}
	
	function unlock() : Void
	{
		locked = false;
		
		// Maus drüber ? 
		if (!btnLock.hitTest(_root._xmouse,_root._ymouse,true))
		{			
		}
		
		btnLock.gotoAndStop("up");
	}
	
	function isLocked() : Boolean
	{
		return locked;
	}
	
	function onLockBtnPress() : Void
	{
		if (locked) 
		{ 
			unlock(); 			
			_event.send("onUnlock",this);
		} 
		else 
		{ 
			lock(); 			
			_event.send("onLock",this);
		}
		
		btnLock.gotoAndStop(locked ? "down" : "up");
	}
	
	function onLockBtnOver() : Void
	{
		// btnLock.gotoAndStop(locked ? "up" : "down");
	}
	
	function onLockBtnOut() : Void
	{
		// btnLock.gotoAndStop(locked ? "down" : "up");
	}
	
	/* ----------------------------------------------------------- */
	
	// c'tor
	function HSlider()
	{
		_event = new EventBroadcaster();
		
		thumb.onPress = Delegate.create(this,onStartDrag);
		thumb.onRelease = thumb.onReleaseOutside = Delegate.create(this,onStopDrag);
		thumb.useHandCursor = false;
		
//		barBtn.onPress = Delegate.create(this,onScrollbarPress);
//		barBtn.onRelease = barBtn.onReleaseOutside = Delegate.create(this,onScrollbarRelease);
		barBtn.useHandCursor = false;
		
		tfInput.restrict = "0-9";
		tfInput.onKillFocus = Delegate.create(this,onKillFocus);
		tfInput.onSetFocus = Delegate.create(this,onSetFocus);
		
		btnLock.gotoAndStop(1);
		btnLock.onPress = Delegate.create(this,onLockBtnPress);
		btnLock.onRollOver = Delegate.create(this,onLockBtnOver);
		btnLock.onRollOut = Delegate.create(this,onLockBtnOut);
		
		init();
	}
	
	function init() : Void
	{
		minimum = 0;
		maximum = 100;
		percent = 0;
		
		updateView();
	}
		
	function onValueChanged(oldval:Number ) : Void
	{
		if (value != oldval) _event.send("onValueChanged",this,value, oldval);
	}
	
	function updateView() : Void
	{		
		tfInput.maxChars = Math.abs(_max).toString().length;						
		setTextFieldValue(_value);
		
		delete onEnterFrame;
		
		thumb._x = valueToPos(value);
	}
	
	/* ----------------------------------------------------------- */
	
	function posToValue(p:Number) : Number
	{
		var v:Number = _min + (_max-_min) * (p-xMin)/(xMax-xMin);
		
		return Math.max(Math.min(v,_max),_min);
	}
	
	function valueToPos(v:Number) : Number
	{
		if (_max == _min) return xMin;
		return xMin + (xMax-xMin) * (v-_min)/(_max-_min);
	}
	
	/* ----------------------------------------------------------- */
	
	function parseValueFromText() : Void
	{
		var v:Number = parseInt(tfInput.text);
		if (isNaN(v)) v = 0;
		
		_value = Math.min(Math.max(v,_min),_max);
	}

	function setTextFieldValue(v:Number) : Void
	{
		tfInput.text = StringParser.formatMoney(v);
	}
}

