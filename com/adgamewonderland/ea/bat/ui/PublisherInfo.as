import mx.utils.Delegate;

import de.kruesch.event.EventBroadcaster;
import com.adgamewonderland.ea.bat.util.StringFormatter;

class com.adgamewonderland.ea.bat.ui.PublisherInfo extends MovieClip
{
	private var tfName:TextField;
	private var tfTotal:TextField;
	private var btnClose:Button;

	// -------------------------------------------------------------------

	function set publisher(s:String) : Void			{ tfName.text = s; }
	function set monthlyData(a:Array) : Void	
	{  
		var total:Number = 0;
		for (var i:Number=0; i<12; i++)
		{
			var tf:TextField = this["tfMonth_"+i];
			tf.text = StringFormatter.formatMoney(a[i]);
			total += a[i];
		}

		tfTotal.text = StringFormatter.formatMoney(total);
	}
	
	// -------------------------------------------------------------------

	// Event
	private static var _event:EventBroadcaster = new EventBroadcaster(); // HACK, global
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------

	// Konstruktor
	function PublisherInfo()
	{
		btnClose.useHandCursor = false;
		btnClose.onPress = Delegate.create(this,onClose);
	}

	function onClose() : Void
	{
		_event.send("onClosePublisherInfo",this);
	}
}
