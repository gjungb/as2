
/**
 * @author gerd
 */
class com.adgamewonderland.dhl.adventsgewinnspiel.ui.PackageUI extends MovieClip {

	public function PackageUI() {
		// resetten
		reset();
	}
	
	public function openPackage():Void
	{
		// interval
		var interval:Number;
		// nach pause resetten
		var doReset:Function = function(mc:PackageUI ):Void {
			// ausblenden
			mc.reset();
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause rausfahren
		interval = setInterval(doReset, 1000, this);
		// einblenden
		this._visible = true;
		play();
	}
	
	private function reset():Void
	{
		// ausblenden
		gotoAndStop(1);
		this._visible = false;
	}
}