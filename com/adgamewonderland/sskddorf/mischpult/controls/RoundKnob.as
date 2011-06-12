import mx.utils.Delegate;
import com.adgamewonderland.sskddorf.mischpult.controls.*;
import com.adgamewonderland.sskddorf.mischpult.utils.StringParser;

class com.adgamewonderland.sskddorf.mischpult.controls.RoundKnob extends StepperBase
{
	/* ------------------------------------------------- */

	// MCs
	private var pointer:MovieClip;
	private var thumbRotator:MovieClip;
	private var thumb:MovieClip;
	private var knobButton:Button;
	private var tfInput:TextField;

	/* ------------------------------------------------- */

	private var angle:Number;
	private var lastAngle:Number;	
	private var targetAngle:Number
	private var holdWaitInterval:Number;
	private var holding:Boolean;

	/* ------------------------------------------------- */
	
	private var _step:Number;
	private var _holdStep:Number;
		
	/* Step */
	function set step(value:Number) : Void
	{
		if (value<=0) value = 1;

		_step = value;
		
		updateView();
	}

	function get step() : Number
	{
		return _step;
	}
	
	function set holdStep(value:Number) : Void
	{
		_holdStep = value;
	}
	
	function get holdStep() : Number
	{
		return _holdStep;
	}

	/* ------------------------------------------------- */

	function setAngle(angle:Number) : Void
	{
		if (angle<0)	angle = 0;
		if (angle>270)	angle = 270;

		var a:Number = angle - 135;
		pointer._rotation = a;

		thumb._x = Math.round(19*Math.sin(a*Math.PI/180));
		thumb._y = Math.round(-18*Math.cos(a*Math.PI/180));

		this.angle = angle;		
	}

	/* ------------------------------------------------- */

	function onStartTurn() : Void
	{		
		var a:Number = (225 + Math.atan2(thumbRotator._ymouse,thumbRotator._xmouse) * 180/Math.PI) % 360;
		lastAngle = a;
		
		onEnterFrame = onEnterFrame_Turn;
	}

	function onEndTurn() : Void
	{
		delete onEnterFrame;
		onValueChanged();
	}
	
	function onOverTurn() : Void
	{
		onEndTurn();
	}
	
	function onHoldInterval(a:Number) : Void
	{
		clearInterval(holdWaitInterval);
		clearHoldInterval();
		
		onValueChanged();
	}
	
	function clearHoldInterval() : Void
	{
		if (holdWaitInterval > -1) clearInterval(holdWaitInterval);
		holdWaitInterval = -1;
	}

	function onEnterFrame_Turn2() : Void
	{
		var a:Number = calcTurnAngle();

		var da:Number = Math.abs(a - lastAngle);
		if (da>160) return;
		
		value = angleToValue(a);
		a = valueToAngle(value);
		
		setAngle(a);
		lastAngle = angle;
		
		if (Math.abs(da)<0.1) 
		{
			if (!holding)
			{
				clearHoldInterval();
				holdWaitInterval = setInterval(this,"onHoldInterval",a);
			}
			
			holding = true;
		} 
		else 
		{
			holding = false;			
			clearHoldInterval();
		}
	}

	function onEnterFrame_Turn() : Void
	{
		var a:Number = calcTurnAngle();

		var da:Number = a - angle;	
		if (Math.abs(da)<10) 
		{
			value = angleToValue(a);
			onValueChanged();
			onEnterFrame = onEnterFrame_Turn2;
		} 
		else 
		{
			var newAngle:Number = angle + (da>0 ? 5 : -5);
			value = angleToValue(newAngle);			
			setAngle(valueToAngle(value));
		}
	}
	
	/* ------------------------------------------------- */ 
	
	function onPressPlus() : Void
	{
		delete onEnterFrame;
		
		clickedBtnID = BTN_PLUS;		
		waitShortClick();		
	}
	
	function onReleasePlus() : Void
	{
		if (shortClick) 
		{
			value = (Math.round(_value/step) + 1) * step;
			setTextFieldValue(value);						
		} 
		else 
		{
			delete onEnterFrame;
		}

		stopShortClick();
		onValueChanged();
	}
	
	function onExitPlus() : Void
	{
		delete onEnterFrame;
		
		stopShortClick();
	}
	
	function onPressMinus() : Void
	{
		delete onEnterFrame;
		
		clickedBtnID = BTN_MINUS;		
		waitShortClick();		
	}
	
	function onReleaseMinus() : Void
	{
		if (shortClick) 
		{
			value = (Math.round(_value/step) - 1) * step;
			setTextFieldValue(value);			
		} 
		else 
		{
			delete onEnterFrame;
		}

		stopShortClick();
		onValueChanged();
	}
	
