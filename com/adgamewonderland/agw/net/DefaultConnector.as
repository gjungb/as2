import mx.remoting.debug.NetDebug;
import mx.remoting.Service;

import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;

class com.adgamewonderland.agw.net.DefaultConnector implements IEventBroadcaster
{
	private var _event:EventBroadcaster;

	private var gateway:String;

	private var remoteobj:String;

	private var service:Service;

	private var debug:Boolean = false;

	public function DefaultConnector() {
		this._event = new EventBroadcaster();
	}

	public function addListener(l:Object):Void
	{
		this._event.addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		this._event.removeListener(l);
	}

	private function getService():Service
	{
		// testen, ob service schon instantiiert
		if (this.service instanceof Service == false) {
			// debugger
			if (debug)
				NetDebug.initialize();
			// offline / online
			if (_root._url.indexOf("http://") == -1) {
				// remoting service mit url
				this.service = new Service(this.gateway, null, this.remoteobj, null, null);
			} else {
				// remoting service ohne url
				this.service = new Service("", null, this.remoteobj, null, null);
			}
		}
		// zurueck geben
		return this.service;
	}
}
