import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.controllers.VideoController extends DefaultController {

	private static var instance:VideoController;

	private var votableclip:VotableClip;

	private var tellafriendclip:Clip;

	/**
	 * @return singleton instance of VideoController
	 */
	public static function getInstance():VideoController {
		if (instance == null)
			instance = new VideoController();
		return instance;
	}

	private function VideoController() {
		super();
		// clip, fuer den gestimmt werden soll
		this.votableclip = null;
		// clip, der empfohlen werden soll
		this.tellafriendclip = null;
	}

	public function selectClip(aClip:Clip ):Void
	{
		// listener informieren
		_event.send("onClipSelected", aClip);
	}

	public function startVoting(aClip:Clip ):Void
	{
		// abbrechen, wenn voting nicht erlaubt
		if (aClip instanceof VotableClip == false)
			return;
		// clip, fuer den gestimmt werden soll
		this.votableclip = VotableClip(aClip);
		// listener informieren
		_event.send("onVotingStarted", aClip);
	}

	public function startTellafriend(aClip:Clip ):Void
	{
		// clip, der empfohlen werden soll
		this.tellafriendclip = aClip;
		// listener informieren
		_event.send("onTellafriendStarted", aClip);
	}

	public function getVotableclip():VotableClip
	{
		return this.votableclip;
	}

	public function setTellafriendclip(aTellafriendclip:Clip ):Void
	{
		this.tellafriendclip = aTellafriendclip;
	}

	public function getTellafriendclip():Clip
	{
		return this.tellafriendclip;
	}

}