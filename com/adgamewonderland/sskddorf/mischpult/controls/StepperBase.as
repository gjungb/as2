import mx.utils.Delegate;
import de.kruesch.event.*;

// Basisklasse fuer RoundKnob und Dial
class com.adgamewonderland.sskddorf.mischpult.controls.StepperBase extends MovieClip
{
	// Event Handling
	private var _event:EventBroadcaster;
	
	function addListener(o) 	{	_event.addListener(o);		}
	function removeListener(o) 	{	_event.removeListener(o);	}
	
	/* ---------------------------------------------------------- */
	
	// Komponentendefinition
	private var _valmin;
	private var _valmax;
	private var _valstart;
	private var _valstep;
	
	private var _value:Number;	// aktueller Wert
	
	private var _min:Number;	// Maximalwert
	private var _max:Number;	// Minimalwert
	
	private var _limit:Number;	// aktuell m�glicher Maximalwert (<= Maximalwert)
	private var _start:Number;	// aktuell m�glicher Startwert (>= Minimalwert)
	
	/* Value */
	function set value(val:Number) : Void
	{
		_value = Math.max(Math.min(val,_limit),_start); // Bereich eingrenzen: [_start,_limit]
		
		updateView();
	}
	
	function get value() : Number
	{
		return Math.round(_value);
	}

	/* Minimum */	
	function set minimum(value:Number) : Void
	{
		_min = Math.max(0, value);
		if (_min>_max) maximum = _min; // _max
		
		_start = _min;
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
		__set_maximum(value);
	}
	
	private function __set_maximum(value:Number) : Void
	{
		_max = value;
		if (_max<_min) minimum = _max; // _min
		
		_limit = _max;
		if (_value>_max) _value = _max;
		
		updateView();
	}
	
	function get maximum() : Number
	{
		return _max;
	}
	
	/* Limit */
	function set limit(value:Number) : Void
	{
		_limit = Math.max(Math.min(value,_max),_min); // Bereich eingrenzen [_min,_max]
		if (_value>_limit) _value = _limit;

		updateView();
	}
	
	function get limit() : Number
	{
		return _limit;
	}
	
	/* startValue */
	function set startValue(value:Number) : Void
	{
		_start = Math.max(Math.min(value,_max),_min); // Bereich eingrenzen [_min,_max]
		if (_value<_start) _value = _start;

		updateView();
	}
	
	function get startValue() : Number
	{
		return _start;
	}
	
	/* ---------------------------------------------------------- */
	
	private var BTN_PLUS:Number = 1;
	private var BTN_MINUS:Number = 2;
	
	private var WAITCLICK:Number = 500; // Wartezeit nach Click auf + / -
	
	private var clickInterval:Number;
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
	
	// abstract
	private function onShortClickOver() : Void
	{
		stopShortClick();
		shortClick = false;
	}
	
	/* ---------------------------------------------------------- */
	
	// abstract
	function updateView() : Void {}
	
	function StepperBase()
	{
		_event = new EventBroadcaster();
	}
};