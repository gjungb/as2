import com.adgamewonderland.agw.Formprocessor;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameController;
import com.adgamewonderland.duden.sudoku.challenge.beans.GameStatus;
import com.adgamewonderland.duden.sudoku.challenge.interfaces.IGameListener;
import com.adgamewonderland.duden.sudoku.challenge.ui.BoxaniUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.ChallengeListUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.ChallengeUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.DifficultyUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.HighscoreListUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.NavigationUI;
import com.adgamewonderland.duden.sudoku.challenge.ui.StatisticsUI;
import com.adgamewonderland.duden.sudoku.game.ui.SudokuUI;
/**
 * @author gerd
 */
class com.adgamewonderland.duden.sudoku.challenge.ui.GameUI extends MovieClip implements IGameListener {

	private static var TIME_NAVIGATE:Number = 25;

	private static var FRAME_LOGIN:String = "frLogin";

	private static var FRAME_REGISTER:String = "frRegister";

	private static var FRAME_CHALLENGE:String = "frChallenge";

	private static var FRAME_DIFFICULTY:String = "frDifficulty";

	private static var FRAME_COMPARISON:String = "frComparison";

	private static var FRAME_SUDOKU:String = "frSudoku";

	private static var FRAME_GAMEOVER:String = "frGameover";

	private static var FRAME_AWARD:String = "frAward";

	private var nextframe:String;

	private var navigation_mc:NavigationUI;

	private var instructions_mc:BoxaniUI;

	private var imprint_mc:BoxaniUI;

	private var preference_mc:BoxaniUI;

	private var login_mc:BoxaniUI;

	private var register_mc:BoxaniUI;

	private var statistics_mc:StatisticsUI;

	private var challengelist_mc:ChallengeListUI;

	private var awardlist_mc:ChallengeListUI;

	private var challenge_mc:ChallengeUI;

	private var highscorelist_mc:HighscoreListUI;

	private var difficulty_mc:DifficultyUI;

	private var sudoku_mc:SudokuUI;

	private var gameover_mc:BoxaniUI;

	public function GameUI() {
		// frame, der als naechster angezeigt werden soll
		this.nextframe = FRAME_LOGIN;
		// als listener registrieren
		GameController.getInstance().addListener(this);
	}

	/**
	 * gibt globale referenz auf dieses movieclip zurueck
	 */
	public static function getMovieClip():GameUI
	{
		return GameUI(_root.game_mc);
	}

	/**
	 * initialisierung (herausforderung / siegerehrung || normal)
	 */
	public function onLoad():Void
	{
		// email aus uebergebenem parameter
		var email:String = _root.email != undefined ? _root.email : "";
		// hashkey fuer herausforderung aus uebergebenem parameter
		var hashkey:String = _root.challenge != undefined ? _root.challenge : "";
		// validieren, ob 1. korrekte email adresse, 2. nicht leerer hashkey
		var errors:Array = (new Formprocessor()).checkForm([Formprocessor.TYPE_EMAIL, "email", email, Formprocessor.TYPE_EMPTY, "hashkey", hashkey]);
		// testen, ob fehler gefunden
		if (errors.length == 0) {
			// herausforderung laden
			GameController.getInstance().loadChallenge(email, hashkey);

		} else {
			// login anzeigen
			GameController.getInstance().changeStatus(new GameStatus(GameStatus.STATUS_LOGIN));
		}
	}

	/**
	 * callback nach statusaenderung im gamecontroller
	 */
	public function onChangeStatus(oldstatus:GameStatus, newstatus:GameStatus ):Void
	{
		// navigationsregeln
		switch (newstatus.getStatus()) {
			// login
			case GameStatus.STATUS_LOGIN :
				showFrame(FRAME_LOGIN);

				break;
			// register
			case GameStatus.STATUS_REGISTER :
				showFrame(FRAME_REGISTER);

				break;
			// training
			case GameStatus.STATUS_TRAINING :
				showFrame(FRAME_SUDOKU);

				break;
			// challenge
			case GameStatus.STATUS_CHALLENGE :
				showFrame(FRAME_CHALLENGE);

				break;
			// difficulty
			case GameStatus.STATUS_DIFFICULTY :
				showFrame(FRAME_DIFFICULTY);

				break;
			// statistics
			case GameStatus.STATUS_COMPARISON :
				showFrame(FRAME_COMPARISON);

				break;
			// sudoku
			case GameStatus.STATUS_SUDOKU :
				showFrame(FRAME_SUDOKU);

				break;
			// gameover
			case GameStatus.STATUS_GAMEOVER :
				showFrame(FRAME_GAMEOVER);

				break;
			// challenge sent
			case GameStatus.STATUS_CHALLENGESENT :
				// nichts zu tun

				break;
			// challenge finished
			case GameStatus.STATUS_CHALLENGEFINISHED :
				// nichts zu tun

				break;
			// award
			case GameStatus.STATUS_AWARD :
				showFrame(FRAME_AWARD);

				break;
			// unbekannt
			default :
				trace("onChangeStatus fehlgeschlagen: " + oldstatus + ", " + newstatus);
		}
	}

