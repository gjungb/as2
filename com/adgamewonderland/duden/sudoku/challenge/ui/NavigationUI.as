import com.adgamewonderland.duden.sudoku.challenge.interfaces.IUserListener;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;
import com.adgamewonderland.agw.util.Fader;
import com.adgamewonderland.duden.sudoku.challenge.beans.User;
import mx.utils.Delegate;
import com.adgamewonderland.duden.sudoku.challenge.ui.GameUI;

class com.adgamewonderland.duden.sudoku.challenge.ui.NavigationUI extends MovieClip implements IUserListener {

	private var buttons:Array;

	private var instructions_mc:MovieClip;

	private var preferences_mc:MovieClip;

	private var imprint_mc:MovieClip;

	private var logout_mc:MovieClip;

	public function NavigationUI() {
		// als listener registrieren
		GameController.getInstance().addListener(this);
		// buttons
		this.buttons = new Array(instructions_mc, imprint_mc, logout_mc, preferences_mc);

		// instructions
		instructions_mc.onRelease = Delegate.create(this, onInstructions);
		// imprint
		imprint_mc.onRelease = Delegate.create(this, onImprint);
		// preferences
		preferences_mc.onRelease = Delegate.create(this, onPreferences);
		// logout
		logout_mc.onRelease = Delegate.create(this, onLogout);

		// preferences ausblenden
		preferences_mc._visible = false;
		// logout ausblenden
		logout_mc._visible = false;
	}

	public function setButtonsEnabled(bool:Boolean ):Void
	{
		// buttons umschalten
		for (var i:String in buttons) {
			// de- / aktivieren
			this.buttons[i].enabled = bool;
			// aussehen umschalten
			this.buttons[i].gotoAndStop("_up");
		}
	}

	public function showNavi(bool:Boolean ):Void
	{
		// ein- / ausblenden
		switch (bool) {
			// einblenden
			case true :
				// aktivieren
				setButtonsEnabled(true);
				// einfaden
				Fader.fade(this, 0, 100, 500, 20);

				break;
			// ausblenden
			case false :
				// deaktivieren
				setButtonsEnabled(false);
				// ausfaden
				Fader.fade(this, 100, 0, 500, 20);

				break;
		}
	}

	public function onUserLogin(user:User ):Void
	{
		// logout einblenden
		logout_mc._visible = true;
		// preferences einblenden
		preferences_mc._visible = true;
	}

	public function onUserLogout(user:User ):Void
	{
		// logout ausblenden
		logout_mc._visible = false;
		// preferences ausblenden
		preferences_mc._visible = false;
	}

	public function onUserUpdate(user:User ):Void
	{
	}

	private function onUnload():Void
	{
		// als listener deregistrieren
		GameController.getInstance().removeListener(this);
	}

	private function onInstructions():Void
	{
		// instructions anzeigen lassen
		GameUI.getMovieClip().showInstructions();
	}

	private function onImprint():Void
	{
		// imprint anzeigen lassen
		GameUI.getMovieClip().showImprint();
	}

	private function onPreferences():Void
	{
		// preferences anzeigen lassen
		GameUI.getMovieClip().showPreference();
	}

	private function onLogout():Void
	{
		// ausloggen
		GameController.getInstance().logoutUser();
	}

}