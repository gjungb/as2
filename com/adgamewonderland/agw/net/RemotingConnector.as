/**
 * @author gerd
 */
 
import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

class com.adgamewonderland.agw.net.RemotingConnector {
	
	private static var _instance : RemotingConnector;
	
	private var gateway:String = "http://webbox/flashservices/gateway.php";
	
	private var remoteobject:String = "com.adgamewonderland.agw.net.RemotingConnector";
	
	private var service:Service;
	
	private var debug:Boolean = true;
	
	/**
	 * @return singleton instance of RemotingConnector
	 */
	public static function getInstance() : RemotingConnector {
		if (_instance == null)
			_instance = new RemotingConnector();
		return _instance;
	}
	
	private function RemotingConnector() {
		
	}
	
	/**
	 * generischer aufruf einer remoting-methode	 */
	 public function callMethod(caller:Object, callback:String, method:String, params:Array ):Void {
		// remote methode aufrufenroot
		var pc:PendingCall = getService()[method];
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	 }
	
	/**
	 *@return remoteobject
	 */
	public function getRemoteobject():String {
		return remoteobject;
	}

	/**
	 *@param remoteobject
	 */
	public function setRemoteobject(remoteobject:String):Void {
		this.remoteobject = remoteobject;
	}

	/**
	 *@return gateway
	 */
	public function getGateway():String {
		return gateway;
	}

	/**
	 *@param gateway
	 */
	public function setGateway(gateway:String):Void {
		this.gateway = gateway;
	}

	/**
	 *@return debug
	 */
	public function getDebug():Boolean {
		return debug;
	}

	/**
	 *@param debug
	 */
	public function setDebug(debug:Boolean):Void {
		this.debug = debug;
	}

	/**
	 *@return service
	 */
	public function getService():Service {
		// testen, ob service schon instantiiert
		if (this.service instanceof Service == false) {
			// debugger
			if (this.debug) NetDebug.initialize();
			// offline / online
			if (_url.indexOf("http://") == -1) {
				// remoting service mit url
				this.service = new Service(getGateway(), null, getRemoteobject(), null, null);
			} else {
				// remoting service ohne url
				this.service = new Service("", null, getRemoteobject(), null, null);
			}
		}
		// zurueck geben
		return this.service;
	}

}