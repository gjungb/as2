/**
 * @author gerd
 */
 
import com.adgamewonderland.aldi.sudoku.beans.Solution;

class com.adgamewonderland.aldi.sudoku.ui.DifficultyChooserUI extends MovieClip {
	
	private var difficulty:Number;
	
	private var d1_mc:MovieClip;
	
	private var d2_mc:MovieClip;
	
	private var blind_mc:MovieClip;
	
	public function DifficultyChooserUI() {
		// schwierigkeitsgrad
		setDifficulty(Solution.DIFFICULTY_EASY);
		// 1. buttons initialisieren
		d1_mc.onRelease = function() {
			this._parent.setDifficulty(Solution.DIFFICULTY_EASY);
		};
		d2_mc.onRelease = function() {
			this._parent.setDifficulty(Solution.DIFFICULTY_HARD);
		};
		// 2. blind button initialisieren
		initBlind();
	}
	
	public function getDifficulty():Number {
		return difficulty;
	}

	public function setDifficulty(difficulty:Number):Void {
		d1_mc.enabled = (difficulty == Solution.DIFFICULTY_HARD);
		d1_mc.gotoAndStop(difficulty == Solution.DIFFICULTY_HARD ? "_up" : "frSelected");
		d2_mc.enabled = (difficulty == Solution.DIFFICULTY_EASY);
		d2_mc.gotoAndStop(difficulty == Solution.DIFFICULTY_EASY ? "_up" : "frSelected");
		this.difficulty = difficulty;
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
		blind_mc._x = 12;
		blind_mc._y = 305;
		// rechteck mit fuellung
		blind_mc.beginFill(0xCCCCCC, 0);
		// zeichnen
		blind_mc.lineTo(195, 0);
		blind_mc.lineTo(195, 94);
		blind_mc.lineTo(0, 94);
		blind_mc.lineTo(0, 0);
		// als button
		blind_mc.onRelease = function() {};
		// deaktivieren
		blind_mc._visible = false;
		// ohne mauszeiger
		blind_mc.useHandCursor = false;
	}

}