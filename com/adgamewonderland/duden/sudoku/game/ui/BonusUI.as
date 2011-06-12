import com.adgamewonderland.agw.util.StringFormatter;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.game.ui.BonusUI extends MovieClip {

	private var bar_mc:MovieClip;

	private var score_txt:TextField;

	public function BonusUI() {
		// punktzahl
		score_txt.autoSize = "left";
	}

	public function onLoad():Void
	{
		// punktzahl resetten
		score_txt.text = "0";
		// balken resetten
		bar_mc._x = 0;
	}

	public function showScore(score:Number, scoremax:Number ):Void
	{
		// punktzahl anzeigen
		score_txt.text = StringFormatter.formatNumber(score);
		// balken verschieben
		bar_mc._x = -Math.round((1 - score / scoremax) * bar_mc._width);
	}

}