	/**
	 * springt zum uebergebenen frame und nimmt alle noetigen einstellungen vor
	 * @param frame Frame, zu dem gesprungen werden soll (siehe statische Felder FRAME_)
	 */
	public function showFrame(frame:String ):Void
	{
		// speichern
		setNextframe(frame);
		// je nach frame
		switch (frame) {
			// login
			case FRAME_LOGIN :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, this, "onShowLogin", []);

				break;
			// register
			case FRAME_REGISTER :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, this, "onShowRegister", []);

				break;
			// challenge
			case FRAME_CHALLENGE :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, this, "onShowChallenge", []);

				break;
			// difficulty
			case FRAME_DIFFICULTY :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, this, "onShowDifficulty", []);

				break;
			// statistics
			case FRAME_COMPARISON :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, null, "", []);

				break;
			// sudoku
			case FRAME_SUDOKU :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, this, "onShowSudoku", []);

				break;
			// gameover
			case FRAME_GAMEOVER :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, this, "onShowGameover", []);

				break;
			// award
			case FRAME_AWARD :
				// hinspringen
				navigate(frame, TIME_NAVIGATE, null, "", []);

				break;
			// unbekannt
			default :
				trace("showFrame fehlgeschlagen: " + frame);
		}
	}

	public function onShowLogin():Void
	{
		// box aufklappen
		login_mc.showBox();
	}

	public function onShowRegister():Void
	{
		// box aufklappen
		register_mc.showBox();
	}

	public function onShowChallenge():Void
	{
		// listen aktivieren
		challengelist_mc.setActive(true);
		awardlist_mc.setActive(true);
		highscorelist_mc.setActive(true);
	}

	public function onShowDifficulty():Void
	{
		// listen deaktivieren
		challengelist_mc.setActive(false);
		awardlist_mc.setActive(false);
		highscorelist_mc.setActive(false);
	}

	public function onShowSudoku():Void
	{
		// spiel-headline, je nachdem wer spielt / trainiert
		var headline:String = "";
		// unterscheidung training oder herausforderung
		switch (GameController.getInstance().isTraining()) {
			// training
			case true :
				// headline
				headline = "Training";

				break;
			// herausforderung
			case false :
				// headline 1
				headline = GameController.getInstance().getUser().getNickname();
				// headline 2
				headline += " vs. ";
				// headline 3
				headline += (GameController.getInstance().isOpponentRegistered() ? GameController.getInstance().getOpponent().getNickname() : GameController.getInstance().getOpponentemail());

				break;
		}
		// starten
		sudoku_mc.startGame(headline);
	}

	public function onShowGameover():Void
	{
		// box aufklappen
		gameover_mc.showBox();
	}

	public function showInstructions():Void
	{
		// navigation deaktivieren
		navigation_mc.setButtonsEnabled(false);
		// instructions einblenden
		instructions_mc.showBox();
	}

	public function hideInstructions():Void
	{
		// navigation aktivieren
		navigation_mc.setButtonsEnabled(true);
		// instructions ausblenden
		instructions_mc.hideBox();
	}

	public function showImprint():Void
	{
		// navigation deaktivieren
		navigation_mc.setButtonsEnabled(false);
		// imprint einblenden
		imprint_mc.showBox();
	}

	public function hideImprint():Void
	{
		// navigation aktivieren
		navigation_mc.setButtonsEnabled(true);
		// imprint ausblenden
		imprint_mc.hideBox();
	}

	public function showPreference():Void
	{
		// navigation deaktivieren
		navigation_mc.setButtonsEnabled(false);
		// preference einblenden
		preference_mc.showBox();
	}

	public function hidePreference():Void
	{
		// navigation aktivieren
		navigation_mc.setButtonsEnabled(true);
		// imprint ausblenden
		preference_mc.hideBox();
	}

	public function setNextframe(nextframe:String ):Void
	{
		// frame, der als naechster angezeigt werden soll
		this.nextframe = nextframe;
	}

	public function getNextframe():String
	{
		// frame, der als naechster angezeigt werden soll
		return this.nextframe;
	}

	private function navigate(frame:String, pause:Number, target:Object, method:String, args:Array ):Void
	{
		// hinspringen
		gotoAndStop(frame);
		// funktion zur uebergabe der parameter an ziel
		var invokeMethod = function(target:Object ) {
			// uebergeben
			target[method](args[0], args[1]);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause aufrufen
		var interval:Number = setInterval(invokeMethod, pause, target);
	}

}