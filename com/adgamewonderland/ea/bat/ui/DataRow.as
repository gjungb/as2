import mx.utils.Delegate;

import de.kruesch.event.EventBroadcaster;
import com.adgamewonderland.ea.bat.ui.*;
import com.adgamewonderland.ea.bat.util.StringFormatter;

class com.adgamewonderland.ea.bat.ui.DataRow extends MovieClip
{
	private var tfNo:TextField;
	private var tfPublisher:TextField;
	private var tfRevenue:TextField;
	private var tfStockValue:TextField;
	private var tfReach:TextField;
	private var tfResult:TextField;
	private var slider:SnapSlider;
	private var btnInfo:Button;

	function set no(n:Number) : Void { slider.tabIndex = n; tfNo.text = n.toString(); };
	function get no():Number {return Number(tfNo.text); };

	function set publisher(p:String) : Void { tfPublisher.text = p; };

	function set revenue(r:Number) : Void { tfRevenue.text = StringFormatter.formatMoney(r); };

	function set stockValue(v:Number) : Void { tfStockValue.text = StringFormatter.formatMoney(v); };

	function set reach(r:Number) : Void 
	{ 
		var str:String = (Math.round(r*10)/10).toString();
		if (str.indexOf(".")==-1) { str = str+",0"; } else { str = str.split(".").join(","); }

		tfReach.text =  str;
	};

	function set result(r:Number) : Void { tfResult.text = StringFormatter.formatMoney(r); }

	function set stockTurn(n:Number) : Void { slider.value = n;  }
	function get stockTurn() : Number { return slider.value; }

	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------

	function DataRow()
	{
		_event = new EventBroadcaster();	
		
		slider.minimum = 1;
		slider.maximum = 15;

		btnInfo.useHandCursor = false;
		btnInfo.onPress = Delegate.create(this,onPublisherBtn);
	}

	function onLoad() : Void
	{
		slider.addListener(this);	
	}

	// -------------------------------------------------------------------
	
	// Bubble up
	function onValueChanged(sender:Object,n:Number) : Void
	{
		_event.send("onValueChanged",this);
	}

	function onPublisherBtn() : Void
	{
		_event.send("onPressPublisher",this);
	}

	// -------------------------------------------------------------------

	function toString() : String { return "[DataRow]"; }
}