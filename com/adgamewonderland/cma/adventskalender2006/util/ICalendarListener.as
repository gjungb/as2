import com.adgamewonderland.cma.adventskalender2006.beans.*;

interface com.adgamewonderland.cma.adventskalender2006.util.ICalendarListener 
{

	public function onStartQuiz(quiz:Quiz):Void;
	
	public function onAnswerQuestion(answer:Answer):Void;

	public function onStopQuiz():Void;
}