/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.BallaniUI extends MovieClip {
	
	public function BallaniUI() {
		
	}
	
	public function showBallani(inout:Boolean ):Void
	{
		// frame
		var frame:String = (inout ? "frIn" : "frOut");
		// abspielen
		gotoAndPlay(frame);
	}
}