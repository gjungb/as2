import mx.utils.Delegate;
import de.kruesch.event.*;
import com.adgamewonderland.sskddorf.mischpult.controls.*;

class com.adgamewonderland.sskddorf.mischpult.controls.Dial extends StepperBase
{
	private var tfInput:TextField;
	private var wheel:MovieClip;
	private var wheelTop:MovieClip;

	/* ----------------------------------------------------------- */

	private var DRAGLENGTH:Number = 180;	
	
	private var wheelValue:Number;		// Drehung: 0..1
	private var newWheel:Number;
	private var oldValue:Number;
	
	private var oldWheelValue:Number;	
	private var clickX:Number;				
		
	/* ----------------------------------------------------------- */
	
	private function updateView() : Void
	{
		tfInput.maxChars = Math.abs(_limit).toString().length;						
		tfInput.text = _value.toString();
		wheelValue = valueToWheelValue(_value);
	}	

	private function updateWheel() : Void
	{
		var xm:Number = wheelValue*60;
		wheel._x = 30 - xm % 3;
	}

	private function clampWheel(w:Number) : Number
	{
		var d:Number = _max-_min;		
		var n0:Number = (_start-_min)/d;
		var n1:Number = (_limit-_min)/d;

		return Math.max(Math.min(w,n1),n0);
	}

	private function wheelValueToValue(w:Number) : Number
	{
		return Math.round(_min + (_max-_min) * w );
	}

	private function valueToWheelValue(v:Number) : Number
	{
		return (v-_min) / (_max-_min);
	}
	
	/* ----------------------------------------------------------- */
	
	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER)) 
		{
			setValueFromText();
		}
	}

	function onSetFocus(tf:TextField) : Void
	{
		Key.addListener(this);
	}

	function onKillFocus(tf:TextField) : Void
	{			
		setValueFromText();

		Key.removeListener(this);
	}

	function setValueFromText() : Void
	{
		var str:String = tfInput.text;		
		if (str=="") 
		{
			tfInput.text = _value.toString();
			return;
		}	

		var n:Number = parseInt(tfInput.text);
		if (isNaN(n)) 
		{
			tfInput.text = _value.toString();
			return;
		}

		var w:Number = wheelValue;

		var v:Number = _value;
		value = Math.max(Math.min(n,_limit),_start);
		
		tfInput.text = value.toString();
		if (v!=value) onValueChanged();

		wheelValue = w;
		newWheel = valueToWheelValue(value);
		onEnterFrame = onEnterFrame_Adjust;		
	}

	/* ----------------------------------------------------------- */

	private function onShortClickOver() : Void
	{
		stopShortClick();

		if (clickedBtnID==BTN_MINUS)	onEnterFrame = onEnterFrame_Dec;
		if (clickedBtnID==BTN_PLUS)		onEnterFrame = onEnterFrame_Inc;
	}

	/* ----------------------------------------------------------- */
	
	function onPressMinus() : Void
	{
		clickedBtnID = BTN_MINUS;
		oldValue = _value;

		waitShortClick();		
	}
	
	function onReleaseMinus() : Void
	{
		if (shortClick) 
		{
			var w:Number = wheelValue;
			value --;
			tfInput.text = value.toString();

			wheelValue = w;
			newWheel = valueToWheelValue(value);
			onEnterFrame = onEnterFrame_Adjust;		
		} 
		else 
		{
			delete onEnterFrame;
		}

		stopShortClick();	

		if (_value != oldValue) onValueChanged();
	}	
	
	function onExitMinus() : Void
	{
		stopShortClick();
	}
	
	function onPressPlus() : Void
	{
		clickedBtnID = BTN_PLUS;
		waitShortClick();		
	}
	
	function onReleasePlus() : Void
	{
		if (shortClick) 
		{
			var w:Number = wheelValue;
			value ++;
			tfInput.text = value.toString();

			wheelValue = w;
			newWheel = valueToWheelValue(value);
			onEnterFrame = onEnterFrame_Adjust;		
		} 
		else 
		{
			delete onEnterFrame;
		}

		stopShortClick();

		if (_value!=oldValue) onValueChanged();
	}	
	
	function onExitPlus() : Void
	{
		stopShortClick();
	}

	/* ----------------------------------------------------------- */
	
	function onStartDragWheelTop() : Void
	{
		clickX = _xmouse;
		oldWheelValue = wheelValue;
		oldValue = _value;

		onEnterFrame = onEnterFrame_Wheel;
	}
	
	function onEndDragWheelTop() : Void
	{
		delete onEnterFrame;

		if (_value!=oldValue) onValueChanged();
	}

	/* ----------------------------------------------------------- */
	
	function onEnterFrame_Wheel() : Void
	{
		wheelValue = clampWheel(oldWheelValue + (_xmouse-clickX) / DRAGLENGTH);
		
		_value = wheelValueToValue(wheelValue);
		tfInput.text = value.toString();

		updateWheel();
	}

	function onEnterFrame_Inc() : Void
	{
		wheelValue = clampWheel(wheelValue + 0.01);

		_value = wheelValueToValue( wheelValue );		
		tfInput.text = _value.toString();

		updateWheel();
	}

	function onEnterFrame_Dec() : Void
	{
		wheelValue = clampWheel(wheelValue - 0.01);

		_value = wheelValueToValue( wheelValue );
		tfInput.text = _value.toString();

		updateWheel();
	}

	function onEnterFrame_Adjust() : Void
	{
		var d:Number = (newWheel - wheelValue);

		if ((d>=-0.1)&&(d<=0.1))
		{			
			wheelValue = newWheel;
			updateWheel();
			delete onEnterFrame;
			return;
		}

		if (d<0) wheelValue -= 0.01;
		if (d>0) wheelValue += 0.01;

		updateWheel();
	}
	
	/* ----------------------------------------------------------- */
	
	// c'tor
	function Dial()
	{				
		_event = new EventBroadcaster();
		clickInterval = -1;

		tfInput.restrict = "0-9";
		tfInput.maxChars = 2;
		
		tfInput.onSetFocus =  Delegate.create(this,onSetFocus);		
		tfInput.onKillFocus = Delegate.create(this,onKillFocus);		
		wheelTop.onPress = Delegate.create(this,onStartDragWheelTop);		
		wheelTop.onRelease = wheelTop.onReleaseOutside = Delegate.create(this,onEndDragWheelTop);

		init();
	}

	function init() : Void
	{
		minimum = _valmin;
		maximum = _valmax;
		value = _valstart;
	}

	function onValueChanged() : Void
	{
		_event.send("onValueChanged",this,_value);
	}
}
	