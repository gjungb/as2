/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.LogoUI extends MovieClip {

	public function LogoUI() {

	}

	/**
	 * glow abspielen
	 */
	public function showGlow():Void
	{
		// hinspringen
		this.gotoAndPlay("frGlow");
	}

	/**
	 * button de- /aktivieren
	 */
	public function setEnabled(bool:Boolean ):Void
	{
		// de- / aktivieren
		this.enabled = bool;
	}

}