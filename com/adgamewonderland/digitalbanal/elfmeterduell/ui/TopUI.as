/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.TopUI extends MovieClip implements IUserListener {
	
	private var nickname_txt:TextField;
	
	private var logout_btn:Button;
	
	public function TopUI() {
		// nickname rechtsbuendig
		nickname_txt.autoSize = "right";
		// button logout
		logout_btn.onRelease = function():Void {
			GameController.getInstance().logoutUser();
		};
		// ausblenden
		logout_btn._visible = false;
		
		// als listener registrieren
		GameController.getInstance().addListener(this);
	}
	
	public function onUserLogin(user:User ):Void
	{
		// nickname
		nickname_txt.text = user.getNickname();
		// logout einblenden
		logout_btn._visible = true;
	}
	
	public function onUserLogout(user:User ):Void
	{
		// nickname
		nickname_txt.text = "";
		// logout ausblenden
		logout_btn._visible = false;
	}
	
	public function onUserUpdate(user:User ):Void
	{
		// nickname
		nickname_txt.text = user.getNickname();
	}
	
	private function onUnload():Void
	{
		// als listener deregistrieren
		GameController.getInstance().removeListener(this);
	}
}