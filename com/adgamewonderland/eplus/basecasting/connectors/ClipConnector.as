import com.adgamewonderland.eplus.basecasting.interfaces.IClipConnector;
import com.adgamewonderland.agw.net.DefaultConnector;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.ResultEvent;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl;
import mx.utils.Collection;
import mx.utils.CollectionImpl;
import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.beans.impl.ClipImpl;

class com.adgamewonderland.eplus.basecasting.connectors.ClipConnector extends DefaultConnector implements IClipConnector
{

	private static var instance:ClipConnector;

	/**
	 * @return singleton instance of ClipConnector
	 */
	public static function getInstance():ClipConnector {
		if (instance == null)
			instance = new ClipConnector();
		return instance;
	}

	private function ClipConnector() {
		super();
		// gateway
		this.gateway = "http://www.base-casting.de/gateway"; // "http://tripto.adgame-wonderland.de:9999/basecasting_development/gateway";
		// remoteobj
		this.remoteobj = "com.adgamewonderland.eplus.basecasting.connectors.ClipConnector";
		// debug
		this.debug = true;
	}

	public function loadTopclip(aCityId:Number ):Void
	{
		// topclip laden
		var pc:PendingCall = getService().loadTopclip(aCityId);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onTopclipLoaded", "onConnectorFault");
	}

	public function loadClipsByRank(aCityId:Number, aStartat:Number, aCount:Number ):Void
	{
		// clips laden
		var pc:PendingCall = getService().loadClipsByRank(aCityId, aStartat, aCount);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onClipsByRankLoaded", "onConnectorFault");
	}

	public function loadClipsByDate(aCityId:Number, aDate:Date ):Void
	{
		// clips laden
		var pc:PendingCall = getService().loadClipsByDate(aCityId, aDate);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onClipsByDateLoaded", "onConnectorFault");
	}

	public function loadClipsByCasting(aCastingId:Number ):Void
	{
		// clips laden
		var pc:PendingCall = getService().loadClipsByCasting(aCastingId);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onClipsByCastingLoaded", "onConnectorFault");
	}

	public function loadClip(aClipId:Number ):Void
	{
		// clip laden
		var pc:PendingCall = getService().loadClip(aClipId);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(this, "onClipLoaded", "onConnectorFault");
	}

	private function onTopclipLoaded(re:ResultEvent ):Void
	{
		// am hoechsten bewerteter clip einer stadt
		var topclip:VotableClip = VotableClipImpl.parse(re.result);
		// listener informieren
		_event.send("onTopclipLoaded", topclip);
	}

	private function onClipsByRankLoaded(re:ResultEvent ):Void
	{
		// liste der am hoechsten bewerteten clips einer stadt
		var clips:Collection = parseCliplist(re.result);
		// listener informieren
		_event.send("onClipsByRankLoaded", clips);
	}

	private function onClipsByDateLoaded(re:ResultEvent ):Void
	{
		// liste der clips eines datums
		var clips:Collection = parseCliplist(re.result);
		// listener informieren
		_event.send("onClipsByDateLoaded", clips);
	}

	private function onClipsByCastingLoaded(re:ResultEvent ):Void
	{
		// liste der clips eines castings
		var clips:Collection = parseCliplist(re.result);
		// listener informieren
		_event.send("onClipsByCastingLoaded", clips);
	}

	private function onClipLoaded(re:ResultEvent ):Void
	{
		// ein beliebiger clip einer stadt
		var clip:Clip = ClipImpl.parse(re.result);
		// listener informieren
		_event.send("onClipLoaded", clip);
	}

	private function parseCliplist(aCliplist:Object ):Collection
	{
		// liste der clips
		var clips:Collection = new CollectionImpl();
		// aktueller clip
		var clip:Clip;
		// schleife ueber staedte
		for (var i:Number = 0; i < aCliplist.length; i++) {
			// aktueller clip
			if (aCliplist[i].totalscore != null)
				clip = VotableClipImpl.parse(aCliplist[i]);
			else
				clip = ClipImpl.parse(aCliplist[i]);
			// in liste der staedte
			clips.addItem(clip);
		}
		// zurueck geben
		return clips;
	}

}
