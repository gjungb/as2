import mx.utils.Delegate;
import com.adgamewonderland.ea.bat.util.StringFormatter;
import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.ea.bat.ui.Stepper extends MovieClip
{
	// Werte
	private var _value:Number;	// aktueller Wert	
	private var _min:Number;	// Maximalwert
	private var _max:Number;	// Minimalwert		

	public var step:Number;	// Schrittweite

	// Interval
	private var WAITCLICK:Number = 500; // Wartezeit nach Click auf + / -	
	private var clickInterval:Number;
	private var shortClick:Boolean;
	private var clickedBtnID:Number;	

	// Konstanten
	private var BTN_PLUS:Number = 1;
	private var BTN_MINUS:Number = 2;

	static var FORMAT_MONEY:Number = 1;
	static var FORMAT_NUMBER:Number = 2;
	static var FORMAT_PERCENT:Number = 3;

	private var _mode:Number;	
	
	// MCs
	private var tfValue:TextField;
	private var btnPlus:MovieClip;
	private var btnMinus:MovieClip;

	// Formattierung
	private var fformat:Function;
	private var rformat:Function;

	// verhindert, dass Focus nach +,- gehandled wird
	private var _btnFlag:Boolean;

	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------

	// Konstruktor
	function Stepper()
	{
		_event = new EventBroadcaster();

		tfValue.restrict = "0-9 ";
		clickInterval = -1;

		tfValue.onSetFocus =  Delegate.create(this,onSetFocus);		
		tfValue.onKillFocus = Delegate.create(this,onKillFocus);	

		btnPlus.onPress = Delegate.create(this,onPressPlus);
		btnMinus.onPress = Delegate.create(this,onPressMinus);

		btnPlus.useHandCursor = false;
		btnMinus.useHandCursor = false;
		
		btnPlus.onRelease = btnPlus.onReleaseOutside = 
		btnMinus.onRelease = btnMinus.onReleaseOutside = Delegate.create(this,onReleaseBtn);

		init();
		updateView();

		_btnFlag = false;
	}

	function init() : Void
	{			
		/*
		minimum = 1000000;
		maximum = 10000000;
		value = 2000000;
		step = 100000;
		setFormat(FORMAT_MONEY);
		
		minimum = 50;
		maximum = 100;
		value = 80;
		step = 1;
		setFormat(FORMAT_PERCENT);		
		*/
		minimum = 0;
		maximum = 10;
		value = 0;
		step = 0;
		setFormat(FORMAT_NUMBER);		
	}

	function updateView() : Void
	{
		tfValue.text = fformat(value);
	}

	function onValueChanged() : Void
	{
		_event.send("onValueChanged",this,value);
	}

	// -------------------------------------------------------

	function parseTextValue() : Void
	{
		var str:String = tfValue.text;
		str = str.split(" ").join("");  // ohne Leerzeichen

		if (_mode!=FORMAT_NUMBER) str = str.split(".").join(""); // l�sche Punkte
		str = str.split(",").join("."); // ersetze , durch .
		
		var n:Number = parseFloat(str);
		if (isNaN(n)) return;			// nicht OK? -> ignorieren

		if (_mode==FORMAT_NUMBER) n = Math.round(n*10)/10;

		value = n;
	}

	function setFormat(type:Number) : Void
	{
		switch(type)
		{
			case FORMAT_MONEY: 
				fformat = StringFormatter.formatMoney; 
				tfValue.maxChars = 8;
				tfValue.restrict = "0-9 ";
				 _mode = FORMAT_MONEY;
				break;

			case FORMAT_PERCENT: 
				fformat = formatPercent; 
				tfValue.maxChars = 3;
				tfValue.restrict = "0-9 ";
				 _mode = FORMAT_PERCENT;
				break;

			default: 
				fformat = formatNumber; 
				tfValue.maxChars = 4;
				tfValue.restrict = "0-9,. ";
				_mode = FORMAT_NUMBER;
			break;
		}
	}

	function setTextValue() : Void
	{
		/*
		var str:String = fformat(value).toString();
		str = str.split(".").join(" ");
		str = str.split("%").join("  ");

		var txt:String = "";
		var f:Boolean = false;
		for (var i:Number=0; i<str.length; i++)
		{
			var chr:String = str.substr(i,1);
			trace(chr);
			if (chr==",") { f = true; txt+=" "; }
			txt = txt + (f ? " " : chr);
		}
		*/
		var str:String = value.toString().split(".").join(",");
		if ((_mode==FORMAT_NUMBER)&&(str.indexOf(",")==-1)) str+=",0";

		tfValue.text = str;
	}

	// -------------------------------------------------------

	function formatPercent(n:Number) : String
	{
		return Math.round(n).toString()+" %";
	}

	function formatNumber(n:Number) : String
	{
		var str:String = n.toString().split(".").join(",");
		if (str.indexOf(",")==-1) str = str+",0";

		return str;
	}

	// -------------------------------------------------------
	
	// value
	function get value() : Number			{ return _value; }
	function set value(val:Number) : Void	{ __set_value(val); }
	
	// �berschreibbar
	function __set_value(v:Number) : Void
	{
		_value = Math.min(Math.max(v,_min),_max); 		
		updateView();
	}
	
	// minimum
	function get minimum() : Number			{ return _min; }
	function set minimum(v:Number) : Void	{ __set_minimum(v); }
	
	// �berschreibbar
	function __set_minimum(v:Number) : Void
	{
		_min = v;
		if (_min>_max) _max = _min;
		if (_value<_min) _value = _min;

		updateView();
	}	
	
	// maximum
	function get maximum() : Number		{ return _max; }
	function set maximum(v:Number) : Void { __set_maximum(v); }
	
	// �berschreibbar
	private function __set_maximum(v:Number) : Void
	{
		_max = v;
		if (_max<_min) _min = _max;
		if (_value>_max) _value = _max;
		
		updateView();
	}

	// -------------------------------------------------------

	function onPressPlus() : Void
	{
		_btnFlag = true;
		clickedBtnID = BTN_PLUS;
		waitShortClick();			

		if (_mode==FORMAT_NUMBER)
		{
			var v:Number = value;
			var n:Number = value/step;
			n = Math.ceil(n);

			value = n*step;
			if (value==v) value += step;
		} 
		else 
		{
			if (value%step==0)
			{
				value += step;
			} 
			else 
			{
				value = Math.floor((value+step)/step)*step;			
			}
		}

		onValueChanged();
	}

	function onPressMinus() : Void
	{
		_btnFlag = true;
		clickedBtnID = BTN_MINUS;
		waitShortClick();	

		if (_mode==FORMAT_NUMBER)
		{
			var v:Number = value;
			var n:Number = value/step;
			n = Math.floor(n);
			value = n*step;

			if (value==v) value -= step;
		} 
		else 
		{
			if (value%step==0)
			{
				value -= step;
			} 
			else 
			{
				value = Math.floor(value/step)*step;			
			}
		}

		onValueChanged();
	}

	function onReleaseBtn() : Void
	{
		delete onEnterFrame;
		stopShortClick();

		onValueChanged();
	}

	// -------------------------------------------------------

	function onKeyDown() : Void
	{
		if (Key.isDown(Key.ENTER)) 
		{
			parseTextValue();
			setTextValue();
			onValueChanged();
		}
	}

	function onSetFocus(tf:TextField) : Void
	{
		setTextValue();
		_btnFlag = false;

		Key.addListener(this);
	}

	function onKillFocus(tf:TextField) : Void
	{			
		if (_btnFlag) return;

		parseTextValue();
		Key.removeListener(this);

		updateView();
		onValueChanged();
	}

	// -------------------------------------------------------

	function onEnterFrame_Inc() : Void
	{
		value += step;
		value = Math.round(value*10)/10;


		updateView();
	}

	function onEnterFrame_Dec() : Void
	{
		value -= step;
		value = Math.round(value*10)/10;

		updateView();
	}

	// -------------------------------------------------------

	private function waitShortClick() : Void
	{
		if (clickInterval>-1) clearInterval(clickInterval);
		clickInterval = setInterval(this,"onShortClickOver", WAITCLICK);

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

		if (clickedBtnID==BTN_PLUS) onEnterFrame = onEnterFrame_Inc;
		if (clickedBtnID==BTN_MINUS) onEnterFrame = onEnterFrame_Dec;
	}
};