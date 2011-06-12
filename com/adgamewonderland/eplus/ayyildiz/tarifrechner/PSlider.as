import mx.utils.Delegate;
import com.adgamewonderland.eplus.ayyildiz.tarifrechner.*;

class com.adgamewonderland.eplus.ayyildiz.tarifrechner.PSlider extends MovieClip
{
	// Event Handling
	private var _event:EventBroadcaster;
	
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }
	
	/* ----------------------------------------------------------- */
	
	private var thumb:MovieClip;
	private var tfInputA:TextField;
	private var tfInputB:TextField;
	private var barBtn:Button;
	private var btnLock:MovieClip;
	
	/* ----------------------------------------------------------- */
	
	private var xMin:Number = 59;
	private var xMax:Number = 258;
	private var thumbX:Number = 15;
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
		setTextFieldValues(_value);
		
		xForValue = valueToPos(_value);
		onEnterFrame = onEnterFrame_ToValue;
	}
	
	function slideToPercent(p:Number) : Void
	{
		slideToValue(_min + (_max-_min) * p /100);
	}
	
	/* ----------------------------------------------------------- */
	
	function onStartDrag() : Void
	{
		xClick = thumb._xmouse;
		onEnterFrame = onEnterFrame_Dragging;
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
		setTextFieldValues(_value);
		
		if (_value!=v) onValueChanged();
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
		
		var sgn:Number = dx<0 ? -1 : 1;
		dx = dx*sgn;
		dx = dx<6 ? 6 : (dx>15 ? 15 : dx);
		thumb._x += sgn*dx;

		var v:Number = _value;
		_value = posToValue(thumb._x);
		setTextFieldValues(value);
		
		if (_value!=v) onValueChanged();
	}
	
	/* ----------------------------------------------------------- */
	
	function onSetFocus(tf:TextField) : Void
	{
		Key.addListener(this);
		
		if (tf==tfInputA) tf.text = (100-value).toString();
		if (tf==tfInputB) tf.text = value.toString();
	}
	
	function onKillFocus(tf:TextField) : Void
	{
		Key.removeListener(this);
		
		parseValueFromText(tf);	
		setTextFieldValues(_value);	
		
		xForValue = valueToPos(_value);		
		onEnterFrame = onEnterFrame_ToValue;
		
		onValueChanged();
	}
	
	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER))
		{
			var tfFocused:TextField = null;
			if (tfInputA.text.indexOf("%")==-1) 
			{
			    tfFocused = tfInputA;
				parseValueFromText(tfInputA);
			}

			if (tfInputB.text.indexOf("%")==-1) 
			{
				tfFocused = tfInputB;
				parseValueFromText(tfInputB);
			}
			setTextFieldValues(_value);
						
			xForValue = valueToPos(_value);	
			onEnterFrame = onEnterFrame_ToValue;

			if (tfFocused==tfInputA) tfInputA.text = (100-_value).toString();
			if (tfFocused==tfInputB) tfInputB.text =_value.toString();
			
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
		
		var sgn:Number = dx<0 ? -1 : 1;
		dx = dx*sgn;
		dx = dx<6 ? 6 : (dx>15 ? 15 : dx);
		thumb._x += sgn*dx;
	}
	
	/* ----------------------------------------------------------- */
	
	// c'tor
	function PSlider()
	{
		_event = new EventBroadcaster();
		
		thumb.onPress = Delegate.create(this,onStartDrag);
		thumb.onRelease = thumb.onReleaseOutside = Delegate.create(this,onStopDrag);
		thumb.useHandCursor = false;
		
		barBtn.onPress = Delegate.create(this,onScrollbarPress);
		barBtn.onRelease = barBtn.onReleaseOutside = Delegate.create(this,onScrollbarRelease);
		barBtn.useHandCursor = false;
		
		var ref = this;
		tfInputA.restrict = "0-9";
		tfInputA.onKillFocus = function() { ref.onKillFocus(ref.tfInputA);  };
		tfInputA.onSetFocus = function() { ref.onSetFocus(ref.tfInputA);  };

		tfInputB.restrict = "0-9";
		tfInputB.onKillFocus = function() { ref.onKillFocus(ref.tfInputB);  };
		tfInputB.onSetFocus = function() { ref.onSetFocus(ref.tfInputB);  };

		init();
	}
	
	function init() : Void
	{
		minimum = 0;
		maximum = 100;
		percent = 50;
		
		updateView();
	}
		
	function onValueChanged() : Void
	{
		_event.send("onValueChanged",this,value,100-value);
	}
	
	function updateView() : Void
	{		
		tfInputA.maxChars = Math.abs(_max).toString().length;						
		tfInputB.maxChars = Math.abs(_max).toString().length;	
		setTextFieldValues(_value);
		
		delete onEnterFrame;
		
		thumb._x = valueToPos(value);
	}
	
	/* ----------------------------------------------------------- */
	
	function posToValue(p:Number) : Number
	{
		var v:Number = Math.round(_min + (_max-_min) * (p-xMin)/(xMax-xMin));
		
		return Math.max(Math.min(v,_max),_min);
	}
	
	function valueToPos(v:Number) : Number
	{
		return Math.round(xMin + (xMax-xMin) * (v-_min)/(_max-_min));
	}
	
	/* ----------------------------------------------------------- */
	
	function parseValueFromText(tf:TextField) : Void
	{
		var v:Number = parseInt(tf.text);
		if (isNaN(v)) v = _value;
		
		if (tf==tfInputA) v = 100-v;

		_value = Math.min(Math.max(v,_min),_max);
	}

	function setTextFieldValues(v:Number) : Void
	{
		tfInputA.text = (100-v) + "%";
		tfInputB.text = v + "%";
	}
}

