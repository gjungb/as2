/**
 * @author gerd
 */
 
import mx.data.components.RemotingConnector;
import mx.utils.Delegate;
 
class com.adgamewonderland.agw.net.RemotingTestclient extends MovieClip {
	
	private var conn_rc:RemotingConnector;
	
	private var arg1_txt:TextField;
	
	private var send_btn:Button;
	
	public function RemotingTestclient() {
		
	}
	
	public function onLoad():Void
	{
		
		conn_rc.addEventListener("send", onRemotingSend);
		
		conn_rc.addEventListener("status", onRemotingStatus);
		
		conn_rc.addEventListener("result", onRemotingResult);

		send_btn.onRelease = Delegate.create(this, sendRemoting);
	}
	
	public function sendRemoting () {
		conn_rc.params = {arg1 : arg1_txt.text};
		conn_rc.trigger();
	}
	
	
	public function onRemotingSend(stat:Object )
	{
		trace("onRemotingSend - ");
		for (var i in stat) trace(i + ": " + stat[i]);
	}
	
	public function onRemotingStatus(stat:Object )
	{
		trace("onRemotingStatus - " + stat.code + " -  " + stat.data.faultstring);
	}
	
	public function onRemotingResult(event:Object )
	{
		trace("onRemotingResult - ");
		for (var i in event.target) trace(i + ": " + event.target[i]);
		var results:Object = event.target.results;
		for (var i in results) trace(i + ": " + results[i]);
	}
}