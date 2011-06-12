import com.adgamewonderland.duden.sudoku.challenge.beans.ChallengeListItem;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.agw.util.IEventBroadcaster;
import mx.utils.Delegate;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.ChallengeListItemUI extends MovieClip implements IEventBroadcaster {

	private var _item:ChallengeListItem;

	private var event:EventBroadcaster;

	private var nickname_txt:TextField;

	private var select_mc:MovieClip;

	private var reject_btn:Button;

	public function ChallengeListItemUI() {
		// event broadcaster
		this.event = new EventBroadcaster();
		// nickname
		nickname_txt.text = getItem().getNickname();
		// select
		select_mc.onRelease = Delegate.create(this, onSelect);
		// reject
		reject_btn.onRelease = Delegate.create(this, onReject);
	}

	/**
	 * callback bei auswahl des items
	 */
	public function onSelect():Void
	{
		// button deaktivieren
		select_mc.enabled = false;
		// event
		this.event.send("onSelectItem", this);
	}

	/**
	 * callback bei loeschen des items
	 */
	public function onReject():Void
	{
		// button deaktivieren
		reject_btn.enabled = false;
		// event
		this.event.send("onRejectItem", this);
	}

	public function getItem():ChallengeListItem
	{
		return _item;
	}

	public function addListener(l : Object) : Void {
		// als listener registrieren
		this.event.addListener(l);
	}

	public function removeListener(l : Object) : Void {
		// als listener abmelden
		this.event.removeListener(Object(l));
	}

}