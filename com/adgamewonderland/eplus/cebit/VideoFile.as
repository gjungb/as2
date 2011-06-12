/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.eplus.cebit.VideoFile {
	
	private var myId:Number;
	
	private var mySrc:String;
	
	private var myTarget:MovieClip;
	
	private var myPercentLoaded:Number;
	
	private var myPlaying:Boolean;
	
	public function VideoFile(id:Number, src:String, target:MovieClip ) {
		// eindeutige id
		myId = id;
		// vollstaendiger dateiname
		mySrc = src;
		// mc, in dem das video angezeigt wird
		myTarget = target;
		// prozent der video datei geladen
		myPercentLoaded = 0;
		// wird die video datei gerade abgespielt
		myPlaying = false;
	}
	
	public function get id():Number
	{
		// eindeutige id
		return myId;
	}
	
	public function get src():String
	{
		// vollstaendiger dateiname
		return mySrc;
	}
	
	public function get target():MovieClip
	{
		// mc, in dem das video angezeigt wird
		return myTarget;
	}
	
	public function set percentloaded(num:Number ):Void
	{
		// prozent der video datei geladen
		myPercentLoaded = num;
	}
	
	public function get percentloaded():Number
	{
		// prozent der video datei geladen
		return myPercentLoaded;
	}
	
	public function get isfullyloaded():Boolean
	{
		// ist die video datei vollstaendig geladen
		return (percentloaded == 100);
	}
}