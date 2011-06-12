import mx.utils.Delegate;
import com.adgamewonderland.eplus.ayyildiz.tarifrechner.*;

class com.adgamewonderland.eplus.ayyildiz.tarifrechner.InputStepper extends MovieClip
{
	private var tfInput:TextField;
	
	// Werte
	private var _value:Number;	// aktueller Wert	
	private var _min:Number;	// Maximalwert
	private var _max:Number;	// Minimalwert
	
	// Komponentendefinition
	private var _valmin;
	private var _valmax;
	private var _valstart;
	private var _valstep;

	public var step:Number;

	/* Value */
	function set value(val:Number) : Void
	{
		_value = Math.max(Math.min(val,_max),_min); // Bereich eingrenzen	
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

	// -----------------------------------------------------------
	
	private var BTN_PLUS:Number = 1;
	private var BTN_MINUS:Number = 2;
	
	private var WAITCLICK:Number = 500; // Wartezeit nach Click auf + / -
	
	private var clickInterval:Number = -1;
	private var shortClick:Boolean;
	private var clickedBtnID:Number;	
	
	private function waitShortClick() : Void
	{
		if (clickInterval>-1) clearInterval(clickInterval);
		clickInterval = setInterval(this,"onShortClickOver",WAITCLICK);

		shortClick = true;
	}

	private function stopShortClick() : Void
	{
		if (clickInterval>-1) clearInterval(clickInterval);
		clickInterval = -1;

		shortClick = false;
	}

	private function onShortClickOver() : Void
	{
		stopShortClick();

		onEnterFrame = onEnterFrame_Hold;
	}

	private function onEnterFrame_Hold() : Void
	{
		if (clickedBtnID==BTN_PLUS) value += 1;
		if (clickedBtnID==BTN_MINUS) value -= 1;
	}

	// -----------------------------------------------------------

	function onPressMinus() : Void
	{
		clickedBtnID = BTN_MINUS;

		var v:Number = Math.round(value);
		if ((v%step)==0) { value-=step; } else { value=Math.floor(value/step)*step; };

		updateView();
		waitShortClick();
	}
	
	function onReleaseMinus() : Void
	{
		delete onEnterFrame;
		stopShortClick();	

		onValueChanged();
	}	
	
	function onPressPlus() : Void
	{
		clickedBtnID = BTN_PLUS;
		
		var v:Number = Math.round(value);
		if ((v%step)==0) { value+=step; } else { value=Math.ceil(value/step)*step; };

		waitShortClick();		
	}
	
	function onReleasePlus() : Void
	{
		delete onEnterFrame;
		stopShortClick();	

		onValueChanged();
	}	
	
	// -----------------------------------------------------------
	
	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER)) setValueFromText();
	}

	function onSetFocus() : Void
	{
		Key.addListener(this);
	}

	function onKillFocus() : Void
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

		value = n;
		
		tfInput.text = value.toString();
		onValueChanged();
	}

	// -----------------------------------------------------------

	// Event Handling
	private var _event:EventBroadcaster;
	
	function addListener(o) 	{	_event.addListener(o);		}
	function removeListener(o) 	{	_event.removeListener(o);	}

	// -----------------------------------------------------------

	function updateView() : Void
	{
		tfInput.maxChars = Math.abs(_max).toString().length;						
		tfInput.text = _value.toString();
	}

	// Konstruktor
	function InputStepper()
	{
		_event = new EventBroadcaster();

		tfInput.maxChars = 2;
		
		tfInput.onSetFocus =  Delegate.create(this,onSetFocus);		
		tfInput.onKillFocus = Delegate.create(this,onKillFocus);

		init();
	}

	function init()
	{
		step = _valstep; // 5;

		minimum = _valmin; // 0; 
		maximum = _valmax; // 200;

		value = _valstart; // 30;
	}

	function onValueChanged() : Void
	{
		_event.send("onValueChanged",this,_value);
	}
}