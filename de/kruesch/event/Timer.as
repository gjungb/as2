class de.kruesch.event.Timer
{	
	private var _id:Number;
	private var _callback:Function;
	
	function onInterval() : Void
	{
		_callback();
		_global.clearInterval(_id);
	}
	
	function abort() : Void
	{
		_callback = null;
		_global.clearInterval(_id);
	}
	
	function Timer(time:Number,cb:Function)
	{
		_id = _global.setInterval(this,"onInterval",time);
		_callback = cb;
	}
}
