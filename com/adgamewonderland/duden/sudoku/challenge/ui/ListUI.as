/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.ListUI extends MovieClip {

	private var ALPHA_ACTIVE:Number = 100;

	private var ALPHA_INACTIVE:Number = 50;

	private var active:Boolean;

	private var blind_mc:MovieClip;

	public function ListUI() {
		// active
		this.active = true;
		// blind button initialisieren
		initBlind();
	}

	public function setActive(bool:Boolean ):Void
	{
		// active
		this.active = active;
		// blind button ein- / ausblenden
		showBlind(!bool);
		// alpha umschalten
		_alpha = bool ? ALPHA_ACTIVE : ALPHA_INACTIVE;
	}

	public function showBlind(bool:Boolean ):Void
	{
		// blind button ein- / ausblenden
		blind_mc._visible = bool;
	}

	private function initBlind():Void
	{
		// movieclip fuer blind button
		blind_mc = createEmptyMovieClip("blind_mc", getNextHighestDepth());
		// positionieren
		blind_mc._x = 0;
		blind_mc._y = 0;
		// rechteck mit fuellung
		blind_mc.beginFill(0xFFFFFF, 50);
		// zeichnen
		blind_mc.lineTo(_width, 0);
		blind_mc.lineTo(_width, _height);
		blind_mc.lineTo(0, _height);
		blind_mc.lineTo(0, 0);
		// als button
		blind_mc.onRelease = function() {};
		// deaktivieren
//		blind_mc._visible = false;
		// ohne mauszeiger
		blind_mc.useHandCursor = false;
	}

}