import mx.utils.Delegate;

import de.kruesch.event.EventBroadcaster;
import com.adgamewonderland.ea.bat.util.StringFormatter;

class com.adgamewonderland.ea.bat.ui.UnitsInfo extends MovieClip
{
	private var tfUnits:TextField;
	private var btnClose:Button;

	// -------------------------------------------------------------------

	function set units(n:Number) : Void			{ tfUnits.text = String(n); }
	
	// -------------------------------------------------------------------

	// Event
	private static var _event:EventBroadcaster = new EventBroadcaster(); // HACK, global
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------

	// Konstruktor
	function UnitsInfo()
	{
		btnClose.useHandCursor = false;
		btnClose.onPress = Delegate.create(this,onClose);
	}

	function onClose() : Void
	{
		_event.send("onCloseUnitsInfo",this);
	}
}