	function onExitMinus() : Void
	{
		delete onEnterFrame;
		stopShortClick();
	}
	
	function onShortClickOver() : Void
	{
		stopShortClick();		
		shortClick = false;		
		
		// stepCounter = 0;
		
		if (clickedBtnID==BTN_MINUS)	onEnterFrame = onEnterFrame_Dec;
		if (clickedBtnID==BTN_PLUS)		onEnterFrame = onEnterFrame_Inc;
	}
	
	function onEnterFrame_Inc() : Void
	{
		/*
		stepCounter = (stepCounter+1)%STEPTIME;
		if (stepCounter!=0) return;
		*/
		value = (Math.round(_value/_holdStep) + 1) * _holdStep;
	}
	
	function onEnterFrame_Dec() : Void
	{
		/*
		stepCounter = (stepCounter+1)%STEPTIME;
		if (stepCounter!=0) return;
		*/
		value = (Math.round(_value/_holdStep) - 1) * _holdStep;
	}
	
	/* ------------------------------------------------- */ 
	
	function calcTurnAngle() : Number
	{
		var a:Number = Math.atan2(-thumbRotator._ymouse,-thumbRotator._xmouse);
		var a2:Number = (405 + a*180/Math.PI) % 360;

		if (a2>305) 
		{
			a2 = 0;
		} 
		else 
		{
			if (a2>270) a2 = 270;
		}
		
		return a2;
	}
	
	function angleToValue(a:Number) : Number
	{
		var v:Number = _min + (_max-_min) * (a/270);
		return Math.min(Math.max(_min,v),_max);
	}
	
	function valueToAngle(v:Number) : Number
	{
		var a:Number = 270 * (v-_min)/(_max - _min);
		a = Math.min(Math.max(0,a),270);
		return a;
	}
	
	/* ------------------------------------------------- */ 
	
	function onSetFocus(t:TextField) : Void
	{
		delete onEnterFrame;
		
		tfInput.text = value.toString();
		Key.addListener(this);
	}
	
	function onKillFocus(t:TextField) : Void
	{
		setValueFromText();	
		setTextFieldValue(_value);
		
		targetAngle = valueToAngle(_value);
		onEnterFrame = onEnterFrame_TurnToValue;
		onValueChanged();
		
		Key.removeListener(this);
	}
	
	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER)) 
		{
			setValueFromText();						
			tfInput.text = _value.toString();						
			
			targetAngle = valueToAngle(_value);
			onEnterFrame = onEnterFrame_TurnToValue;
			
			onValueChanged();
		}
	}
	
	function setValueFromText() : Void
	{
		var v:Number = parseInt(tfInput.text);
		if (isNaN(v)) v = 0;
		
		_value = Math.min(Math.max(v,_start),_limit);
	}
	
	function onEnterFrame_TurnToValue() : Void
	{
		var da:Number = targetAngle - angle;
		if (Math.abs(da)<10) 
		{
			delete onEnterFrame;
			setAngle(targetAngle);
		} 
		else 
		{
			var newAngle:Number = angle + (da>0 ? 5 : -5);			
			setAngle(newAngle);
		}
	}

	/* ------------------------------------------------- */ 

	// c'tor
	function RoundKnob()
	{		
		angle = 0;
		thumb = thumbRotator.thumb;

		knobButton.useHandCursor = false;
		knobButton.onPress = Delegate.create(this,onStartTurn);
		knobButton.onRelease = knobButton.onReleaseOutside = Delegate.create(this,onEndTurn);
//		knobButton.onRollOver = Delegate.create(this,onOverTurn);
		
		tfInput.restrict = "0-9";		
		tfInput.onSetFocus =  Delegate.create(this,onSetFocus);		
		tfInput.onKillFocus = Delegate.create(this,onKillFocus);		
		
		holdWaitInterval = -1;
		holding = false;
		
		init();
	}
	
	function init() : Void
	{
		minimum = _valmin;
		maximum = _valmax;
		value = _valstart;
		step = _valstep;		
		holdStep = 10;
	}
	
	function updateView() : Void
	{
		tfInput.maxChars = Math.abs(_limit).toString().length;						
		setTextFieldValue(_value);
		
		setAngle(valueToAngle(value));
	}	
	
	function setTextFieldValue(v:Number) : Void
	{
		tfInput.text = StringParser.formatMoney(v);
	}
		
	function onValueChanged() : Void
	{
		_event.send("onValueChanged",this,value);
	}
};
