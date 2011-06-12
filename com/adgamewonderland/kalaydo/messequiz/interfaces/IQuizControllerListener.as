/**
 * @author gerd
 */
interface com.adgamewonderland.kalaydo.messequiz.interfaces.IQuizControllerListener {

	public function onTaskSolved(aCorrect:Boolean, aFigures:Array ):Void;

	public function onQuizFinished(aWon:Boolean ):Void;

	public function onGuessFinished(aWon:Boolean ):Void;

}