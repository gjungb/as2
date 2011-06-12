/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.agw.racing.vehicle.TachometerUI extends MovieClip {
	
	private static var ANGLE_MIN:Number = 0;
	
	private static var ANGLE_MAX:Number = 300;
	
	private static var SPEED_MIN:Number = 0;
	
	private static var SPEED_MAX:Number = 280;
	
	private var needle_mc:MovieClip;
	
	private var speed_txt:TextField;
	
	public function TachometerUI() {
		// geschwindigkeitsanzeige
		speed_txt.autoSize = "right";
		// geschwindigkeit 0
		showSpeed(0);
	}
	
	public function showSpeed(relspeed:Number ):Void
	{
		// winkel fuer nadel
		var angle:Number = ANGLE_MIN + relspeed * ANGLE_MAX;
		// nadel drehen
		needle_mc._rotation = angle;
		// zahl fuer anzeige
		var speed:Number = Math.round(SPEED_MIN + relspeed * SPEED_MAX);
		// anzeigen
		speed_txt.text = String(speed);
	}
}