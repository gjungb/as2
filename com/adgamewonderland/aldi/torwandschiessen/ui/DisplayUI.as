/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.sudoku.ui.ClockUI;

class com.adgamewonderland.aldi.torwandschiessen.ui.DisplayUI {
	
	private var clock_mc:ClockUI;
	
	private var score_txt:TextField;
	
	private var level_txt:TextField;
	
	private var goals_txt:TextField;
	
	public function DisplayUI() {
		// textfelder linksbuendig
		score_txt.autoSize = "left";
		level_txt.autoSize = "left";
		goals_txt.autoSize = "left";
	}
	
	public function getClock():ClockUI
	{
		// zurueck geben
		return clock_mc;
	}
	
	public function showScore(score:Number ):Void
	{
		// anzeigen
		score_txt.text = String(score);
	}
	
	public function showLevel(level:Number ):Void
	{
		// anzeigen
		level_txt.text = String(level);	
	}
	
	public function showGoals(goals:Number ):Void
	{
		// anzeigen
		goals_txt.text = String(goals);	
	}
}