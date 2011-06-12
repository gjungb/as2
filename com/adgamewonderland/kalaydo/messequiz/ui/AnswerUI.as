import com.adgamewonderland.kalaydo.messequiz.controllers.QuizController;
/**
 * @author gerd
 */

class com.adgamewonderland.kalaydo.messequiz.ui.AnswerUI extends MovieClip {

	private var _correct:Boolean = false;

	private var _targetfield:String;

	private var _colordefault:Number;

	private var _colorover:Number;

	private var correct:Boolean;

	private var target_txt:TextField;

	private var radio_mc:MovieClip;

	private var hitarea_mc:MovieClip;

	public function AnswerUI() {
	}

	public function onLoad():Void
	{
		// textfeld
		this.target_txt = TextField(_parent[_targetfield]);
		// antwort korrekt
		setCorrect(_correct);
		// radiobutton ausblenden
		showRadio(false);
		// text einfaerben
		showColor(_colordefault);
		// hitarea initialisieren
		initHitarea();
		// klickbar
		enabled = true;
	}

	public function onRelease():Void
	{
		// controller informieren
		QuizController.getInstance().solveTask(_correct);
	}

	public function onRollOver():Void
	{
		// radiobutton einblenden
		showRadio(true);
		// text einfaerben
		showColor(_colorover);
	}

	public function onRollOut():Void
	{
		// radiobutton ausblenden
		showRadio(false);
		// text einfaerben
		showColor(_colordefault);
	}

	public function showRadio(bool:Boolean ):Void
	{
		// radiobutton ein- / ausblenden
		radio_mc._visible = bool;
	}

	public function showColor(color:Number ):Void
	{
		// textfeld einfaerben
		this.target_txt.textColor = color;
	}

	public function highlightCorrect():Void
	{
		// abbrechen, wenn nicht korrekt
		if (getCorrect() == false)
			return;
		// highlighten
		showRadio(true);
		showColor(0xD4011C);
	}

	private function initHitarea():Void
	{
		// breite inkl. textfeld
		var width:Number = this.target_txt._x - this._x + this.target_txt._width;
		// hoehe
		var height:Number = this.target_txt._height;
		// neue hitarea
		hitarea_mc = this.createEmptyMovieClip("hitarea_mc", 2);
		// rechteck mit fuellung
		hitarea_mc.beginFill(0xCCCCCC, 0);
		// zeichnen
		hitarea_mc.lineTo(width, 0);
		hitarea_mc.lineTo(width, height);
		hitarea_mc.lineTo(0, height);
		hitarea_mc.lineTo(0, 0);
		// als hitarea
		this.hitArea = hitarea_mc;
	}

	public function getCorrect():Boolean {
		return correct;
	}

	public function setCorrect(correct:Boolean):Void {
		this.correct = correct;
	}

}