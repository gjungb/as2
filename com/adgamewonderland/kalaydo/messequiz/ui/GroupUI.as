import com.adgamewonderland.kalaydo.messequiz.controllers.QuizController;
import com.adgamewonderland.kalaydo.messequiz.ui.FigureUI;
import com.adgamewonderland.kalaydo.messequiz.interfaces.IQuizControllerListener;
/**
 * @author gerd
 */
class com.adgamewonderland.kalaydo.messequiz.ui.GroupUI extends MovieClip implements IQuizControllerListener {

	private var figure1_mc:FigureUI;

	private var figure2_mc:FigureUI;

	private var figure3_mc:FigureUI;

	private var figure4_mc:FigureUI;

	private var figure5_mc:FigureUI;

	function GroupUI() {

	}

	public function onLoad():Void
	{
		// als listener registrieren
		QuizController.getInstance().addListener(this);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		QuizController.getInstance().removeListener(this);
	}

	public function onTaskSolved(aCorrect:Boolean, aFigures:Array ):Void
	{
		// abbrechen, wenn nicht korrekt
		if (!aCorrect)
			return;
		// wenn korrekt, figur ausblenden
		var figure:FigureUI;
		// schleife ueber figuren
		for (var i:Number = 0; i < aFigures.length; i++) {
			// aktuelle figur
			figure = FigureUI(this["figure" + (i + 1) + "_mc"]);
			// deaktivieren
			if (aFigures[i] == true)
				figure.hideFigure();
		}
	}

	public function onQuizFinished(aWon:Boolean ):Void
	{
		// gewonnen
		if (aWon)
			return;
		// verloren => raten
		for (var i:String in this) {
			// figur
			if (this[i] instanceof FigureUI) {
				FigureUI(this[i]).setActive(true);
			}
		}
	}

	public function onGuessFinished(aWon:Boolean):Void
	{
	}

}