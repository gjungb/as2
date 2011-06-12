/*
klasse:			FinishUI
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		31.01.2005
zuletzt bearbeitet:	31.01.2005
durch			gj
status:			final
*/

import com.adgamewonderland.skandia.akademietool.quiz.*;

class com.adgamewonderland.skandia.akademietool.quiz.FinishUI extends MovieClip {

	// Attributes
	
	private var myMetanavigationUI:MetanavigationUI;
	
	private var yes_btn:Button;
	
	private var no_btn:Button;
	
	// Operations

	function FinishUI()
	{
		// metanavigation
		myMetanavigationUI = MetanavigationUI(_parent);
	}
	
	public function closeMessage(bool:Boolean ):Void
	{
		// nummer des aktuellen frames
		var framenum:Number = 0;
		// abspielen verfolgen bis stop()
		onEnterFrame = function () {
			// wenn differenz zum zuletzt besuchten frame == 0, dann stop() erreicht
			if (_currentframe - framenum == 0) {
				// verfolgen beenden
				delete(onEnterFrame);
				// callback aufrufen
				myMetanavigationUI.finishAcknowledged(bool);
				// nach vorne springen
				gotoAndStop(1);
			}
			// neuen frame speichern
			framenum = _currentframe;
		};
		// hinspringen
		gotoAndPlay("frOut");	
	}
}