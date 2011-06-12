import com.adgamewonderland.agw.net.DefaultConnector;
import com.adgamewonderland.eplus.basecasting.interfaces.ITellafriendConnector;
import com.adgamewonderland.eplus.basecasting.view.beans.Tellafriend;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.ResultEvent;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.connectors.TellafriendConnector extends DefaultConnector implements ITellafriendConnector {

	private static var instance : TellafriendConnector;

	/**
	 * @return singleton instance of TellafriendConnector
	 */
	public static function getInstance() : TellafriendConnector {
		if (instance == null)
			instance = new TellafriendConnector();
		return instance;
	}

	private function TellafriendConnector() {
		super();
		// gateway
		this.gateway = "http://tripto.adgame-wonderland.de:9999/basecasting_development/gateway";
		// remoteobj
		this.remoteobj = "com.adgamewonderland.eplus.basecasting.connectors.TellafriendConnector";
		// debug
		this.debug = true;
	}

	public function recommendWebsite(aTellafriend:Tellafriend ):Void
	{
		// website empfehlen
		var pc:PendingCall = getService().recommendWebsite(aTellafriend);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onWebsiteRecommended", "onConnectorFault");
	}

	public function recommendCity(aTellafriend:Tellafriend, aCityId:Number ):Void
	{
		// stadt empfehlen
		var pc:PendingCall = getService().recommendCity(aTellafriend, aCityId);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onCityRecommended", "onConnectorFault");
	}

	public function recommendClip(aTellafriend:Tellafriend, aClipId:Number ):Void
	{
		// clip empfehlen
		var pc:PendingCall = getService().recommendClip(aTellafriend, aClipId);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onClipRecommended", "onConnectorFault");
	}

	private function onWebsiteRecommended(re:ResultEvent ):Void
	{
		// listener informieren
		_event.send("onTellafriendSent", re.result);
	}

	private function onCityRecommended(re:ResultEvent ):Void
	{
		// listener informieren
		_event.send("onTellafriendSent", re.result);
	}

	private function onClipRecommended(re:ResultEvent ):Void
	{
		// listener informieren
		_event.send("onTellafriendSent", re.result);
	}

}