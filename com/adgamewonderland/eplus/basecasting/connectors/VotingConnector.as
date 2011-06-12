import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.ResultEvent;

import com.adgamewonderland.agw.net.DefaultConnector;
import com.adgamewonderland.eplus.basecasting.interfaces.IVotingConnector;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.connectors.VotingConnector extends DefaultConnector implements IVotingConnector {

	private static var instance:VotingConnector;

	/**
	 * @return singleton instance of VotingConnector
	 */
	public static function getInstance():VotingConnector {
		if (instance == null)
			instance = new VotingConnector();
		return instance;
	}

	private function VotingConnector() {
		super();
		// gateway
		this.gateway = "http://tripto.adgame-wonderland.de:9999/basecasting_development/gateway";
		// remoteobj
		this.remoteobj = "com.adgamewonderland.eplus.basecasting.connectors.VotingConnector";
		// debug
		this.debug = true;
	}

	public function saveVote(aEmail:String, aClipId:Number, aScore:Number ):Void
	{
		// abstimmung speichern
		var pc:PendingCall = getService().saveVote(aEmail, aClipId, aScore);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onVoteSaved", "onConnectorFault");
	}

	private function onVoteSaved(re:ResultEvent ):Void
	{
		// listener informieren
		_event.send("onVoteSaved", Boolean(re.result));
	}

}