import com.adgamewonderland.agw.util.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.duden.sudoku.challenge.beans.HighscoreListItem;
import mx.utils.Delegate;
import com.adgamewonderland.agw.util.StringFormatter;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;

/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.HighscoreListItemUI extends MovieClip implements IEventBroadcaster {

	private var _rank:Number;

	private var _item:HighscoreListItem;

	private var _selectable:Boolean;

	private var event:EventBroadcaster;

	private var rank_txt:TextField;

	private var nickname_txt:TextField;

	private var score_txt:TextField;

	private var select_mc:MovieClip;

	public function HighscoreListItemUI() {
		// event broadcaster
		this.event = new EventBroadcaster();
		// rank rechtsbuendig
		rank_txt.autoSize = "right";
		// rank
		rank_txt.text = String(_rank) + ".";
		// nickname
		nickname_txt.text = getItem().getNickname();
		// score rechtsbuendig
		score_txt.autoSize = "right";
		// score
		score_txt.text = StringFormatter.formatNumber(getItem().getScore()) + " Pkt.";
		// select
		if (_selectable) {
			select_mc.onRelease = Delegate.create(this, onSelect);
		}
	}

	/**
	 * callback bei auswahl des items
	 */
	public function onSelect():Void
	{
		// event
		this.event.send("onSelectItem", this);
	}

	public function getItem():HighscoreListItem
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