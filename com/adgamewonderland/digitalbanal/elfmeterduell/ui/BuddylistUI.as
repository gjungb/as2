/**
 * @author gerd
 */
 
import mx.remoting.debug.NetDebug;
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.adgamewonderland.agw.util.ScrollbarUI;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.connectors.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.BuddylistUI extends MovieClip {
	
	private var list_mc:MovieClip;
	
	private var scrollbar_mc:ScrollbarUI;
	
	public function BuddylistUI() {
		// ausblenden
		_visible = false;
		// liste laden
		loadBuddylist();
	}
	
	private function loadBuddylist():Void
	{
		// eingeloggter user
		var user:User = GameController.getInstance().getUser();
		// testen, ob eingeloggt
		if (user.getUserID() != null) {
			// liste laden lassen
			ChallengeC.loadBuddylist(user.getUserID(), this, "onBuddylistLoaded");
		}
	}
	
	public function onBuddylistLoaded(re:ResultEvent ):Void
	{
		// anzeigen
		showBuddylist(re.result);
	}
	
	private function showBuddylist(buddylist ):Void
	{
		// dummy
		var dummy:MovieClip = list_mc.dummy_mc;
		// hoehe des dummy
		var ydiff = dummy._height - 2;
		// schleife ueber alle user
		for (var i = 1; i <= buddylist.length; i ++) {
			// aktueller user
			var user:Object = buddylist[i - 1];
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy._y + (i - 1) * ydiff;
			// nickname
			constructor._myNickname = user.nickname;
			// email (fuer herausforderung)
			constructor._myEmail = user.email;
			// referenz auf challenge
			constructor._myChallengeUI = ChallengeUI(_parent);
			// dummy duplizieren
			var pos_mc:MovieClip = dummy.duplicateMovieClip("pos" + i + "_mc", i + 1, constructor);
			// callback bei klick
			pos_mc.onRelease = function() {
				// herausfordern
				this._myChallengeUI.setOpponent(this._myEmail);
			};
		}
		// dummy unsichtbar
		dummy._visible = false;
		// scrollbar initialisieren
		scrollbar_mc.setScrollTarget(list_mc);
		// einblenden
		_visible = true;
	}
}