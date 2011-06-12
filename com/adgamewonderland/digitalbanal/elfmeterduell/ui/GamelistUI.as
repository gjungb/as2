/* 
 * Generated by ASDT 
*/ 
 
import mx.remoting.debug.NetDebug;
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.connectors.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.GamelistUI extends MovieClip {
	
	private var list_mc:MovieClip;
	
	public function GamelistUI() {
		// ausblenden
		_visible = false;
		// liste laden
		loadGamelist();
	}
	
	private function loadGamelist():Void
	{
		// eingeloggter user
		var user:User = GameController.getInstance().getUser();
		// testen, ob eingeloggt
		if (user.getUserID() != null) {
			// liste laden lassen
			ChallengeC.loadGamelist(user.getUserID(), this, "onGamelistLoaded");
		}
	}
	
	public function onGamelistLoaded(re:ResultEvent ):Void
	{
		// einblenden
		_visible = true;
		// anzeigen
		showGamelist(re.result);
	}
	
	private function showGamelist(gamelist:Array ):Void
	{
		// dummy
		var dummy:MovieClip = list_mc.dummy_mc;
		// hoehe des dummy
		var ydiff = dummy._height - 2;
		
		// schleife ueber alle item
		for (var i = 1; i <= gamelist.length; i ++) {
			// aktueller item
			var item:Object = gamelist[i - 1];
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = dummy._y + (i - 1) * ydiff;
			// mailid
			constructor._myMailid = item.mailid;
			// nickname
			constructor._myNickname = item.nickname;
			// email des eingeloggten users
			constructor._myEmail = GameController.getInstance().getUser().getEmail();
			// referenz auf content
			constructor._myContentUI = ContentUI.getContentUI();
			// dummy duplizieren
			var pos_mc:MovieClip = dummy.duplicateMovieClip("pos" + i + "_mc", i + 1, constructor);
			// callback bei klick
			pos_mc.onRelease = function() {
				// siegerehrung
				this._myContentUI.loadGame(this._myMailid, this._myEmail);
			};
		}
		// dummy unsichtbar
		dummy._visible = false;
	}
	
	private function clearList():Void
	{
		// zaehler
		var i = 0;
		// schleife ueber alle angezeigten item
		while (list_mc["pos" + (++i) + "_mc"] instanceof MovieClip) list_mc["pos" + i + "_mc"].removeMovieClip();
	}
}