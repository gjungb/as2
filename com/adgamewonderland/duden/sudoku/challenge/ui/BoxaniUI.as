/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.BoxaniUI extends MovieClip {

	private var blind_btn:Button;

	public function BoxaniUI() {

	}

	public function showBox():Void
	{
		// einblenden
		gotoAndPlay("frIn");
		// blind button aktivieren
		showBlind(true);
	}

	public function hideBox():Void
	{
		// ausblenden
		gotoAndPlay("frOut");
		// blind button deaktivieren
		showBlind(false);
	}

	private function showBlind(bool:Boolean ):Void
	{
		// nach pause blind button ein- / ausblenden
		var interval:Number;
		// funktion
		var doShow:Function = function(mc:BoxaniUI, bool:Boolean ):Void {
			// ohne mauszeiger
			mc.blind_btn.useHandCursor = false;
			// ein- / ausblenden
			mc.blind_btn._visible = bool;
			// interval loeschen
			clearInterval(interval);
		};
		// umschalten
		interval = setInterval(doShow, 25, this, bool);
	}

}