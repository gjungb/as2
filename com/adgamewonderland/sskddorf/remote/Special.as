/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.sskddorf.remote.*;

class com.adgamewonderland.sskddorf.remote.Special extends Item {
	
	private var myAlign:String;
	
	private var myFrame:String;
	
	public function Special()
	{
		// ausrichtung des labels
		myAlign = "center";
		// frame, in dem der link geoeffnet wird
		myFrame = "";
	}
	
	public function get align():String
	{
		return myAlign;
	}

	public function set align(align:String):Void
	{
		this.myAlign = align;
	}

	public function get frame():String
	{
		return myFrame;
	}

	public function set frame(frame:String):Void
	{
		this.myFrame = frame;
	}

}