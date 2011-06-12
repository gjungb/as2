import mx.utils.Delegate;
import com.adgamewonderland.ea.bat.ui.*;
import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.ea.bat.ui.DataTable extends MovieClip
{
	private var LINKAGEID_ROW:String = "DataRow";
	private var LINEHEIGHT:Number = 25;
	private var OFFS_X:Number = 15;
	private var OFFS_Y:Number = 4;

	private var _rows:Array;

	// -------------------------------------------------------------------

	function addRow(index:Number) : DataRow
	{
		var name:String = "_row_" + index;
		this.attachMovie(LINKAGEID_ROW, name, index+10, {_x:OFFS_X, _y: LINEHEIGHT * index + OFFS_Y } );
		var mc:DataRow = this[name];

		_rows[index] = mc;
		mc.addListener(this);

		return mc;
	}	

	function getRow(index:Number) : DataRow
	{
		return _rows[index];
	}

	function clear() : Void
	{
		for (var name in this)
		{
			if (name.substr(0,5)=="_row_") this[name].removeMovieClip();
		}
	}

	function get count() : Number
	{
		return _rows.length;
	}

	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------

	function DataTable()
	{
		_rows = [];
		_event = new EventBroadcaster();
	}

	// Bubble up
	function onValueChanged(sender:Object) : Void
	{
		var row = sender;
		_event.send("onValueChanged",this);
	}

	function onPressPublisher(sender:DataRow) : Void
	{
		var index:Number = parseInt(sender._name.substr(5,sender._name.length-5));
		if (isNaN(index)) return;

		_event.send("onClickPublisherInfo",this,index);
	}
}
