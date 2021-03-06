/*
 * Generated by ASDT
*/

import mx.remoting.RecordSet;
import mx.rpc.ResultEvent;
import mx.utils.Iterator;

import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;
import com.adgamewonderland.duden.sudoku.challenge.beans.HighscoreListItem;
import com.adgamewonderland.duden.sudoku.challenge.beans.User;
import com.adgamewonderland.duden.sudoku.challenge.connectors.StatisticConnector;
import com.adgamewonderland.duden.sudoku.challenge.interfaces.IHighscoreListListener;
import com.adgamewonderland.duden.sudoku.challenge.ui.HighscoreListItemUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.ListUI;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameStatus;
import com.adgamewonderland.agw.util.StringFormatter;

class com.adgamewonderland.duden.sudoku.challenge.ui.HighscoreListUI extends ListUI implements IHighscoreListListener {

	private static var LISTPOSX:Number = 17;

	private static var LISTPOSY:Number = 70;

	private static var NUMUSERS:Number = 10;

	private var rankstart:Number;

	private var list_mc:MovieClip;

	private var rank_txt:TextField;

	private var score_txt:TextField;

	private var prev_btn:Button;

	private var next_btn:Button;

	public function HighscoreListUI() {

		super();
		// buttons initialisieren
		prev_btn.onRelease = function ():Void {
			this._parent.swapPage(-1);
		};
		next_btn.onRelease = function ():Void {
			this._parent.swapPage(1);
		};
		// platzierung linksbuendig
		rank_txt.autoSize = "left";
		// punktzahl rechtsbuendig
		score_txt.autoSize = "right";
	}

	public function onLoad():Void
	{
		// buttons ausblenden
		showButtons(false, false);
		// platzierung laden
		loadRank();
		// punktzahl
		score_txt.text = StringFormatter.formatNumber(GameController.getInstance().getUser().getStatistics().getScore()) + " Pkt.";
	}

	public function onRankLoaded(re:ResultEvent ):Void
	{
		// platzierung
		var rank:Number = Number(re.result);
		// anzeigen
		rank_txt.text = String(rank);
		// auf welche seite der highscoreliste steht der user mit dieser platzierung
		var page:Number = Math.ceil(rank / NUMUSERS);
		// welche platzierung soll ganz oben angezeigt werden
		setRankstart((page - 1) * NUMUSERS + 1);
		// highscoreliste laden
		loadHighscoreList();
	}

	public function onHighscoreListLoaded(re:ResultEvent ):Void
	{
		// anzeigen
		showHighscoreList(RecordSet(re.result));
	}

	public function onSelectItem(mc:HighscoreListItemUI ):Void {
		// gegner laden lassen
		GameController.getInstance().loadOpponent(mc.getItem().getEmail());
	}

	private function loadRank():Void
	{
		// eingeloggter user
		var user:User = GameController.getInstance().getUser();
		// testen, ob eingeloggt
		if (user.getID() != null) {
			// platzierung laden lassen
			StatisticConnector.loadRank(user.getStatistics().getScore(), this, "onRankLoaded");

		} else {
			// keine platzierung
			rank_txt.text = "-";
			// erste platzierung soll ganz oben angezeigt werden
			setRankstart(1);
			// highscoreliste laden
			loadHighscoreList();
		}
	}

	private function loadHighscoreList():Void
	{
		// buttons ausblenden
		showButtons(false, false);
		// liste laden lassen
		StatisticConnector.loadHighscoreList(getRankstart() - 1, NUMUSERS + 1, this, "onHighscoreListLoaded");
	}

	private function showHighscoreList(highscorelist:RecordSet ):Void
	{
		// liste leeren
		clearList();
		// liste auf buehne
		list_mc = this.createEmptyMovieClip("list_mc", getNextHighestDepth());
		// liste positionieren
		list_mc._x = LISTPOSX;
		list_mc._y = LISTPOSY;
		// liste muss hinter blind button liegen
		if (list_mc.getDepth() > blind_mc.getDepth()) {
			list_mc.swapDepths(blind_mc);
		}
		// zaehler
		var counter:Number = 0;
		// y-position des naechsten items
		var ypos:Number = 0;
		// iterator ueber recordset
		var iterator:Iterator = highscorelist.getIterator();
		// schleife ueber alle items
		while (iterator.hasNext()) {
			// aktuelles item
			var item:HighscoreListItem = HighscoreListItem(RemotingBeanCaster.getCastedInstance(new HighscoreListItem(), iterator.next()));
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = ypos;
			// rank
			constructor._rank = getRankstart() + counter;
			// item
			constructor._item = item;
			// selectable (nur wenn nicht eingelogger user)
			constructor._selectable = item.getEmail() != GameController.getInstance().getUser().getEmail();
			// item auf buehne
			var item_mc:HighscoreListItemUI = HighscoreListItemUI(list_mc.attachMovie("HighscoreListItemUI", "item" + (counter + 1) + "_mc", counter + 1, constructor));
			// als listener registrieren
			item_mc.addListener(this);
			// zaehler
			counter ++;
			// naechste y-position
			ypos += item_mc._height;
 			// server liefert einen datensatz zuviel, wenn naechste seite verfuegbar
 			if (counter == NUMUSERS) break;
		}
		// buttons einblenden
		showButtons(true, highscorelist.length > NUMUSERS);
	}

	private function clearList():Void
	{
		// zaehler
		var i = 0;
		// schleife ueber alle angezeigten user
		while (list_mc["item" + (++i) + "_mc"] instanceof MovieClip) list_mc["item" + i + "_mc"].removeMovieClip();
	}

	private function showButtons(inout:Boolean, nextpage:Boolean ):Void
	{
		// ein- / ausblenden
		switch (inout) {
			// einblenden
			case true :
				// vorherige seite
				prev_btn._visible = (getRankstart() > 1);
				// naechste seite
				next_btn._visible = nextpage;

				break;
			// ausblenden
			case false :
				// vorherige seite
				prev_btn._visible = false;
				// vorherige seite
				next_btn._visible = false;

				break;
		}
	}

	private function swapPage(dir:Number ):Void
	{
		// liste loeschen
		clearList();
		// welche platzierung soll ganz oben angezeigt werden
		setRankstart(getRankstart() + dir * NUMUSERS);
		// highscoreliste laden
		loadHighscoreList();
	}

	public function getRankstart():Number {
		return rankstart;
	}

	public function setRankstart(rankstart:Number):Void {
		this.rankstart = rankstart;
	}

}