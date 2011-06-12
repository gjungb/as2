/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventsgewinnspiel.ui.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.TasksUI extends MovieClip {
	
	private var myQuizUI:QuizUI;
	
	public function TasksUI() {
		myQuizUI = QuizUI(_parent);
	}
	
	public function onLoad():Void
	{
		// aufgabe des tages anzeigen
		gotoAndStop(myQuizUI.getCurrentday());
	}
	
	public function showTask(bool:Boolean ):Void
	{
		// alle textfelder und movieclips ein- / ausblenden
		for (var i:String in this) {
			// aktuelles object
			var o:Object = this[i];
			// movieclip
			if (o instanceof MovieClip && o != this && o != myQuizUI) o._visible = bool;
			// dynamisches textfeld
			if (o instanceof TextField && o._name.indexOf("_txt") > -1) o._visible = bool;
		}
	}
}