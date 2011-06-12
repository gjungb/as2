import mx.utils.Delegate;
import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.ea.bat.ui.BottomNav extends MovieClip
{
	private var btnSave:Button;
	private var btnLoad:Button;
	private var btnPrint:Button;
	private var btnReset:Button;
	private var btnUnits:Button;

	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------
	
	// Konstruktor
	function BottomNav()
	{
		_event = new EventBroadcaster();
		
		btnSave.useHandCursor = false;
		btnLoad.useHandCursor = false;
		btnPrint.useHandCursor = false;
		btnReset.useHandCursor = false;
		btnUnits.useHandCursor = false;
	}

	// -------------------------------------------------------------------

	function onLoad() : Void
	{
		btnSave.onPress		= Delegate.create(this, onPressSave);
		btnLoad.onPress		= Delegate.create(this, onPressLoad);
		btnPrint.onPress	= Delegate.create(this, onPressPrint);
		btnReset.onPress	= Delegate.create(this, onPressReset);
		btnUnits.onPress	= Delegate.create(this, onPressUnits);
	}

	function onPressSave() : Void
	{
		_event.send("onClickSave",this);
	}

	function onPressLoad() : Void
	{
		_event.send("onClickLoad",this);
	}

	function onPressPrint() : Void
	{
		_event.send("onClickPrint",this);
	}

	function onPressReset() : Void
	{
		_event.send("onClickReset",this);
	}

	function onPressUnits() : Void
	{
		_event.send("onClickUnitsInfo",this);
	}
}
