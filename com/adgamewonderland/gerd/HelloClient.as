import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.gerd.HelloBean;

import mx.services.Log;
import mx.services.PendingCall;
import mx.services.WebService;
import mx.utils.Delegate;

class com.adgamewonderland.gerd.HelloClient {

	var ws : WebService;
	
	var log : Log;

	public function HelloClient() {
		
		this.log = new Log(Log.DEBUG, "HelloLog");
		
		this.log.onLog = function (message : String) : Void {
			trace(message);
		};
		
		this.ws = new WebService("http://192.168.0.199:8080/Webservice?wsdl", this.log);
	}
	
	public function sayHello(name : String) : Void {
		var pc : PendingCall = this.ws.sayHelloBean(name, new Date());
		
		pc.onResult = Delegate.create(this, onResult);
	}

	public function onResult(result : Object) : Void {
		
		var bean : HelloBean = HelloBean(RemotingBeanCaster.getCastedInstance(new HelloBean(), result));
		
		this.log.logDebug(bean);	
	}
}